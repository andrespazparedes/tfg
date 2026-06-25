from typing import List
from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.routers.dependencies import get_current_admin_user, get_current_user
from app.schemas.user import UserCreate, UserResponse, UserUpdate
from app.models.user import User
from app.crud import crud_user

router = APIRouter()

@router.get(
    "",
    response_model=List[UserResponse],
    summary="Listar usuarios",
    description="Obtiene la lista de todos los usuarios. Solo accesible para administradores."
)
def read_users(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
) -> List[User]:
    users = crud_user.get_users(db, skip=skip, limit=limit)
    return users

@router.post(
    "",
    response_model=UserResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Crear usuario",
    description="Crea un nuevo usuario. Solo el superadmin puede crear otros admins."
)
def create_user(
    user_in: UserCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
) -> User:
    return crud_user.create_user(db, user_in=user_in, current_user=current_user)

@router.put(
    "/{user_id}",
    response_model=UserResponse,
    summary="Actualizar usuario",
    description="Actualiza un usuario existente."
)
def update_user(
    user_id: int,
    user_in: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
) -> User:
    return crud_user.update_user(db, user_id=user_id, user_in=user_in, current_user=current_user)

@router.delete(
    "/{user_id}",
    response_model=UserResponse,
    summary="Eliminar usuario",
    description="Elimina un usuario. El superadmin no puede ser eliminado."
)
def delete_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
) -> User:
    return crud_user.delete_user(db, user_id=user_id, current_user=current_user)
