"""
Punto de entrada de la aplicación FastAPI.

- Configura CORS para el frontend React.
- Monta los routers de autenticación y dashboard bajo ``/api/v1``.
- Expone un health-check en ``/health``.
"""

from __future__ import annotations

from contextlib import contextmanager
from typing import Generator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers.v1 import auth as auth_router
from app.routers.v1 import dashboard as dashboard_router
from app.routers.v1 import users as users_router
from app.core.config import settings

# ── Instancia de la aplicación ────────────────────────────────────────
app = FastAPI(
    title=settings.PROJECT_NAME,
    version="1.0.0",
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    docs_url="/docs",
    redoc_url="/redoc",
    description="Backend analítico del Dashboard Educativo (TFG).",
    redirect_slashes=False,
)

# ── CORS ──────────────────────────────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Routers ───────────────────────────────────────────────────────────
app.include_router(
    auth_router.router,
    prefix=settings.API_V1_STR,
)
app.include_router(
    dashboard_router.router,
    prefix=settings.API_V1_STR,
)
app.include_router(
    users_router.router,
    prefix=f"{settings.API_V1_STR}/users",
    tags=["Usuarios"]
)

# ── Health Check ──────────────────────────────────────────────────────
@app.get("/health", tags=["Sistema"])
def health_check() -> dict[str, str]:
    """Endpoint de comprobación de salud para Docker / load-balancers."""
    return {"status": "ok", "message": "API is running and connected to the configuration!"}
