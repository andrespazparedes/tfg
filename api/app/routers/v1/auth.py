"""
Router de autenticación — ``POST /api/v1/auth/login``.
"""

from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.routers.dependencies import get_db
from app.core.security import create_access_token, verify_password
from app.models.user import User
from app.schemas.user import LoginRequest, TokenResponse

router = APIRouter(prefix="/auth", tags=["Autenticación"])


@router.post(
    "/login",
    response_model=TokenResponse,
    summary="Iniciar sesión",
    description="Autentica un usuario por email y contraseña. Devuelve un JWT.",
)
def login(
    body: LoginRequest,
    db: Session = Depends(get_db),
) -> TokenResponse:
    """
    Flujo de autenticación:

    1. Busca al usuario por email.
    2. Verifica la contraseña contra el hash bcrypt almacenado.
    3. Genera y devuelve un token JWT con el email como ``sub``.
    """
    # 1. Buscar usuario
    user: User | None = (
        db.query(User).filter(User.email == body.email).first()
    )
    if user is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciales incorrectas",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # 2. Verificar contraseña
    if not verify_password(body.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciales incorrectas",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # 3. Generar token
    access_token = create_access_token(data={"sub": user.email, "role": user.role})

    return TokenResponse(access_token=access_token)
