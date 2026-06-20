"""
Modelos SQLAlchemy de solo lectura que mapean el esquema ``dwh`` del DataMart.

IMPORTANTE:
- FastAPI NUNCA escribe en estas tablas; el ETL (Apache Hop) es el único escritor.
- Alembic NO gestiona este esquema — las migraciones solo aplican al esquema ``app``.
- Los tipos de columna reflejan **exactamente** el DDL de ``00_create_dwh_tables.sql``.
"""

from __future__ import annotations

from datetime import date, datetime

from sqlalchemy import (
    BigInteger,
    Boolean,
    Date,
    DateTime,
    Double,
    Integer,
    Numeric,
    SmallInteger,
    String,
    Text,
)
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


# ── Base exclusiva para el esquema dwh ────────────────────────────────
class DWHBase(DeclarativeBase):
    """
    Base declarativa separada para las tablas del DataMart (esquema ``dwh``).
    No comparte metadata con la ``Base`` del esquema ``app`` para evitar
    que Alembic intente gestionar estas tablas.
    """

    __abstract__ = True
    __table_args__ = {"schema": "dwh"}


# =====================================================================
# DIMENSIONES
# =====================================================================


class DimEstudiante(DWHBase):
    """Dimensión Estudiante (SCD Tipo 2): datos personales y responsables legales."""

    __tablename__ = "dim_estudiante"

    id_estudiante: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    num_expediente: Mapped[str | None] = mapped_column(String(15))
    dni: Mapped[str | None] = mapped_column(String(12))
    nombre: Mapped[str | None] = mapped_column(String(150))
    fecha_nacimiento: Mapped[date | None] = mapped_column(Date)
    email: Mapped[str | None] = mapped_column(String(100))

    # Dirección
    calle_portal: Mapped[str | None] = mapped_column(Text)
    puerta: Mapped[str | None] = mapped_column(Text)
    cp: Mapped[int | None] = mapped_column(Integer)
    ciudad: Mapped[str | None] = mapped_column(Text)

    # Responsable legal
    cod_responsable: Mapped[str | None] = mapped_column(String(15))
    nombre_responsable_1: Mapped[str | None] = mapped_column(String(100))
    nombre_responsable_2: Mapped[str | None] = mapped_column(String(100))
    telefono_responsable_1: Mapped[str | None] = mapped_column(String(20))
    telefono_responsable_2: Mapped[str | None] = mapped_column(String(20))
    email_responsable_1: Mapped[str | None] = mapped_column(String(100))
    email_responsable_2: Mapped[str | None] = mapped_column(String(100))
    monoparental: Mapped[bool | None] = mapped_column(Boolean)

    # SCD Tipo 2
    version: Mapped[int | None] = mapped_column(Integer)
    date_from: Mapped[datetime | None] = mapped_column(DateTime)
    date_to: Mapped[datetime | None] = mapped_column(DateTime)

    def __repr__(self) -> str:
        return f"<DimEstudiante id={self.id_estudiante} exp={self.num_expediente!r}>"


class DimCentro(DWHBase):
    """Dimensión Centro educativo con inyección geográfica."""

    __tablename__ = "dim_centro"

    id_centro: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    last_update: Mapped[datetime | None] = mapped_column(DateTime)
    cod_centro: Mapped[str | None] = mapped_column(String(10))
    nombre: Mapped[str | None] = mapped_column(String(150))
    ciudad: Mapped[str | None] = mapped_column(String(100))
    cp: Mapped[int | None] = mapped_column(Integer)
    direccion: Mapped[str | None] = mapped_column(String(150))
    email: Mapped[str | None] = mapped_column(String(100))
    telefono: Mapped[str | None] = mapped_column(String(20))
    tipo: Mapped[str | None] = mapped_column(String(50))
    naturaleza: Mapped[str | None] = mapped_column(String(50))

    def __repr__(self) -> str:
        return f"<DimCentro id={self.id_centro} nombre={self.nombre!r}>"


class DimCurso(DWHBase):
    """Dimensión Curso: aplanamiento de ciclo educativo, especialidad y curso."""

    __tablename__ = "dim_curso"

    id_curso: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    last_update: Mapped[datetime | None] = mapped_column(DateTime)
    num_curso: Mapped[int | None] = mapped_column(SmallInteger)
    cod_especialidad: Mapped[str | None] = mapped_column(String(10))
    cod_ciclo: Mapped[str | None] = mapped_column(String(10))
    num_optativas: Mapped[int | None] = mapped_column(SmallInteger)
    nombre_especialidad: Mapped[str | None] = mapped_column(String(150))
    nombre_ciclo: Mapped[str | None] = mapped_column(String(150))
    real_decreto: Mapped[str | None] = mapped_column(String(255))
    decreto_autonomico: Mapped[str | None] = mapped_column(String(255))
    edad_ideal: Mapped[float | None] = mapped_column(Double)

    def __repr__(self) -> str:
        return f"<DimCurso id={self.id_curso} ciclo={self.cod_ciclo!r}>"


class DimAsignatura(DWHBase):
    """Dimensión Asignatura: catálogo de materias."""

    __tablename__ = "dim_asignatura"

    id_asignatura: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    last_update: Mapped[datetime | None] = mapped_column(DateTime)
    cod_asignatura: Mapped[str | None] = mapped_column(String(15))
    nombre: Mapped[str | None] = mapped_column(String(150))
    tipo: Mapped[str | None] = mapped_column(String(30))
    num_horas: Mapped[int | None] = mapped_column(SmallInteger)
    ciclo: Mapped[str | None] = mapped_column(String(50))
    especialidad: Mapped[str | None] = mapped_column(String(100))
    num_curso: Mapped[int | None] = mapped_column(SmallInteger)

    def __repr__(self) -> str:
        return f"<DimAsignatura id={self.id_asignatura} cod={self.cod_asignatura!r}>"


class DimTiempo(DWHBase):
    """Dimensión Tiempo y evaluaciones."""

    __tablename__ = "dim_tiempo"

    id_tiempo: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    curso_academico: Mapped[str | None] = mapped_column(String(9))
    evaluacion: Mapped[str | None] = mapped_column(String(50))
    is_final: Mapped[bool | None] = mapped_column(Boolean)

    def __repr__(self) -> str:
        return f"<DimTiempo id={self.id_tiempo} año={self.curso_academico!r}>"


class DimDemografiaFamiliar(DWHBase):
    """Dimensión Demografía Familiar: optimización Kimball de baja cardinalidad."""

    __tablename__ = "dim_demografia_familiar"

    id_demografia_familiar: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    max_nivel_estudios: Mapped[str | None] = mapped_column(String(23))
    internet: Mapped[bool | None] = mapped_column(Boolean)
    disponibilidad_ordenadores: Mapped[str | None] = mapped_column(String(255))
    nivel_renta: Mapped[str | None] = mapped_column(String(50))
    riesgo_socioeconomico: Mapped[int | None] = mapped_column(Integer)

    def __repr__(self) -> str:
        return (
            f"<DimDemografiaFamiliar id={self.id_demografia_familiar} "
            f"renta={self.nivel_renta!r}>"
        )


class DimAdaptacion(DWHBase):
    """Dimensión Apoyo y Adaptaciones Curriculares."""

    __tablename__ = "dim_adaptacion"

    id_adaptacion: Mapped[int] = mapped_column(
        BigInteger, primary_key=True, autoincrement=True
    )
    tipo: Mapped[str | None] = mapped_column(Text)
    is_discapacidad: Mapped[bool | None] = mapped_column(Boolean)
    is_compensatoria: Mapped[bool | None] = mapped_column(Boolean)
    riesgo_adaptacion: Mapped[float | None] = mapped_column(Double)

    def __repr__(self) -> str:
        return f"<DimAdaptacion id={self.id_adaptacion} tipo={self.tipo!r}>"


# =====================================================================
# HECHOS
# =====================================================================


class FactCalificaciones(DWHBase):
    """
    Tabla de hechos de calificaciones.
    Granularidad: Estudiante × Asignatura × Evaluación.
    """

    __tablename__ = "fact_calificaciones"

    # PK compuesta
    id_estudiante: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    id_asignatura: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    id_tiempo: Mapped[int] = mapped_column(BigInteger, primary_key=True)

    # FKs a dimensiones
    id_centro: Mapped[int] = mapped_column(BigInteger, nullable=False)
    id_curso: Mapped[int] = mapped_column(BigInteger, nullable=False)
    id_demografia_familiar: Mapped[int] = mapped_column(BigInteger, nullable=False)
    id_adaptacion: Mapped[int] = mapped_column(BigInteger, nullable=False)

    # Métricas
    nota: Mapped[float] = mapped_column(Numeric(4, 2), nullable=False)
    desfase_edad: Mapped[int] = mapped_column(SmallInteger, nullable=False)
    renta_unidades_consumo: Mapped[float | None] = mapped_column(Double)

    def __repr__(self) -> str:
        return (
            f"<FactCalificaciones est={self.id_estudiante} "
            f"asig={self.id_asignatura} tiempo={self.id_tiempo}>"
        )


class FactRendimientoAnual(DWHBase):
    """
    Tabla de hechos de rendimiento anual.
    Granularidad: Estudiante × Curso Académico.
    Contiene los indicadores clave de riesgo calculados por el ETL.
    """

    __tablename__ = "fact_rendimiento_anual"

    # PK compuesta
    id_estudiante: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    id_tiempo: Mapped[float] = mapped_column(Double, primary_key=True)

    # FKs a dimensiones (DOUBLE PRECISION según DDL real)
    id_centro: Mapped[float] = mapped_column(Double, nullable=False)
    id_curso: Mapped[float] = mapped_column(Double, nullable=False)
    id_demografia_familiar: Mapped[float] = mapped_column(Double, nullable=False)
    id_adaptacion: Mapped[float] = mapped_column(Double, nullable=False)

    # Métricas de rendimiento
    num_cursadas: Mapped[int] = mapped_column(BigInteger, nullable=False)
    num_aprobadas: Mapped[float] = mapped_column(Double, nullable=False)
    num_suspensas: Mapped[float] = mapped_column(Double, nullable=False)
    tasa_aprobado: Mapped[float] = mapped_column(Double, nullable=False)
    is_repetidor: Mapped[bool] = mapped_column(Boolean, nullable=False)
    desfase_edad: Mapped[float] = mapped_column(Double, nullable=False)
    renta_unidades_consumo: Mapped[float | None] = mapped_column(Double)

    # Indicadores de riesgo (0–100)
    riesgo_academico: Mapped[float] = mapped_column(Double, nullable=False)
    riesgo_adaptacion: Mapped[float] = mapped_column(Double, nullable=False)
    riesgo_socioeconomico: Mapped[float] = mapped_column(Double, nullable=False)
    riesgo_abandono: Mapped[float] = mapped_column(Double, nullable=False)

    def __repr__(self) -> str:
        return (
            f"<FactRendimientoAnual est={self.id_estudiante} "
            f"riesgo={self.riesgo_abandono:.1f}>"
        )
