import logging
from sqlalchemy.orm import Session
from app.core.database import engine
from app.models.user import User
from app.core.security import hash_password
from app.core.config import settings

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def seed_db() -> None:
    logger.info("Iniciando proceso de seeding...")
    with Session(engine) as db:
        admin_email = settings.DEFAULT_ADMIN_EMAIL
        user = db.query(User).filter(User.email == admin_email).first()
        if not user:
            logger.info(f"Creando usuario administrador por defecto ({admin_email})...")
            new_user = User(
                email=admin_email,
                hashed_password=hash_password(settings.DEFAULT_ADMIN_PASSWORD),
                role="admin"
            )
            db.add(new_user)
            db.commit()
            logger.info(f"Usuario administrador creado: {admin_email}")
        else:
            logger.info("El usuario administrador ya existe. Saltando seed.")

if __name__ == "__main__":
    seed_db()
