"""
Configuración de SQLAlchemy 2.0 (modo síncrono con psycopg2-binary).

Conecta a la misma base de datos ``postgres-dwh`` pero distingue dos ámbitos:
- Esquema ``app``: lectura/escritura (tabla de usuarios, migraciones con Alembic).
- Esquema ``dwh``: solo lectura (DataMart analítico poblado por ETL).
"""

from __future__ import annotations

from typing import Generator

from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker

from app.core.config import settings

# ── Engine ────────────────────────────────────────────────────────────
# Un solo engine apunta a la BD ``postgres-dwh``.
# Los modelos se encargan de indicar su schema (``app`` o ``dwh``).
engine = create_engine(
    settings.DATABASE_URI,
    echo=False,
    pool_size=10,
    max_overflow=20,
    pool_pre_ping=True,
    pool_recycle=1800,
)

# ── Session factory ───────────────────────────────────────────────────
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
    expire_on_commit=False,
)


def get_db() -> Generator[Session, None, None]:
    """
    Generador de dependencia de FastAPI.
    Provee una sesión por request y garantiza el cierre tras su uso.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
