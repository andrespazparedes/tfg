"""
Dependencias reutilizables inyectadas vía ``Depends()`` en los endpoints.

- ``get_db``: sesión de base de datos por request (re-exportado desde database.py).
- ``get_current_user``: extrae y valida el usuario autenticado desde el JWT.
"""

from __future__ import annotations

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.orm import Session

from app.core.database import get_db  # noqa: F401 — re-export for convenience
from app.core.security import decode_access_token
from app.models.user import User

# Esquema HTTP Bearer: espera cabecera ``Authorization: Bearer <token>``
_bearer_scheme = HTTPBearer(auto_error=True)


def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(_bearer_scheme),
    db: Session = Depends(get_db),
) -> User:
    """
    Dependencia de autenticación.

    1. Extrae el token JWT de la cabecera ``Authorization``.
    2. Lo decodifica y valida (firma + expiración).
    3. Busca al usuario por email (claim ``sub``) en la BD.
    4. Devuelve el objeto ``User`` o lanza ``401``.

    Raises
    ------
    HTTPException 401
        Si el token es inválido, ha expirado, o el usuario no existe.
    """
    token = credentials.credentials

    try:
        payload = decode_access_token(token)
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido o expirado",
            headers={"WWW-Authenticate": "Bearer"},
        )

    email: str | None = payload.get("sub")
    if email is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token no contiene claim 'sub'",
            headers={"WWW-Authenticate": "Bearer"},
        )

    user: User | None = db.query(User).filter(User.email == email).first()
    if user is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Usuario no encontrado",
            headers={"WWW-Authenticate": "Bearer"},
        )

    return user

def get_current_admin_user(current_user: User = Depends(get_current_user)) -> User:
    """
    Dependencia que asegura que el usuario autenticado tiene rol 'admin'.
    """
    if current_user.role != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Permisos insuficientes",
        )
    return current_user
