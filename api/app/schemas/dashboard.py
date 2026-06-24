"""
Esquemas Pydantic para los endpoints analíticos del dashboard.

Cada esquema corresponde a la respuesta de un endpoint concreto de
la carpeta de routers.
"""

from __future__ import annotations

from datetime import date
from typing import List, Optional

from pydantic import BaseModel, Field


# =====================================================================
# 1. KPIs GLOBALES — GET /api/v1/dashboard/overview/kpis
# =====================================================================


class KPIsResponse(BaseModel):
    """Indicadores clave absolutos para la pantalla Overview."""

    num_estudiantes: int = Field(..., description="Número total de alumnos únicos")
    num_estudiantes_a1: Optional[int] = None
    
    riesgo_abandono_alto: int
    riesgo_abandono_alto_a1: Optional[int] = None
    
    is_repetidor: int
    is_repetidor_a1: Optional[int] = None
    
    repetidores_1_2_pri: int
    repetidores_1_2_pri_a1: Optional[int] = None
    
    suspensos_1_2_pri: int
    suspensos_1_2_pri_a1: Optional[int] = None
    
    adaptacion_curricular: int
    adaptacion_curricular_a1: Optional[int] = None

    riesgo_socio_alto: int
    riesgo_socio_alto_a1: Optional[int] = None
    
    suspensos: int
    suspensos_a1: Optional[int] = None
    
    desfase_edad: int
    desfase_edad_a1: Optional[int] = None
    
    brecha_digital: int
    brecha_digital_a1: Optional[int] = None
    
    bajo_nivel_estudios_padres: int
    bajo_nivel_estudios_padres_a1: Optional[int] = None


# =====================================================================
# 2. GRÁFICOS OVERVIEW — GET /api/v1/dashboard/overview/charts/*
# =====================================================================


class RiskDistributionItem(BaseModel):
    """Un bucket de distribución de riesgo (Bajo / Medio / Alto)."""

    nivel_riesgo: str = Field(..., description="Nivel de riesgo: Bajo, Medio o Alto")
    num_estudiantes: int = Field(..., description="Número de alumnos en este nivel")


class RiskDistributionResponse(BaseModel):
    """Distribución de riesgo de abandono por niveles."""

    data: List[RiskDistributionItem]


class RiskByCycleItem(BaseModel):
    """Media de riesgo de abandono para un ciclo educativo."""

    cod_ciclo: str = Field(..., description="Código del ciclo educativo")
    riesgo_abandono_critico: int = Field(..., description="Número de alumnos con riesgo > 30")
    num_estudiantes: int = Field(..., description="Total de alumnos en este ciclo")


class RiskByCycleResponse(BaseModel):
    """Media de riesgo agrupada por ciclo educativo."""

    data: List[RiskByCycleItem]


class TrendItem(BaseModel):
    """Punto de datos para la gráfica de línea histórica."""

    curso_academico: str = Field(..., description="Año académico (ej. 2023-2024)")
    num_estudiantes: int = Field(..., description="Total de alumnos matriculados en ese curso")
    riesgo_alto: int = Field(..., description="Alumnos en Riesgo Alto")
    riesgo_medio: int = Field(..., description="Alumnos en Riesgo Medio")
    riesgo_bajo: int = Field(..., description="Alumnos en Riesgo Bajo")


class TrendResponse(BaseModel):
    """Evolución histórica en los últimos 5 años."""

    data: List[TrendItem]


class FailedSubjectsDistributionItem(BaseModel):
    name: str = Field(..., description="Número de asignaturas (0, 1, 2, 3, 4, 5+)")
    alumnos: int = Field(..., description="Cantidad de alumnos")
    porcentaje: float = Field(..., description="Porcentaje respecto al total")

class FailedSubjectsDistributionResponse(BaseModel):
    data: List[FailedSubjectsDistributionItem]

class IncomeDistributionMicroItem(BaseModel):
    name: str
    value: int

class IncomeDistributionMicroResponse(BaseModel):
    data: List[IncomeDistributionMicroItem]


class CorrelationIncomeFailuresItem(BaseModel):
    renta: float
    suspensos: float

class CorrelationIncomeFailuresResponse(BaseModel):
    data: List[CorrelationIncomeFailuresItem]

# =====================================================================
# 3. SECCIÓN 2: CONTEXTO SOCIOECONÓMICO
# =====================================================================



class DigitalGapItem(BaseModel):
    ordenadores_suficientes: bool
    conexion_internet: bool
    num_estudiantes: int
    num_aprobados: int

class DigitalGapResponse(BaseModel):
    data: List[DigitalGapItem]

class ParentEducationItem(BaseModel):
    max_nivel_estudios_padres: str
    num_estudiantes: int
    riesgo_abandono_critico: int

class ParentEducationResponse(BaseModel):
    data: List[ParentEducationItem]

class IncomeRiskItem(BaseModel):
    nivel_renta: str
    num_estudiantes: int
    num_suspensas: int
    riesgo_abandono_critico: int

class IncomeRiskResponse(BaseModel):
    data: List[IncomeRiskItem]

# =====================================================================
# 4. LISTADO DE ALUMNOS — GET /api/v1/dashboard/students
# =====================================================================


class DesgloseRiesgo(BaseModel):
    academico_pts: Optional[float] = None
    socioeconomico_pts: Optional[float] = None
    adaptacion_pts: Optional[float] = None
    total_pts: Optional[float] = None
    nivel_riesgo: Optional[str] = None

class AlertasEstudiante(BaseModel):
    brecha_digital: bool
    renta_baja: bool
    is_repetidor: bool

class StudentListItem(BaseModel):
    """Fila individual del listado de alumnos en riesgo."""

    id_estudiante: int
    num_expediente: Optional[str] = None

    # Contexto académico
    nombre_centro: Optional[str] = None
    cod_ciclo: Optional[str] = None
    nombre_ciclo: Optional[str] = None
    num_curso: Optional[int] = None
    tasa_aprobado: Optional[float] = None
    desfase_edad: Optional[float] = None

    desglose_riesgo: DesgloseRiesgo
    alertas: AlertasEstudiante

    model_config = {"from_attributes": True}


class StudentListResponse(BaseModel):
    """Respuesta paginada del listado de alumnos."""

    total: int = Field(..., description="Total de registros que cumplen los filtros")
    page: int = Field(..., description="Página actual (1-indexed)")
    page_size: int = Field(..., description="Tamaño de página")
    data: List[StudentListItem]


# =====================================================================
# 4. LISTADO DE CENTROS — GET /api/v1/dashboard/centros
# =====================================================================

class CentroListItem(BaseModel):
    """Fila individual del ranking de centros."""
    id_centro: int
    cod_centro: Optional[str] = None
    nombre_centro: Optional[str] = None
    localidad: Optional[str] = None
    cod_postal: Optional[str] = None
    lat: Optional[float] = None
    lon: Optional[float] = None
    tipo_centro: Optional[str] = None
    naturaleza: Optional[str] = None
    
    num_estudiantes: int
    riesgo_abandono_alto: int
    is_repetidor: int
    repetidores_1_2_pri: int
    suspensos_1_2_pri: int
    adaptacion_curricular: int
    riesgo_socioeconomico_alto: int
    suspensos: int
    desfase_edad: int
    brecha_digital: int
    bajo_nivel_estudios_padres: int
    
    indice_riesgo_centro: int
    indice_riesgo_centro_a1: Optional[int] = None

    model_config = {"from_attributes": True}


class CentroListResponse(BaseModel):
    """Respuesta paginada del ranking de centros."""
    total: int
    page: int
    page_size: int
    data: List[CentroListItem]


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
    tipos_centro: List[str] = Field(
        ..., description="Tipos de centros educativos disponibles (CEIP, IES...)"
    )

# =====================================================================
# 6. MACRO DASHBOARD — GET /api/v1/dashboard/macro/*
# =====================================================================

class TrendMacroItem(BaseModel):
    curso_academico: str
    indice_riesgo_medio: float
    num_centros: int

class TrendMacroResponse(BaseModel):
    data: List[TrendMacroItem]


class RiskByTypeItem(BaseModel):
    tipo_centro: str
    indice_riesgo_medio: float
    num_centros: int

class RiskByTypeResponse(BaseModel):
    data: List[RiskByTypeItem]


class MacroKPIsResponse(BaseModel):
    num_centros: int
    riesgo_abandono_alto: int
    is_repetidor: int
    repetidores_1_2_pri: int
    suspensos_1_2_pri: int
    adaptacion_curricular: int
    riesgo_socio_alto: int
    suspensos: int
    desfase_edad: int
    brecha_digital: int
    bajo_nivel_estudios_padres: int

