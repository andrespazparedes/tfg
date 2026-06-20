"""
Alembic env.py — Configuración de migraciones (modo síncrono con psycopg2).

Solo gestiona el esquema ``app`` (tabla de usuarios).
El esquema ``dwh`` (DataMart) está excluido y es gestionado exclusivamente por ETL.
"""

from logging.config import fileConfig

from sqlalchemy import pool, engine_from_config
from sqlalchemy.engine import Connection

from alembic import context

# Import our config and Base metadata
from app.core.config import settings
from app.models.base import Base

# Ensure the User model is imported so its table is registered in Base.metadata
from app.models.user import User  # noqa: F401

# This is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

# Set the SQLAlchemy URL from our app settings dynamically
config.set_main_option("sqlalchemy.url", settings.DATABASE_URI)

# Interpret the config file for Python logging.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# Target metadata for autogenerate support
target_metadata = Base.metadata


def include_name(name: str, type_: str, parent_names: dict) -> bool:
    """Solo considerar el esquema 'app' para migraciones."""
    if type_ == "schema":
        return name == "app"
    return True


def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode."""
    url = config.get_main_option("sqlalchemy.url")
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
        include_schemas=True,
        include_name=include_name,
        version_table_schema="app",
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """Run migrations in 'online' mode (síncrono)."""
    connectable = engine_from_config(
        config.get_section(config.config_ini_section, {}),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            include_schemas=True,
            include_name=include_name,
            version_table_schema="app",
        )

        with context.begin_transaction():
            # Create schema if it doesn't exist before running migrations
            context.execute("CREATE SCHEMA IF NOT EXISTS app;")
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
