"""
Esquemas Pydantic para autenticación y gestión de usuarios.
"""

from __future__ import annotations

from datetime import datetime

from pydantic import BaseModel, EmailStr, Field


# ── Request schemas ───────────────────────────────────────────────────


class LoginRequest(BaseModel):
    """Payload para ``POST /login``."""

    email: str = Field(
        ...,
        min_length=5,
        max_length=255,
        examples=["admin@tfg.edu"],
    )
    password: str = Field(
        ...,
        min_length=4,
        max_length=128,
        examples=["s3cur3P@ss"],
    )


class UserCreate(BaseModel):
    """Payload para crear un usuario (uso interno / seeding)."""

    email: EmailStr = Field(..., min_length=5, max_length=255)
    password: str = Field(..., min_length=8, max_length=128)
    role: str = Field(default="viewer", pattern=r"^(admin|viewer)$")


class UserUpdate(BaseModel):
    """Payload para actualizar un usuario."""

    email: EmailStr | None = Field(None, min_length=5, max_length=255)
    password: str | None = Field(None, min_length=8, max_length=128)
    role: str | None = Field(None, pattern=r"^(admin|viewer)$")

# ── Response schemas ──────────────────────────────────────────────────


class TokenResponse(BaseModel):
    """Respuesta de ``POST /login`` con el JWT."""

    access_token: str
    token_type: str = "bearer"


class UserResponse(BaseModel):
    """Representación pública del usuario (sin contraseña)."""

    id: int
    email: str
    role: str
    created_at: datetime

    model_config = {"from_attributes": True}
