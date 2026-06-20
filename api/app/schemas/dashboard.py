"""
Esquemas Pydantic para los endpoints analíticos del dashboard.

Cada esquema corresponde a la respuesta de un endpoint concreto de
``app/api/v1/dashboard.py``. Se usa ``from_attributes = True`` donde
los datos provienen directamente de filas SQLAlchemy.
"""

from __future__ import annotations

from datetime import date
from typing import List, Optional

from pydantic import BaseModel, Field


# =====================================================================
# 1. KPIs GLOBALES — GET /api/v1/dashboard/kpis
# =====================================================================


class KPIsResponse(BaseModel):
    """Indicadores clave para la pantalla Overview."""

    total_alumnos: int = Field(..., description="Número total de alumnos únicos")
    pct_riesgo_abandono: float = Field(
        ...,
        description="Porcentaje de alumnos con riesgo_abandono > 50",
    )
    pct_abandono_temprano: float = Field(
        ...,
        description=(
            "Porcentaje de alumnos inferidos como abandono temprano: "
            "edad > 18 y NO están en Bachillerato ni FP Superior"
        ),
    )
    pct_fracaso_escolar: float = Field(
        ...,
        description=(
            "Porcentaje de alumnos inferidos como fracaso escolar: "
            "ciclo PRI y edad > 13"
        ),
    )


# =====================================================================
# 2. GRÁFICOS — GET /api/v1/dashboard/charts/*
# =====================================================================


class RiskDistributionItem(BaseModel):
    """Un bucket de distribución de riesgo (Bajo / Medio / Alto)."""

    nivel: str = Field(..., description="Nivel de riesgo: Bajo, Medio o Alto")
    count: int = Field(..., description="Número de alumnos en este nivel")


class RiskDistributionResponse(BaseModel):
    """Distribución de riesgo de abandono por niveles."""

    data: List[RiskDistributionItem]


class RiskByCycleItem(BaseModel):
    """Media de riesgo de abandono para un ciclo educativo."""

    cod_ciclo: str = Field(..., description="Código del ciclo educativo")
    nombre_ciclo: str = Field(..., description="Nombre legible del ciclo")
    avg_riesgo: float = Field(
        ..., description="Media del riesgo_abandono para este ciclo"
    )
    total_alumnos: int = Field(
        ..., description="Total de alumnos en este ciclo"
    )


class RiskByCycleResponse(BaseModel):
    """Media de riesgo agrupada por ciclo educativo."""

    data: List[RiskByCycleItem]


# =====================================================================
# 3. ALERTAS ROJAS — GET /api/v1/dashboard/insights/red-flags
# =====================================================================


class RedFlagsResponse(BaseModel):
    """Indicadores de alerta que requieren atención inmediata."""

    total_repetidores: int = Field(
        ..., description="Total de alumnos repetidores"
    )
    repetidores_1_2_primaria: int = Field(
        ...,
        description="Repetidores en 1.º o 2.º de Primaria (señal temprana)",
    )
    suspensos_sin_repetir: int = Field(
        ...,
        description="Alumnos con tasa_aprobado < 0.5 que NO son repetidores",
    )
    riesgo_socioeconomico_alto: int = Field(
        ...,
        description="Alumnos con riesgo_socioeconomico >= 16",
    )
    con_adaptaciones_curriculares: int = Field(
        ...,
        description="Alumnos con alguna adaptación curricular registrada",
    )


# =====================================================================
# 4. LISTADO DE ALUMNOS — GET /api/v1/dashboard/students
# =====================================================================


class StudentListItem(BaseModel):
    """Fila individual del listado de alumnos en riesgo."""

    id_estudiante: int
    num_expediente: Optional[str] = None
    nombre: Optional[str] = None
    fecha_nacimiento: Optional[date] = None

    # Contexto académico
    nombre_centro: Optional[str] = None
    cod_ciclo: Optional[str] = None
    nombre_ciclo: Optional[str] = None
    num_curso: Optional[int] = None

    # Métricas de rendimiento
    tasa_aprobado: Optional[float] = None
    is_repetidor: Optional[bool] = None
    desfase_edad: Optional[float] = None

    # Indicadores de riesgo
    riesgo_academico: Optional[float] = None
    riesgo_socioeconomico: Optional[float] = None
    riesgo_adaptacion: Optional[float] = None
    riesgo_abandono: Optional[float] = None

    model_config = {"from_attributes": True}


class StudentListResponse(BaseModel):
    """Respuesta paginada del listado de alumnos."""

    total: int = Field(..., description="Total de registros que cumplen los filtros")
    page: int = Field(..., description="Página actual (1-indexed)")
    page_size: int = Field(..., description="Tamaño de página")
    data: List[StudentListItem]


# =====================================================================
# 5. FILTROS DINÁMICOS — GET /api/v1/dashboard/filters
# =====================================================================


class FilterOption(BaseModel):
    """Par código-nombre para popular un select en el frontend."""

    value: str
    label: str


class FiltersResponse(BaseModel):
    """Valores únicos disponibles para los filtros del dashboard."""

    centros: List[FilterOption] = Field(
        ..., description="Centros educativos disponibles"
    )
    cursos_academicos: List[str] = Field(
        ..., description="Años académicos disponibles (ej: '2024/2025')"
    )
    ciclos: List[FilterOption] = Field(
        ..., description="Ciclos educativos disponibles"
    )
