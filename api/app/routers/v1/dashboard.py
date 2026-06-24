"""
Endpoints analíticos del Dashboard Educativo.

Todos los endpoints:
- Están protegidos por JWT (``Depends(get_current_user)``).
- Delegan la lógica SQL pesada a la capa CRUD.
- Soportan selección múltiple de filtros vía query params (?cod_centro=A&cod_centro=B).
"""

from __future__ import annotations

from typing import List, Optional

from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.routers.dependencies import get_current_user, get_db
from app.crud import crud_dashboard
from app.models.user import User
from app.schemas.dashboard import (
    KPIsResponse,
    RiskDistributionResponse,
    RiskByCycleResponse,
    StudentListResponse,
    TrendResponse,
    FailedSubjectsDistributionResponse,
    IncomeDistributionMicroResponse,
    CorrelationIncomeFailuresResponse,
    DigitalGapResponse,
    ParentEducationResponse,
    IncomeRiskResponse,
    TrendMacroResponse,
    RiskByTypeResponse,
    MacroKPIsResponse,
)

router = APIRouter(prefix="/dashboard", tags=["Dashboard Analítico"])


# =====================================================================
# 1. KPIs GLOBALES
# =====================================================================

@router.get(
    "/overview/kpis",
    response_model=KPIsResponse,
    summary="KPIs globales absolutos (T0 y T-1 aplanados)",
)
def get_kpis(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> KPIsResponse:
    data = crud_dashboard.get_overview_kpis(
        db, 
        cod_centro=cod_centro, 
        curso_academico=curso_academico, 
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro
    )
    return KPIsResponse(**data)


# =====================================================================
# 2. GRÁFICOS
# =====================================================================

@router.get(
    "/overview/charts/risk-distribution",
    response_model=RiskDistributionResponse,
    summary="Distribución de riesgo de abandono",
)
def get_risk_distribution(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> RiskDistributionResponse:
    data = crud_dashboard.get_risk_distribution(
        db, 
        cod_centro=cod_centro, 
        curso_academico=curso_academico, 
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro
    )
    return RiskDistributionResponse(data=data)


@router.get(
    "/overview/charts/risk-by-cycle",
    response_model=RiskByCycleResponse,
    summary="Media de riesgo por ciclo educativo",
)
def get_risk_by_cycle(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> RiskByCycleResponse:
    data = crud_dashboard.get_risk_by_cycle(
        db, 
        cod_centro=cod_centro, 
        curso_academico=curso_academico, 
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro
    )
    return RiskByCycleResponse(data=data)


@router.get(
    "/overview/charts/trend",
    response_model=TrendResponse,
    summary="Evolución histórica de los últimos 5 años",
)
def get_trend(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> TrendResponse:
    data = crud_dashboard.get_trend(
        db, 
        cod_centro=cod_centro, 
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro
    )
    return TrendResponse(data=data)

@router.get(
    "/overview/charts/failed-subjects",
    response_model=FailedSubjectsDistributionResponse,
    summary="Distribución de suspensos por alumno",
)
def get_failed_subjects_distribution(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> FailedSubjectsDistributionResponse:
    data = crud_dashboard.get_failed_subjects_distribution(
        db, 
        cod_centro=cod_centro, 
        curso_academico=curso_academico,
        cod_ciclo=cod_ciclo,
        tipo_centro=tipo_centro
    )
    return FailedSubjectsDistributionResponse(data=data)

@router.get(
    "/overview/charts/income-distribution",
    response_model=IncomeDistributionMicroResponse,
    summary="Distribución del Nivel de Renta",
)
def get_income_distribution_micro(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> IncomeDistributionMicroResponse:
    data = crud_dashboard.get_income_distribution_micro(db, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    return IncomeDistributionMicroResponse(data=data)



@router.get(
    "/overview/charts/correlation-income-failures",
    response_model=CorrelationIncomeFailuresResponse,
    summary="Correlación entre Renta y Suspensos",
)
def get_correlation_income_failures(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> CorrelationIncomeFailuresResponse:
    data = crud_dashboard.get_correlation_income_failures(db, cod_centro=cod_centro, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro)
    return CorrelationIncomeFailuresResponse(data=data)

# =====================================================================
# 3. SECCIÓN 2: CONTEXTO SOCIOECONÓMICO
# =====================================================================

from app.schemas.dashboard import (
    DigitalGapResponse,
    ParentEducationResponse,
    IncomeRiskResponse,
)


@router.get(
    "/socioeconomic/charts/digital-gap",
    response_model=DigitalGapResponse,
    summary="Brecha digital y tasa de aprobados",
)
def get_digital_gap(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> DigitalGapResponse:
    data = crud_dashboard.get_digital_gap(db, cod_centro, curso_academico, cod_ciclo, tipo_centro)
    return DigitalGapResponse(data=data)


@router.get(
    "/socioeconomic/charts/parent-education",
    response_model=ParentEducationResponse,
    summary="Pirámide de nivel de estudios de los padres",
)
def get_parent_education(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> ParentEducationResponse:
    data = crud_dashboard.get_parent_education(db, cod_centro, curso_academico, cod_ciclo, tipo_centro)
    return ParentEducationResponse(data=data)


@router.get(
    "/socioeconomic/charts/income-risk",
    response_model=IncomeRiskResponse,
    summary="Nivel de renta y riesgo crítico de abandono",
)
def get_income_risk(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> IncomeRiskResponse:
    data = crud_dashboard.get_income_risk(db, cod_centro, curso_academico, cod_ciclo, tipo_centro)
    return IncomeRiskResponse(data=data)

# =====================================================================
# 4. LISTADO DE ALUMNOS Y FILTROS
# =====================================================================

from app.schemas.dashboard import StudentListResponse, FiltersResponse, CentroListResponse

@router.get(
    "/centros",
    response_model=CentroListResponse,
    summary="Ranking de centros por índice de riesgo (Visión Macro)",
)
def get_centros(
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    page: int = Query(1, ge=1, description="Número de página (1-indexed)"),
    page_size: int = Query(25, ge=1, le=100, description="Registros por página"),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> CentroListResponse:
    data = crud_dashboard.get_centros_ranking(
        db, curso_academico, cod_ciclo, tipo_centro, page, page_size
    )
    return CentroListResponse(**data)


@router.get(
    "/students",
    response_model=StudentListResponse,
    summary="Listado paginado de alumnos",
)
def get_students(
    cod_centro: Optional[List[str]] = Query(None),
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    riesgo_nivel: Optional[str] = Query(None, description="Bajo, Medio, Alto"),
    is_repetidor: Optional[bool] = Query(None, description="Filtrar por repetidor (true/false)"),
    alerta_brecha_digital: Optional[bool] = Query(None, description="Sin internet ni ordenadores"),
    alerta_renta_baja: Optional[bool] = Query(None, description="Renta baja/muy baja"),
    alerta_riesgo_alto: Optional[bool] = Query(None, description="Alumnos con riesgo alto"),
    alerta_suspensos: Optional[bool] = Query(None, description="Alumnos con suspensos"),
    alerta_desfase_edad: Optional[bool] = Query(None, description="Alumnos con desfase de edad"),
    alerta_bajo_estudios: Optional[bool] = Query(None, description="Bajo nivel de estudios de padres"),
    alerta_adaptacion: Optional[bool] = Query(None, description="Con adaptación curricular"),
    alerta_repetidores_pri: Optional[bool] = Query(None, description="Repetidores 1/2 PRI"),
    alerta_suspensos_pri: Optional[bool] = Query(None, description="Suspensos 1/2 PRI"),
    sort_by: str = Query("riesgo_abandono", description="Columna a ordenar"),
    sort_desc: bool = Query(True, description="Orden descendente"),
    page: int = Query(1, ge=1, description="Número de página (1-indexed)"),
    page_size: int = Query(25, ge=1, le=100, description="Registros por página"),
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> StudentListResponse:
    data = crud_dashboard.get_student_list(
        db, cod_centro, curso_academico, cod_ciclo, tipo_centro,
        riesgo_nivel, is_repetidor, alerta_brecha_digital, alerta_renta_baja, alerta_riesgo_alto,
        alerta_suspensos=alerta_suspensos,
        alerta_desfase_edad=alerta_desfase_edad,
        alerta_bajo_estudios=alerta_bajo_estudios,
        alerta_adaptacion=alerta_adaptacion,
        alerta_repetidores_pri=alerta_repetidores_pri,
        alerta_suspensos_pri=alerta_suspensos_pri,
        sort_by=sort_by, sort_desc=sort_desc, page=page, page_size=page_size
    )
    return StudentListResponse(**data)

# =====================================================================
# 6. MACRO DASHBOARD
# =====================================================================

@router.get(
    "/macro/kpis",
    response_model=MacroKPIsResponse,
    summary="KPIs agregados para el MacroDashboard",
)
def get_macro_kpis(
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    data = crud_dashboard.get_macro_kpis(
        db, curso_academico=curso_academico, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro
    )
    return data


@router.get(
    "/macro/charts/trend",
    response_model=TrendMacroResponse,
    summary="Evolución histórica de riesgo a nivel autonómico",
)
def get_macro_trend(
    cod_ciclo: Optional[List[str]] = Query(None),
    tipo_centro: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    data = crud_dashboard.get_macro_trend(
        db, cod_ciclo=cod_ciclo, tipo_centro=tipo_centro
    )
    return {"data": data}


@router.get(
    "/macro/charts/risk-by-type",
    response_model=RiskByTypeResponse,
    summary="Media de riesgo por tipo de centro",
)
def get_macro_risk_by_type(
    curso_academico: Optional[List[str]] = Query(None),
    cod_ciclo: Optional[List[str]] = Query(None),
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    data = crud_dashboard.get_macro_risk_by_type(
        db, curso_academico=curso_academico, cod_ciclo=cod_ciclo
    )
    return {"data": data}

@router.get(
    "/filters",
    response_model=FiltersResponse,
    summary="Filtros dinámicos para el dashboard",
)
def get_filters(
    db: Session = Depends(get_db),
    _current_user: User = Depends(get_current_user),
) -> FiltersResponse:
    data = crud_dashboard.get_dynamic_filters(db)
    return FiltersResponse(**data)
