"""
Endpoints analíticos del Dashboard Educativo.

Todos los endpoints:
- Están protegidos por JWT (``Depends(get_current_user)``).
- Solo leen del esquema ``dwh`` (lectura exclusiva).
- Soportan filtros opcionales de centro, curso académico y ciclo.
"""

from __future__ import annotations

from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import case, cast, distinct, func, Integer
from sqlalchemy.orm import Session

from app.api.dependencies import get_current_user, get_db
from app.models.datamart import (
    DimAdaptacion,
    DimCentro,
    DimCurso,
    DimEstudiante,
    DimTiempo,
    FactRendimientoAnual,
)
from app.models.user import User
from app.schemas.dashboard import (
    FilterOption,
    FiltersResponse,
    KPIsResponse,
    RedFlagsResponse,
    RiskByCycleItem,
    RiskByCycleResponse,
    RiskDistributionItem,
    RiskDistributionResponse,
    StudentListItem,
    StudentListResponse,
)

router = APIRouter(prefix="/dashboard", tags=["Dashboard Analítico"])


# =====================================================================
# Helpers internos
# =====================================================================


def _base_query(db: Session):  # noqa: ANN202
    """
    Query base que une ``fact_rendimiento_anual`` con todas las dimensiones
    necesarias para los endpoints del dashboard.
    """
    return (
        db.query(
            FactRendimientoAnual,
            DimEstudiante,
            DimCentro,
            DimCurso,
            DimTiempo,
            DimAdaptacion,
        )
        .join(
            DimEstudiante,
            FactRendimientoAnual.id_estudiante == DimEstudiante.id_estudiante,
        )
        .join(
            DimCentro,
            cast(FactRendimientoAnual.id_centro, Integer) == DimCentro.id_centro,
        )
        .join(
            DimCurso,
            cast(FactRendimientoAnual.id_curso, Integer) == DimCurso.id_curso,
        )
        .join(
            DimTiempo,
            cast(FactRendimientoAnual.id_tiempo, Integer) == DimTiempo.id_tiempo,
        )
        .join(
            DimAdaptacion,
            cast(FactRendimientoAnual.id_adaptacion, Integer)
            == DimAdaptacion.id_adaptacion,
        )
    )


def _apply_filters(
    query,  # noqa: ANN001
    *,
    cod_centro: str | None = None,
    curso_academico: str | None = None,
    cod_ciclo: str | None = None,
):  # noqa: ANN202
    """Aplica los filtros opcionales compartidos por todos los endpoints."""
    if cod_centro is not None:
        query = query.filter(DimCentro.cod_centro == cod_centro)
    if curso_academico is not None:
        query = query.filter(DimTiempo.curso_academico == curso_academico)
    if cod_ciclo is not None:
        query = query.filter(DimCurso.cod_ciclo == cod_ciclo)
    return query


# =====================================================================
# 1. KPIs GLOBALES
# =====================================================================


@router.get(
    "/kpis",
    response_model=KPIsResponse,
    summary="KPIs globales del overview",
    description=(
        "Calcula: total alumnos, % riesgo abandono (>50 pts), "
        "% abandono temprano y % fracaso escolar."
    ),
)
def get_kpis(
    cod_centro: Optional[str] = Query(None, description="Filtro por código de centro"),
    curso_academico: Optional[str] = Query(None, description="Filtro por año académico"),
    cod_ciclo: Optional[str] = Query(None, description="Filtro por código de ciclo"),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> KPIsResponse:
    """
    Reglas de negocio inferidas:

    - **Riesgo abandono**: ``riesgo_abandono > 50``
    - **Abandono temprano**: ``desfase_edad > 0`` (edad > 18 inferido por
      desfase positivo) Y ciclo NO es Bachillerato ni FP Superior.
    - **Fracaso escolar**: ``cod_ciclo = 'PRI'`` Y ``desfase_edad > 1``
      (aproximación: edad > 13 en Primaria, donde edad_ideal ≈ 12).
    """
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
    )

    # Códigos de ciclo excluidos para abandono temprano
    ciclos_post_obligatorios = ("BACH", "FPSUP", "FPB")

    result = query.with_entities(
        func.count(distinct(FactRendimientoAnual.id_estudiante)).label(
            "total_alumnos"
        ),
        # % Riesgo abandono (> 50 pts)
        func.count(distinct(
            case(
                (FactRendimientoAnual.riesgo_abandono > 50, FactRendimientoAnual.id_estudiante),
            )
        )).label("n_riesgo_abandono"),
        # Abandono temprano: edad > 18 (desfase > 0) y no en Bach/FP superior
        func.count(distinct(
            case(
                (
                    (FactRendimientoAnual.desfase_edad > 0)
                    & ~DimCurso.cod_ciclo.in_(ciclos_post_obligatorios),
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("n_abandono_temprano"),
        # Fracaso escolar: ciclo PRI y desfase_edad > 1 (edad > 13 en Primaria)
        func.count(distinct(
            case(
                (
                    (DimCurso.cod_ciclo == "PRI")
                    & (FactRendimientoAnual.desfase_edad > 1),
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("n_fracaso_escolar"),
    ).one()

    total = result.total_alumnos or 0
    if total == 0:
        return KPIsResponse(
            total_alumnos=0,
            pct_riesgo_abandono=0.0,
            pct_abandono_temprano=0.0,
            pct_fracaso_escolar=0.0,
        )

    return KPIsResponse(
        total_alumnos=total,
        pct_riesgo_abandono=round((result.n_riesgo_abandono / total) * 100, 2),
        pct_abandono_temprano=round((result.n_abandono_temprano / total) * 100, 2),
        pct_fracaso_escolar=round((result.n_fracaso_escolar / total) * 100, 2),
    )


# =====================================================================
# 2. GRÁFICOS VISUALES
# =====================================================================


@router.get(
    "/charts/risk-distribution",
    response_model=RiskDistributionResponse,
    summary="Distribución de riesgo de abandono",
    description="Conteo de alumnos por nivel de riesgo: Bajo (0-33), Medio (34-66), Alto (67-100).",
)
def get_risk_distribution(
    cod_centro: Optional[str] = Query(None),
    curso_academico: Optional[str] = Query(None),
    cod_ciclo: Optional[str] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> RiskDistributionResponse:
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
    )

    # Clasificar por niveles: Bajo (0-33), Medio (34-66), Alto (67-100)
    nivel_case = case(
        (FactRendimientoAnual.riesgo_abandono <= 33, "Bajo"),
        (FactRendimientoAnual.riesgo_abandono <= 66, "Medio"),
        else_="Alto",
    )

    rows = (
        query.with_entities(
            nivel_case.label("nivel"),
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label("count"),
        )
        .group_by(nivel_case)
        .all()
    )

    # Garantizar que siempre devolvemos los 3 niveles (incluso si count=0)
    levels_map: dict[str, int] = {"Bajo": 0, "Medio": 0, "Alto": 0}
    for row in rows:
        levels_map[row.nivel] = row.count

    return RiskDistributionResponse(
        data=[
            RiskDistributionItem(nivel=nivel, count=count)
            for nivel, count in levels_map.items()
        ]
    )


@router.get(
    "/charts/risk-by-cycle",
    response_model=RiskByCycleResponse,
    summary="Media de riesgo por ciclo educativo",
    description="Calcula la media de ``riesgo_abandono`` agrupada por ``cod_ciclo``.",
)
def get_risk_by_cycle(
    cod_centro: Optional[str] = Query(None),
    curso_academico: Optional[str] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> RiskByCycleResponse:
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
    )

    rows = (
        query.with_entities(
            DimCurso.cod_ciclo,
            DimCurso.nombre_ciclo,
            func.round(
                cast(func.avg(FactRendimientoAnual.riesgo_abandono), Integer), 2
            ).label("avg_riesgo"),
            func.count(distinct(FactRendimientoAnual.id_estudiante)).label(
                "total_alumnos"
            ),
        )
        .group_by(DimCurso.cod_ciclo, DimCurso.nombre_ciclo)
        .order_by(func.avg(FactRendimientoAnual.riesgo_abandono).desc())
        .all()
    )

    return RiskByCycleResponse(
        data=[
            RiskByCycleItem(
                cod_ciclo=row.cod_ciclo or "N/A",
                nombre_ciclo=row.nombre_ciclo or "Desconocido",
                avg_riesgo=float(row.avg_riesgo or 0),
                total_alumnos=row.total_alumnos,
            )
            for row in rows
        ]
    )


# =====================================================================
# 3. ALERTAS ROJAS (RED FLAGS)
# =====================================================================


@router.get(
    "/insights/red-flags",
    response_model=RedFlagsResponse,
    summary="Alertas rojas",
    description="Indicadores críticos que requieren atención inmediata.",
)
def get_red_flags(
    cod_centro: Optional[str] = Query(None),
    curso_academico: Optional[str] = Query(None),
    cod_ciclo: Optional[str] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> RedFlagsResponse:
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
    )

    result = query.with_entities(
        # Total repetidores
        func.count(distinct(
            case(
                (FactRendimientoAnual.is_repetidor.is_(True), FactRendimientoAnual.id_estudiante),
            )
        )).label("total_repetidores"),
        # Repetidores en 1.º o 2.º de Primaria
        func.count(distinct(
            case(
                (
                    FactRendimientoAnual.is_repetidor.is_(True)
                    & (DimCurso.cod_ciclo == "PRI")
                    & DimCurso.num_curso.in_([1, 2]),
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("repetidores_1_2_primaria"),
        # Suspensos sin repetir: tasa_aprobado < 0.5 y no repetidor
        func.count(distinct(
            case(
                (
                    (FactRendimientoAnual.tasa_aprobado < 0.5)
                    & FactRendimientoAnual.is_repetidor.is_(False),
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("suspensos_sin_repetir"),
        # Riesgo socioeconómico alto (>= 16)
        func.count(distinct(
            case(
                (
                    FactRendimientoAnual.riesgo_socioeconomico >= 16,
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("riesgo_socioeconomico_alto"),
        # Con adaptaciones curriculares (tipo no nulo y no vacío)
        func.count(distinct(
            case(
                (
                    DimAdaptacion.tipo.isnot(None)
                    & (DimAdaptacion.tipo != "")
                    & (DimAdaptacion.tipo != "Sin adaptación"),
                    FactRendimientoAnual.id_estudiante,
                ),
            )
        )).label("con_adaptaciones_curriculares"),
    ).one()

    return RedFlagsResponse(
        total_repetidores=result.total_repetidores or 0,
        repetidores_1_2_primaria=result.repetidores_1_2_primaria or 0,
        suspensos_sin_repetir=result.suspensos_sin_repetir or 0,
        riesgo_socioeconomico_alto=result.riesgo_socioeconomico_alto or 0,
        con_adaptaciones_curriculares=result.con_adaptaciones_curriculares or 0,
    )


# =====================================================================
# 4. LISTADO DE ALUMNOS EN RIESGO
# =====================================================================


@router.get(
    "/students",
    response_model=StudentListResponse,
    summary="Listado paginado de alumnos",
    description="Lista con filtro opcional ``riesgo_alto=true`` para mostrar solo alumnos con riesgo > 50.",
)
def get_students(
    cod_centro: Optional[str] = Query(None),
    curso_academico: Optional[str] = Query(None),
    cod_ciclo: Optional[str] = Query(None),
    riesgo_alto: bool = Query(False, description="Solo alumnos con riesgo_abandono > 50"),
    page: int = Query(1, ge=1, description="Número de página (1-indexed)"),
    page_size: int = Query(25, ge=1, le=100, description="Registros por página"),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> StudentListResponse:
    query = _base_query(db)
    query = _apply_filters(
        query,
        cod_centro=cod_centro,
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
    )

    if riesgo_alto:
        query = query.filter(FactRendimientoAnual.riesgo_abandono > 50)

    # Contar total antes de paginar
    total: int = query.with_entities(
        func.count(distinct(FactRendimientoAnual.id_estudiante))
    ).scalar() or 0

    # Seleccionar columnas y paginar
    rows = (
        query.with_entities(
            FactRendimientoAnual.id_estudiante,
            DimEstudiante.num_expediente,
            DimEstudiante.nombre,
            DimEstudiante.fecha_nacimiento,
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
        )
        .order_by(FactRendimientoAnual.riesgo_abandono.desc())
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    return StudentListResponse(
        total=total,
        page=page,
        page_size=page_size,
        data=[
            StudentListItem(
                id_estudiante=row.id_estudiante,
                num_expediente=row.num_expediente,
                nombre=row.nombre,
                fecha_nacimiento=row.fecha_nacimiento,
                nombre_centro=row.nombre_centro,
                cod_ciclo=row.cod_ciclo,
                nombre_ciclo=row.nombre_ciclo,
                num_curso=row.num_curso,
                tasa_aprobado=round(row.tasa_aprobado, 4) if row.tasa_aprobado is not None else None,
                is_repetidor=row.is_repetidor,
                desfase_edad=row.desfase_edad,
                riesgo_academico=round(row.riesgo_academico, 2) if row.riesgo_academico is not None else None,
                riesgo_socioeconomico=round(row.riesgo_socioeconomico, 2) if row.riesgo_socioeconomico is not None else None,
                riesgo_adaptacion=round(row.riesgo_adaptacion, 2) if row.riesgo_adaptacion is not None else None,
                riesgo_abandono=round(row.riesgo_abandono, 2) if row.riesgo_abandono is not None else None,
            )
            for row in rows
        ],
    )


# =====================================================================
# 5. FILTROS DINÁMICOS
# =====================================================================


@router.get(
    "/filters",
    response_model=FiltersResponse,
    summary="Filtros dinámicos para el dashboard",
    description="Devuelve valores únicos de centros, años académicos y ciclos para popular los selects del frontend.",
)
def get_filters(
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> FiltersResponse:
    # Centros
    centros_rows = (
        db.query(DimCentro.cod_centro, DimCentro.nombre)
        .distinct()
        .order_by(DimCentro.nombre)
        .all()
    )

    # Años académicos
    anios_rows = (
        db.query(DimTiempo.curso_academico)
        .distinct()
        .order_by(DimTiempo.curso_academico.desc())
        .all()
    )

    # Ciclos educativos
    ciclos_rows = (
        db.query(DimCurso.cod_ciclo, DimCurso.nombre_ciclo)
        .distinct()
        .order_by(DimCurso.nombre_ciclo)
        .all()
    )

    return FiltersResponse(
        centros=[
            FilterOption(value=row.cod_centro or "", label=row.nombre or "")
            for row in centros_rows
            if row.cod_centro
        ],
        cursos_academicos=[
            row.curso_academico
            for row in anios_rows
            if row.curso_academico
        ],
        ciclos=[
            FilterOption(value=row.cod_ciclo or "", label=row.nombre_ciclo or "")
            for row in ciclos_rows
            if row.cod_ciclo
        ],
    )
