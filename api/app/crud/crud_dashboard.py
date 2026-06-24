"""
Lógica CRUD y consultas analíticas para el Dashboard.
"""
from typing import List, Optional, Set, Dict, Any
from sqlalchemy import case, cast, distinct, func, Integer
from sqlalchemy.orm import Session

from app.models.datamart import (
    DimAdaptacion,
    DimCentro,
    DimCurso,
    DimEstudiante,
    DimTiempo,
    DimDemografiaFamiliar,
    FactRendimientoAnual,
)

# Constantes de negocio
RIESGO_SOCIO_ALTO_UMBRAL = 16
RIESGO_SOCIO_MEDIO_UMBRAL = 5
CICLOS_POST_OBLIGATORIOS = ("BAC", "FPM", "FPS")

def get_dynamic_risk_thresholds(db: Session) -> tuple[float, float]:
    """Obtiene dinámicamente los umbrales de riesgo medio (25%) y alto (50%) basados en el máximo histórico."""
    max_riesgo = db.query(func.max(FactRendimientoAnual.riesgo_abandono)).scalar() or 1.0
    return max_riesgo * 0.25, max_riesgo * 0.5

def _base_query(db: Session):
    """
    Query base que une fact_rendimiento_anual con todas las dimensiones necesarias.
    """
    return (
        db.query(
            FactRendimientoAnual,
            DimEstudiante,
            DimCentro,
            DimCurso,
            DimTiempo,
            DimAdaptacion,
            DimDemografiaFamiliar,
        )
        .join(DimEstudiante, FactRendimientoAnual.id_estudiante == DimEstudiante.id_estudiante)
        .join(DimCentro, cast(FactRendimientoAnual.id_centro, Integer) == DimCentro.id_centro)
        .join(DimCurso, cast(FactRendimientoAnual.id_curso, Integer) == DimCurso.id_curso)
        .join(DimTiempo, cast(FactRendimientoAnual.id_tiempo, Integer) == DimTiempo.id_tiempo)
        .join(DimAdaptacion, cast(FactRendimientoAnual.id_adaptacion, Integer) == DimAdaptacion.id_adaptacion)
        .join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)
    )

def _apply_filters(
    query,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
):
    """Aplica los filtros opcionales dinámicos (arrays)."""
    if cod_centro:
        query = query.filter(DimCentro.cod_centro.in_(cod_centro))
    if curso_academico:
        query = query.filter(DimTiempo.curso_academico.in_(curso_academico))
    if cod_ciclo:
        query = query.filter(DimCurso.cod_ciclo.in_(cod_ciclo))
    if tipo_centro:
        query = query.filter(DimCentro.tipo.in_(tipo_centro))
    return query

def get_a1(year_str: str) -> str:
    """Calcula el curso académico anterior (ej: 2023-2024 -> 2022-2023)"""
    try:
        p1, p2 = year_str.split("-")
        return f"{int(p1)-1}-{int(p2)-1}"
    except Exception:
        return year_str

def get_overview_kpis(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> Dict[str, Any]:
    
    if not curso_academico:
        max_year = db.query(func.max(DimTiempo.curso_academico)).scalar()
        curso_academico = [max_year] if max_year else []
    else:
        curso_academico = [sorted(curso_academico, reverse=True)[0]]

    if not curso_academico:
        # DB vacía
        return {}

    t0_years = set(curso_academico)
    t1_years = {get_a1(y) for y in t0_years}
    all_years = list(t0_years | t1_years)

    query = _base_query(db)
    # Filtramos todo MENOS curso_academico (que lo forzamos a T0 + T1)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro,
    )
    query = query.filter(DimTiempo.curso_academico.in_(all_years))

    _, umbral_alto = get_dynamic_risk_thresholds(db)

    # Construcción de las condiciones
    cond_riesgo_alto = FactRendimientoAnual.riesgo_abandono >= umbral_alto
    cond_is_repetidor = FactRendimientoAnual.is_repetidor == True
    cond_repeticion_1_2_pri = (FactRendimientoAnual.is_repetidor == True) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_suspensos_1_2_pri = (FactRendimientoAnual.num_suspensas > 0) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_adaptacion = (DimAdaptacion.id_adaptacion != 0) & DimAdaptacion.tipo.isnot(None) & (DimAdaptacion.tipo != "") & (DimAdaptacion.tipo != "Ninguna")
    cond_riesgo_socio_alto = FactRendimientoAnual.riesgo_socioeconomico >= RIESGO_SOCIO_ALTO_UMBRAL
    
    cond_suspensos = FactRendimientoAnual.num_suspensas > 0
    cond_desfase_edad = FactRendimientoAnual.desfase_edad > 0
    cond_brecha_digital = (DimDemografiaFamiliar.internet == False) | (DimDemografiaFamiliar.disponibilidad_ordenadores == "Ninguno")
    cond_bajo_estudios = DimDemografiaFamiliar.max_nivel_estudios.in_(["Sin Estudios", "Primarios"])

    results = query.with_entities(
        DimTiempo.curso_academico,
        func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        func.count(distinct(case((cond_riesgo_alto, FactRendimientoAnual.id_estudiante)))).label("riesgo_abandono_alto"),
        func.count(distinct(case((cond_is_repetidor, FactRendimientoAnual.id_estudiante)))).label("is_repetidor"),
        func.count(distinct(case((cond_repeticion_1_2_pri, FactRendimientoAnual.id_estudiante)))).label("repetidores_1_2_pri"),
        func.count(distinct(case((cond_suspensos_1_2_pri, FactRendimientoAnual.id_estudiante)))).label("suspensos_1_2_pri"),
        func.count(distinct(case((cond_adaptacion, FactRendimientoAnual.id_estudiante)))).label("adaptacion_curricular"),
        func.count(distinct(case((cond_riesgo_socio_alto, FactRendimientoAnual.id_estudiante)))).label("riesgo_socio_alto"),
        func.count(distinct(case((cond_suspensos, FactRendimientoAnual.id_estudiante)))).label("suspensos"),
        func.count(distinct(case((cond_desfase_edad, FactRendimientoAnual.id_estudiante)))).label("desfase_edad"),
        func.count(distinct(case((cond_brecha_digital, FactRendimientoAnual.id_estudiante)))).label("brecha_digital"),
        func.count(distinct(case((cond_bajo_estudios, FactRendimientoAnual.id_estudiante)))).label("bajo_nivel_estudios_padres"),
    ).group_by(DimTiempo.curso_academico).all()

    def empty_counters():
        return {
            "num_estudiantes": 0, "riesgo_abandono_alto": 0, "is_repetidor": 0, 
            "repetidores_1_2_pri": 0, "suspensos_1_2_pri": 0, "adaptacion_curricular": 0,
            "riesgo_socio_alto": 0, "suspensos": 0, "desfase_edad": 0,
            "brecha_digital": 0, "bajo_nivel_estudios_padres": 0
        }
        
    t0 = empty_counters()
    t1 = empty_counters()

    # Consolidamos filas según sean T0 o T-1
    for row in results:
        year = row.curso_academico
        if year in t0_years:
            for k in t0.keys():
                t0[k] += getattr(row, k)
        if year in t1_years:
            for k in t1.keys():
                t1[k] += getattr(row, k)

    # Pivoteo en un solo diccionario con el sufijo _a1
    final_dict = {}
    for key, value in t0.items():
        final_dict[key] = value
        final_dict[f"{key}_a1"] = t1[key]

    return final_dict


def get_risk_distribution(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro,
    )

    umbral_medio, umbral_alto = get_dynamic_risk_thresholds(db)

    nivel_case = case(
        (FactRendimientoAnual.riesgo_abandono >= umbral_alto, "Alto"),
        (FactRendimientoAnual.riesgo_abandono >= umbral_medio, "Medio"),
        else_="Bajo",
    )

    rows = (
        query.with_entities(
            nivel_case.label("nivel_riesgo"),
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        )
        .group_by(nivel_case)
        .all()
    )

    levels_map = {"Bajo": 0, "Medio": 0, "Alto": 0}
    for row in rows:
        levels_map[row.nivel_riesgo] = row.num_estudiantes

    return [
        {"nivel_riesgo": k, "num_estudiantes": v}
        for k, v in levels_map.items()
    ]


def get_risk_by_cycle(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro,
    )

    _, umbral_alto = get_dynamic_risk_thresholds(db)
    cond_riesgo_critico = FactRendimientoAnual.riesgo_abandono >= umbral_alto

    rows = (
        query.with_entities(
            DimCurso.cod_ciclo,
            func.count(distinct(case((cond_riesgo_critico, FactRendimientoAnual.id_estudiante)))).label("riesgo_abandono_critico"),
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        )
        .group_by(DimCurso.cod_ciclo)
        .all()
    )

    return [
        {
            "cod_ciclo": row.cod_ciclo or "N/A",
            "riesgo_abandono_critico": row.riesgo_abandono_critico,
            "num_estudiantes": row.num_estudiantes,
        }
        for row in rows
    ]


def get_trend(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    # NOTA: En la tendencia no filtramos por curso_academico, queremos el histórico
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro,
    )

    umbral_medio, umbral_alto = get_dynamic_risk_thresholds(db)

    cond_riesgo_alto = FactRendimientoAnual.riesgo_abandono >= umbral_alto
    cond_riesgo_medio = (FactRendimientoAnual.riesgo_abandono >= umbral_medio) & (FactRendimientoAnual.riesgo_abandono < umbral_alto)
    cond_riesgo_bajo = FactRendimientoAnual.riesgo_abandono < umbral_medio

    rows = (
        query.with_entities(
            DimTiempo.curso_academico,
            func.count(distinct(case((cond_riesgo_alto, FactRendimientoAnual.id_estudiante)))).label("riesgo_alto"),
            func.count(distinct(case((cond_riesgo_medio, FactRendimientoAnual.id_estudiante)))).label("riesgo_medio"),
            func.count(distinct(case((cond_riesgo_bajo, FactRendimientoAnual.id_estudiante)))).label("riesgo_bajo"),
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        )
        .group_by(DimTiempo.curso_academico)
        .order_by(DimTiempo.curso_academico.desc())
        .limit(5)
        .all()
    )

    # Ordenamos de más antiguo a más reciente para el gráfico
    data = [
        {
            "curso_academico": row.curso_academico or "N/A",
            "riesgo_alto": row.riesgo_alto,
            "riesgo_medio": row.riesgo_medio,
            "riesgo_bajo": row.riesgo_bajo,
            "num_estudiantes": row.num_estudiantes,
        }
        for row in reversed(rows)
    ]
    return data


# =====================================================================
# 3. SECCIÓN 2: CONTEXTO SOCIOECONÓMICO
# =====================================================================

def get_socioeconomic_kpis(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> Dict[str, Any]:
    
    if not curso_academico:
        max_year = db.query(func.max(DimTiempo.curso_academico)).scalar()
        curso_academico = [max_year] if max_year else []

    if not curso_academico:
        return {}

    t0_years = set(curso_academico)
    t1_years = {get_a1(y) for y in t0_years}
    all_years = list(t0_years | t1_years)

    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro,
    )
    query = query.filter(DimTiempo.curso_academico.in_(all_years))

    from app.models.datamart import DimDemografiaFamiliar
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)

    # Condiciones
    cond_renta_baja = DimDemografiaFamiliar.nivel_renta.in_(["Baja", "Muy Baja"])
    cond_brecha_digital = (DimDemografiaFamiliar.disponibilidad_ordenadores == "Ninguno") & (DimDemografiaFamiliar.internet == False)
    cond_sin_estudios_secundarios = DimDemografiaFamiliar.max_nivel_estudios.in_(["Sin Estudios", "Estudios Primarios"])

    results = query.with_entities(
        DimTiempo.curso_academico,
        func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        func.count(distinct(case((cond_renta_baja, FactRendimientoAnual.id_estudiante)))).label("nivel_renta_baja"),
        func.count(distinct(case((cond_brecha_digital, FactRendimientoAnual.id_estudiante)))).label("brecha_digital_extrema"),
        func.count(distinct(case((cond_sin_estudios_secundarios, FactRendimientoAnual.id_estudiante)))).label("sin_estudios_secundarios"),
    ).group_by(DimTiempo.curso_academico).all()

    def empty_counters():
        return {
            "num_estudiantes": 0, "nivel_renta_baja": 0,
            "brecha_digital_extrema": 0, "sin_estudios_secundarios": 0
        }
        
    t0 = empty_counters()
    t1 = empty_counters()

    for row in results:
        year = row.curso_academico
        if year in t0_years:
            t0["num_estudiantes"] += row.num_estudiantes
            t0["nivel_renta_baja"] += row.nivel_renta_baja
            t0["brecha_digital_extrema"] += row.brecha_digital_extrema
            t0["sin_estudios_secundarios"] += row.sin_estudios_secundarios
        if year in t1_years:
            t1["num_estudiantes"] += row.num_estudiantes
            t1["nivel_renta_baja"] += row.nivel_renta_baja
            t1["brecha_digital_extrema"] += row.brecha_digital_extrema
            t1["sin_estudios_secundarios"] += row.sin_estudios_secundarios

    final_dict = {}
    for key, value in t0.items():
        final_dict[key] = value
        final_dict[f"{key}_a1"] = t1[key]

    return final_dict


def get_digital_gap(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    query = _apply_filters(query, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    
    from app.models.datamart import DimDemografiaFamiliar
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)

    rows = (
        query.with_entities(
            DimDemografiaFamiliar.disponibilidad_ordenadores,
            DimDemografiaFamiliar.internet,
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
            func.count(distinct(case((FactRendimientoAnual.tasa_aprobado >= 0.5, FactRendimientoAnual.id_estudiante)))).label("num_aprobados"),
        )
        .group_by(DimDemografiaFamiliar.disponibilidad_ordenadores, DimDemografiaFamiliar.internet)
        .all()
    )

    return [
        {
            "ordenadores_suficientes": row.disponibilidad_ordenadores != "Ninguno" if row.disponibilidad_ordenadores else False,
            "conexion_internet": bool(row.internet),
            "num_estudiantes": row.num_estudiantes,
            "num_aprobados": row.num_aprobados,
        }
        for row in rows
    ]


def get_parent_education(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    query = _apply_filters(query, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    
    from app.models.datamart import DimDemografiaFamiliar
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)

    _, umbral_alto = get_dynamic_risk_thresholds(db)
    cond_riesgo_critico = FactRendimientoAnual.riesgo_abandono >= umbral_alto

    rows = (
        query.with_entities(
            DimDemografiaFamiliar.max_nivel_estudios,
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
            func.count(distinct(case((cond_riesgo_critico, FactRendimientoAnual.id_estudiante)))).label("riesgo_abandono_critico"),
        )
        .group_by(DimDemografiaFamiliar.max_nivel_estudios)
        .all()
    )

    return [
        {
            "max_nivel_estudios_padres": row.max_nivel_estudios or "Desconocido",
            "num_estudiantes": row.num_estudiantes,
            "riesgo_abandono_critico": row.riesgo_abandono_critico,
        }
        for row in rows
    ]


def get_income_risk(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
) -> List[Dict[str, Any]]:
    
    query = _base_query(db)
    query = _apply_filters(query, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    
    from app.models.datamart import DimDemografiaFamiliar
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)

    _, umbral_alto = get_dynamic_risk_thresholds(db)
    cond_riesgo_critico = FactRendimientoAnual.riesgo_abandono >= umbral_alto

    rows = (
        query.with_entities(
            DimDemografiaFamiliar.nivel_renta,
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
            func.sum(FactRendimientoAnual.num_suspensas).label("num_suspensas"),
            func.count(distinct(case((cond_riesgo_critico, FactRendimientoAnual.id_estudiante)))).label("riesgo_abandono_critico"),
        )
        .group_by(DimDemografiaFamiliar.nivel_renta)
        .all()
    )

    return [
        {
            "nivel_renta": row.nivel_renta or "Desconocida",
            "num_estudiantes": row.num_estudiantes,
            "num_suspensas": int(row.num_suspensas or 0),
            "riesgo_abandono_critico": row.riesgo_abandono_critico,
        }
        for row in rows
    ]


# =====================================================================
# 4. LISTADO DE ALUMNOS Y FILTROS
# =====================================================================

def get_student_list(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
    riesgo_nivel: Optional[str] = None,
    is_repetidor: Optional[bool] = None,
    alerta_brecha_digital: Optional[bool] = None,
    alerta_renta_baja: Optional[bool] = None,
    alerta_riesgo_alto: Optional[bool] = None,
    sort_by: str = "riesgo_abandono",
    sort_desc: bool = True,
    page: int = 1,
    page_size: int = 25,
) -> Dict[str, Any]:
    
    from app.models.datamart import DimDemografiaFamiliar

    query = _base_query(db)
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)
    query = _apply_filters(query, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)

    umbral_medio, umbral_alto = get_dynamic_risk_thresholds(db)

    # Filtros extra de la tabla interactiva
    if riesgo_nivel == "Alto":
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_alto)
    elif riesgo_nivel == "Medio":
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_medio, FactRendimientoAnual.riesgo_abandono < umbral_alto)
    elif riesgo_nivel == "Bajo":
        query = query.filter(FactRendimientoAnual.riesgo_abandono < umbral_medio)

    if is_repetidor is not None:
        query = query.filter(FactRendimientoAnual.is_repetidor == is_repetidor)

    # Filtros Cruzados (Cross-Filtering) desde el Dashboard
    if alerta_brecha_digital:
        query = query.filter((DimDemografiaFamiliar.disponibilidad_ordenadores == "Ninguno") & (DimDemografiaFamiliar.internet == False))

    if alerta_renta_baja:
        query = query.filter(DimDemografiaFamiliar.nivel_renta.in_(["Baja", "Muy Baja"]))
        
    if alerta_riesgo_alto:
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_alto)

    # Si no se filtra por año, cogemos el más reciente para no duplicar alumnos
    if not curso_academico:
        latest_year = db.query(func.max(DimTiempo.curso_academico)).scalar()
        if latest_year:
            query = query.filter(DimTiempo.curso_academico == latest_year)

    # Total para la paginación
    total: int = query.with_entities(func.count(distinct(FactRendimientoAnual.id_estudiante))).scalar() or 0

    sort_column_map = {
        "num_expediente": DimEstudiante.num_expediente,
        "nombre_centro": DimCentro.nombre,
        "nombre_ciclo": DimCurso.nombre_ciclo,
        "num_curso": DimCurso.num_curso,
        "tasa_aprobado": FactRendimientoAnual.tasa_aprobado,
        "riesgo_abandono": FactRendimientoAnual.riesgo_abandono,
    }
    
    order_col = sort_column_map.get(sort_by, FactRendimientoAnual.riesgo_abandono)
    if sort_desc:
        order_col = order_col.desc()
    else:
        order_col = order_col.asc()

    rows = (
        query.with_entities(
            FactRendimientoAnual.id_estudiante,
            DimEstudiante.num_expediente,
            DimCentro.nombre.label("nombre_centro"),
            DimCurso.cod_ciclo,
            DimCurso.nombre_ciclo,
            DimCurso.num_curso,
            FactRendimientoAnual.tasa_aprobado,
            FactRendimientoAnual.is_repetidor,
            FactRendimientoAnual.desfase_edad,
            FactRendimientoAnual.riesgo_academico,
            FactRendimientoAnual.riesgo_socioeconomico,
            FactRendimientoAnual.riesgo_adaptacion,
            FactRendimientoAnual.riesgo_abandono,
            DimDemografiaFamiliar.disponibilidad_ordenadores,
            DimDemografiaFamiliar.internet,
            DimDemografiaFamiliar.nivel_renta,
        )
        .order_by(order_col)
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    data = []
    for r in rows:
        is_brecha_digital = (r.disponibilidad_ordenadores == "Ninguno" and r.internet == False)
        is_renta_baja = (r.nivel_renta in ["Baja", "Muy Baja"])
        
        riesgo_total = r.riesgo_abandono or 0
        if riesgo_total >= umbral_alto:
            nivel = "Alto"
        elif riesgo_total >= umbral_medio:
            nivel = "Medio"
        else:
            nivel = "Bajo"

        data.append({
            "id_estudiante": r.id_estudiante,
            "num_expediente": r.num_expediente,
            "nombre_centro": r.nombre_centro,
            "cod_ciclo": r.cod_ciclo,
            "nombre_ciclo": r.nombre_ciclo,
            "num_curso": r.num_curso,
            "tasa_aprobado": round(r.tasa_aprobado, 4) if r.tasa_aprobado is not None else None,
            "desfase_edad": r.desfase_edad,
            "desglose_riesgo": {
                "academico_pts": round(r.riesgo_academico, 2) if r.riesgo_academico is not None else None,
                "socioeconomico_pts": round(r.riesgo_socioeconomico, 2) if r.riesgo_socioeconomico is not None else None,
                "adaptacion_pts": round(r.riesgo_adaptacion, 2) if r.riesgo_adaptacion is not None else None,
                "total_pts": round(r.riesgo_abandono, 2) if r.riesgo_abandono is not None else None,
                "nivel_riesgo": nivel
            },
            "alertas": {
                "brecha_digital": is_brecha_digital,
                "renta_baja": is_renta_baja,
                "is_repetidor": r.is_repetidor or False
            }
        })

    return {
        "total": total,
        "page": page,
        "page_size": page_size,
        "data": data,
    }


def get_dynamic_filters(db: Session) -> Dict[str, Any]:
    """Obtiene los valores únicos de las dimensiones para popular los <select> del frontend."""
    centros_rows = db.query(DimCentro.cod_centro, DimCentro.nombre).distinct().order_by(DimCentro.nombre).all()
    anios_rows = db.query(DimTiempo.curso_academico).distinct().order_by(DimTiempo.curso_academico.desc()).all()
    ciclos_rows = db.query(DimCurso.cod_ciclo, DimCurso.nombre_ciclo).distinct().order_by(DimCurso.nombre_ciclo).all()
    tipos_rows = db.query(DimCentro.tipo).filter(DimCentro.tipo.isnot(None)).distinct().order_by(DimCentro.tipo).all()

    return {
        "centros": [{"value": r.cod_centro, "label": r.nombre} for r in centros_rows],
        "cursos_academicos": [r.curso_academico for r in anios_rows],
        "ciclos": [{"value": r.cod_ciclo, "label": r.nombre_ciclo} for r in ciclos_rows],
        "tipos_centro": [r.tipo for r in tipos_rows],
    }

# =====================================================================
# 5. RANKING DE CENTROS (MACRO)
# =====================================================================
import statistics

def get_centros_ranking(
    db: Session,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
    page: int = 1,
    page_size: int = 25,
) -> Dict[str, Any]:
    
    from app.models.datamart import DimDemografiaFamiliar

    query = _base_query(db)
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)
    query = _apply_filters(query, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)

    _, umbral_alto = get_dynamic_risk_thresholds(db)

    # Condiciones
    cond_riesgo_alto = FactRendimientoAnual.riesgo_abandono >= umbral_alto
    cond_is_repetidor = FactRendimientoAnual.is_repetidor == True
    cond_repeticion_1_2_pri = (FactRendimientoAnual.is_repetidor == True) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_suspensos_1_2_pri = (FactRendimientoAnual.num_suspensas > 0) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_adaptacion = (DimAdaptacion.id_adaptacion != 0) & DimAdaptacion.tipo.isnot(None) & (DimAdaptacion.tipo != "") & (DimAdaptacion.tipo != "Ninguna")
        {
            "nivel_renta": row.nivel_renta or "Desconocida",
            "num_estudiantes": row.num_estudiantes,
            "num_suspensas": int(row.num_suspensas or 0),
            "riesgo_abandono_critico": row.riesgo_abandono_critico,
        }
        for row in rows
    ]


# =====================================================================
# 4. LISTADO DE ALUMNOS Y FILTROS
# =====================================================================

def get_student_list(
    db: Session,
    cod_centro: Optional[List[str]] = None,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
    riesgo_nivel: Optional[str] = None,
    is_repetidor: Optional[bool] = None,
    alerta_brecha_digital: Optional[bool] = None,
    alerta_renta_baja: Optional[bool] = None,
    alerta_riesgo_alto: Optional[bool] = None,
    sort_by: str = "riesgo_abandono",
    sort_desc: bool = True,
    page: int = 1,
    page_size: int = 25,
) -> Dict[str, Any]:
    
    from app.models.datamart import DimDemografiaFamiliar

    query = _base_query(db)
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)
    query = _apply_filters(query, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)

    umbral_medio, umbral_alto = get_dynamic_risk_thresholds(db)

    # Filtros extra de la tabla interactiva
    if riesgo_nivel == "Alto":
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_alto)
    elif riesgo_nivel == "Medio":
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_medio, FactRendimientoAnual.riesgo_abandono < umbral_alto)
    elif riesgo_nivel == "Bajo":
        query = query.filter(FactRendimientoAnual.riesgo_abandono < umbral_medio)

    if is_repetidor is not None:
        query = query.filter(FactRendimientoAnual.is_repetidor == is_repetidor)

    # Filtros Cruzados (Cross-Filtering) desde el Dashboard
    if alerta_brecha_digital:
        query = query.filter((DimDemografiaFamiliar.disponibilidad_ordenadores == "Ninguno") & (DimDemografiaFamiliar.internet == False))

    if alerta_renta_baja:
        query = query.filter(DimDemografiaFamiliar.nivel_renta.in_(["Baja", "Muy Baja"]))
        
    if alerta_riesgo_alto:
        query = query.filter(FactRendimientoAnual.riesgo_abandono >= umbral_alto)

    # Si no se filtra por año, cogemos el más reciente para no duplicar alumnos
    if not curso_academico:
        latest_year = db.query(func.max(DimTiempo.curso_academico)).scalar()
        if latest_year:
            query = query.filter(DimTiempo.curso_academico == latest_year)

    # Total para la paginación
    total: int = query.with_entities(func.count(distinct(FactRendimientoAnual.id_estudiante))).scalar() or 0

    sort_column_map = {
        "num_expediente": DimEstudiante.num_expediente,
        "nombre_centro": DimCentro.nombre,
        "nombre_ciclo": DimCurso.nombre_ciclo,
        "num_curso": DimCurso.num_curso,
        "tasa_aprobado": FactRendimientoAnual.tasa_aprobado,
        "riesgo_abandono": FactRendimientoAnual.riesgo_abandono,
    }
    
    order_col = sort_column_map.get(sort_by, FactRendimientoAnual.riesgo_abandono)
    if sort_desc:
        order_col = order_col.desc()
    else:
        order_col = order_col.asc()

    rows = (
        query.with_entities(
            FactRendimientoAnual.id_estudiante,
            DimEstudiante.num_expediente,
            DimCentro.nombre.label("nombre_centro"),
            DimCurso.cod_ciclo,
            DimCurso.nombre_ciclo,
            DimCurso.num_curso,
            FactRendimientoAnual.tasa_aprobado,
            FactRendimientoAnual.is_repetidor,
            FactRendimientoAnual.desfase_edad,
            FactRendimientoAnual.riesgo_academico,
            FactRendimientoAnual.riesgo_socioeconomico,
            FactRendimientoAnual.riesgo_adaptacion,
            FactRendimientoAnual.riesgo_abandono,
            DimDemografiaFamiliar.disponibilidad_ordenadores,
            DimDemografiaFamiliar.internet,
            DimDemografiaFamiliar.nivel_renta,
        )
        .order_by(order_col)
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    data = []
    for r in rows:
        is_brecha_digital = (r.disponibilidad_ordenadores == "Ninguno" and r.internet == False)
        is_renta_baja = (r.nivel_renta in ["Baja", "Muy Baja"])
        
        riesgo_total = r.riesgo_abandono or 0
        if riesgo_total >= umbral_alto:
            nivel = "Alto"
        elif riesgo_total >= umbral_medio:
            nivel = "Medio"
        else:
            nivel = "Bajo"

        data.append({
            "id_estudiante": r.id_estudiante,
            "num_expediente": r.num_expediente,
            "nombre_centro": r.nombre_centro,
            "cod_ciclo": r.cod_ciclo,
            "nombre_ciclo": r.nombre_ciclo,
            "num_curso": r.num_curso,
            "tasa_aprobado": round(r.tasa_aprobado, 4) if r.tasa_aprobado is not None else None,
            "desfase_edad": r.desfase_edad,
            "desglose_riesgo": {
                "academico_pts": round(r.riesgo_academico, 2) if r.riesgo_academico is not None else None,
                "socioeconomico_pts": round(r.riesgo_socioeconomico, 2) if r.riesgo_socioeconomico is not None else None,
                "adaptacion_pts": round(r.riesgo_adaptacion, 2) if r.riesgo_adaptacion is not None else None,
                "total_pts": round(r.riesgo_abandono, 2) if r.riesgo_abandono is not None else None,
                "nivel_riesgo": nivel
            },
            "alertas": {
                "brecha_digital": is_brecha_digital,
                "renta_baja": is_renta_baja,
                "is_repetidor": r.is_repetidor or False
            }
        })

    return {
        "total": total,
        "page": page,
        "page_size": page_size,
        "data": data,
    }


def get_dynamic_filters(db: Session) -> Dict[str, Any]:
    """Obtiene los valores únicos de las dimensiones para popular los <select> del frontend."""
    centros_rows = db.query(DimCentro.cod_centro, DimCentro.nombre).distinct().order_by(DimCentro.nombre).all()
    anios_rows = db.query(DimTiempo.curso_academico).distinct().order_by(DimTiempo.curso_academico.desc()).all()
    ciclos_rows = db.query(DimCurso.cod_ciclo, DimCurso.nombre_ciclo).distinct().order_by(DimCurso.nombre_ciclo).all()
    tipos_rows = db.query(DimCentro.tipo).filter(DimCentro.tipo.isnot(None)).distinct().order_by(DimCentro.tipo).all()

    return {
        "centros": [{"value": r.cod_centro, "label": r.nombre} for r in centros_rows],
        "cursos_academicos": [r.curso_academico for r in anios_rows],
        "ciclos": [{"value": r.cod_ciclo, "label": r.nombre_ciclo} for r in ciclos_rows],
        "tipos_centro": [r.tipo for r in tipos_rows],
    }

# =====================================================================
# 5. RANKING DE CENTROS (MACRO)
# =====================================================================
import statistics

def get_centros_ranking(
    db: Session,
    curso_academico: Optional[List[str]] = None,
    cod_ciclo: Optional[List[str]] = None,
    tipo_centro: Optional[List[str]] = None,
    page: int = 1,
    page_size: int = 25,
) -> Dict[str, Any]:
    
    from app.models.datamart import DimDemografiaFamiliar

    if not curso_academico:
        max_year = db.query(func.max(DimTiempo.curso_academico)).scalar()
        curso_academico = [max_year] if max_year else []
    else:
        # Si se pasan varios, forzamos a coger solo el más reciente para no romper T-1
        curso_academico = [sorted(curso_academico, reverse=True)[0]]

    if not curso_academico:
        return {"total": 0, "page": page, "page_size": page_size, "data": []}

    t0_years = set(curso_academico)
    t1_years = {get_a1(y) for y in t0_years}
    all_years = list(t0_years | t1_years)

    query = _base_query(db)
    query = query.join(DimDemografiaFamiliar, cast(FactRendimientoAnual.id_demografia_familiar, Integer) == DimDemografiaFamiliar.id_demografia_familiar)
    query = _apply_filters(query, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    query = query.filter(DimTiempo.curso_academico.in_(all_years))

    _, umbral_alto = get_dynamic_risk_thresholds(db)

    # Condiciones
    cond_riesgo_alto = FactRendimientoAnual.riesgo_abandono >= umbral_alto
    cond_is_repetidor = FactRendimientoAnual.is_repetidor == True
    cond_repeticion_1_2_pri = (FactRendimientoAnual.is_repetidor == True) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_suspensos_1_2_pri = (FactRendimientoAnual.num_suspensas > 0) & (DimCurso.cod_ciclo == "PRI") & DimCurso.num_curso.in_([1, 2])
    cond_adaptacion = (DimAdaptacion.id_adaptacion != 0) & DimAdaptacion.tipo.isnot(None) & (DimAdaptacion.tipo != "") & (DimAdaptacion.tipo != "Ninguna")
    cond_riesgo_socio_alto = FactRendimientoAnual.riesgo_socioeconomico >= RIESGO_SOCIO_ALTO_UMBRAL
    
    cond_suspensos = FactRendimientoAnual.num_suspensas > 0
    cond_desfase_edad = FactRendimientoAnual.desfase_edad > 0
    cond_brecha_digital = (DimDemografiaFamiliar.internet == False) | (DimDemografiaFamiliar.disponibilidad_ordenadores == "Ninguno")
    cond_bajo_estudios = DimDemografiaFamiliar.max_nivel_estudios.in_(["Sin Estudios", "Primarios"])

    rows = query.with_entities(
        DimTiempo.curso_academico,
        DimCentro.id_centro,
        DimCentro.cod_centro,
        DimCentro.nombre.label("nombre_centro"),
        DimCentro.localidad,
        DimCentro.tipo.label("tipo_centro"),
        DimCentro.naturaleza,
        func.count(distinct(FactRendimientoAnual.id_estudiante)).label("num_estudiantes"),
        func.count(distinct(case((cond_riesgo_alto, FactRendimientoAnual.id_estudiante)))).label("riesgo_abandono_alto"),
        func.count(distinct(case((cond_is_repetidor, FactRendimientoAnual.id_estudiante)))).label("is_repetidor"),
        func.count(distinct(case((cond_repeticion_1_2_pri, FactRendimientoAnual.id_estudiante)))).label("repetidores_1_2_pri"),
        func.count(distinct(case((cond_suspensos_1_2_pri, FactRendimientoAnual.id_estudiante)))).label("suspensos_1_2_pri"),
        func.count(distinct(case((cond_adaptacion, FactRendimientoAnual.id_estudiante)))).label("adaptacion_curricular"),
        func.count(distinct(case((cond_riesgo_socio_alto, FactRendimientoAnual.id_estudiante)))).label("riesgo_socio_alto"),
        func.count(distinct(case((cond_suspensos, FactRendimientoAnual.id_estudiante)))).label("suspensos"),
        func.count(distinct(case((cond_desfase_edad, FactRendimientoAnual.id_estudiante)))).label("desfase_edad"),
        func.count(distinct(case((cond_brecha_digital, FactRendimientoAnual.id_estudiante)))).label("brecha_digital"),
        func.count(distinct(case((cond_bajo_estudios, FactRendimientoAnual.id_estudiante)))).label("bajo_nivel_estudios_padres"),
    ).group_by(
        DimTiempo.curso_academico, DimCentro.id_centro, DimCentro.cod_centro, DimCentro.nombre, 
        DimCentro.localidad, DimCentro.tipo, DimCentro.naturaleza
    ).all()

    if not rows:
        return {"total": 0, "page": page, "page_size": page_size, "data": []}

    metrics = [
        "riesgo_abandono_alto", "is_repetidor", "repetidores_1_2_pri", "suspensos_1_2_pri", 
        "adaptacion_curricular", "riesgo_socio_alto", "suspensos", "desfase_edad", 
        "brecha_digital", "bajo_nivel_estudios_padres"
    ]

    centros_t0 = {}
    centros_t1 = {}
    
    for r in rows:
        num_est = r.num_estudiantes or 1
        c_dict = {
            "id_centro": r.id_centro,
            "cod_centro": r.cod_centro,
            "nombre_centro": r.nombre_centro,
            "localidad": r.localidad,
            "tipo_centro": r.tipo_centro,
            "naturaleza": r.naturaleza,
            "num_estudiantes": r.num_estudiantes,
            "riesgo_abandono_alto": r.riesgo_abandono_alto,
            "is_repetidor": r.is_repetidor,
            "repetidores_1_2_pri": r.repetidores_1_2_pri,
            "suspensos_1_2_pri": r.suspensos_1_2_pri,
            "adaptacion_curricular": r.adaptacion_curricular,
            "riesgo_socioeconomico_alto": r.riesgo_socio_alto,
            "suspensos": r.suspensos,
            "desfase_edad": r.desfase_edad,
            "brecha_digital": r.brecha_digital,
            "bajo_nivel_estudios_padres": r.bajo_nivel_estudios_padres,
            "_pct": {
                "riesgo_abandono_alto": r.riesgo_abandono_alto / num_est,
                "is_repetidor": r.is_repetidor / num_est,
                "repetidores_1_2_pri": r.repetidores_1_2_pri / num_est,
                "suspensos_1_2_pri": r.suspensos_1_2_pri / num_est,
                "adaptacion_curricular": r.adaptacion_curricular / num_est,
                "riesgo_socio_alto": r.riesgo_socio_alto / num_est,
                "suspensos": r.suspensos / num_est,
                "desfase_edad": r.desfase_edad / num_est,
                "brecha_digital": r.brecha_digital / num_est,
                "bajo_nivel_estudios_padres": r.bajo_nivel_estudios_padres / num_est,
            }
        }
        
        if r.curso_academico in t0_years:
            centros_t0[r.id_centro] = c_dict
        elif r.curso_academico in t1_years:
            centros_t1[r.id_centro] = c_dict

    def calculate_medians(centros_dict):
        median_thresholds = {}
        for m in metrics:
            values = [c["_pct"][m] for c in centros_dict.values()]
            median_thresholds[m] = statistics.median(values) if values else 0
        return median_thresholds

    median_t0 = calculate_medians(centros_t0)
    median_t1 = calculate_medians(centros_t1)

    # Calculate index
    for c in centros_t0.values():
        c["indice_riesgo_centro"] = sum(1 for m in metrics if c["_pct"][m] > median_t0[m])
    for c in centros_t1.values():
        c["indice_riesgo_centro"] = sum(1 for m in metrics if c["_pct"][m] > median_t1[m])

    # Merge t1 into t0. We only return centers present in T0 (active centers).
    final_data = []
    for id_centro, c0 in centros_t0.items():
        c1 = centros_t1.get(id_centro, {})
        c0["indice_riesgo_centro_a1"] = c1.get("indice_riesgo_centro")
        final_data.append(c0)

    # Sort descending by indice_riesgo_centro, then num_estudiantes
    final_data.sort(key=lambda x: (x["indice_riesgo_centro"], x["num_estudiantes"]), reverse=True)

    total = len(final_data)
    start = (page - 1) * page_size
    end = start + page_size
    return {
        "total": total,
        "page": page,
        "page_size": page_size,
        "data": final_data[start:end],
    }
