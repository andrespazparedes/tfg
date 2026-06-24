"""
Configuración centralizada de la aplicación.
Todas las variables se leen desde el entorno / .env usando pydantic-settings.
Prohibido hardcodear URLs, credenciales o puertos.
"""

from __future__ import annotations

import json
from typing import List

from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """
    Fuente única de verdad para la configuración de la aplicación.
    Los valores se cargan desde variables de entorno (inyectadas por Docker)
    o desde un fichero ``.env`` en desarrollo local.
    """

    # ── Proyecto ──────────────────────────────────────────────────────
    PROJECT_NAME: str = "TFG Dashboard API"
    API_V1_STR: str = "/api/v1"

    # ── CORS ──────────────────────────────────────────────────────────
    CORS_ORIGINS: List[str] = []

    @field_validator("CORS_ORIGINS", mode="before")
    @classmethod
    def _parse_cors(cls, v: str | List[str]) -> List[str]:
        """Acepta tanto una lista Python como un JSON string desde .env."""
        if isinstance(v, str):
            try:
                parsed = json.loads(v)
                if isinstance(parsed, list):
                    return parsed
            except (json.JSONDecodeError, TypeError):
                # Si es una cadena simple separada por comas
                return [origin.strip() for origin in v.split(",") if origin.strip()]
        return v  # type: ignore[return-value]

    # ── Base de datos DWH (PostgreSQL — solo lectura) ─────────────────
    DB_DWH_HOST: str
    DB_DWH_PORT: int = 5432
    DB_DWH_DB: str
    DB_DWH_USER: str
    DB_DWH_PASS: str

    @property
    def DATABASE_URI(self) -> str:
        """URI síncrona para SQLAlchemy (psycopg2)."""
        return (
            f"postgresql+psycopg2://{self.DB_DWH_USER}:{self.DB_DWH_PASS}"
            f"@{self.DB_DWH_HOST}:{self.DB_DWH_PORT}/{self.DB_DWH_DB}"
        )

    # ── JWT ────────────────────────────────────────────────────────────
    JWT_SECRET_KEY: str
    JWT_ALGORITHM: str = "HS256"
    JWT_ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    # ── Pydantic-settings config ──────────────────────────────────────
    model_config = SettingsConfigDict(
        case_sensitive=True,
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


settings = Settings()
