import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import './LandingPage.css';

export default function LandingPage() {
  const { isAuthenticated } = useAuth();

  return (
    <div className="landing-page">
      {/* Navbar Pública */}
      <nav className="landing-nav">
        <div className="landing-logo">
          <span className="logo-text">Dashboard Educativo.</span>
        </div>
        <div className="landing-nav-actions">
          {isAuthenticated ? (
            <Link to="/dashboard" className="landing-btn landing-btn--primary">
              Ir al Dashboard
            </Link>
          ) : (
            <Link to="/login" className="landing-btn landing-btn--primary">
              Iniciar Sesión
            </Link>
          )}
        </div>
      </nav>

      {/* Hero Section */}
      <section className="landing-hero">
        <div className="hero-content">
          <div className="hero-badge">Análisis Heurístico Avanzado</div>
          <h1 className="hero-title">
            Anticípate al abandono escolar con <span className="hero-highlight">datos precisos</span>
          </h1>
          <p className="hero-subtitle">
            Un panel de control inteligente diseñado para equipos directivos. Detecta alumnos en riesgo, analiza el rendimiento académico y toma decisiones basadas en evidencia.
          </p>
          <div className="hero-cta">
            {isAuthenticated ? (
              <Link to="/dashboard" className="landing-btn landing-btn--large landing-btn--primary">
                Entrar al Dashboard
              </Link>
            ) : (
              <Link to="/login" className="landing-btn landing-btn--large landing-btn--primary">
                Comenzar ahora
              </Link>
            )}
          </div>
        </div>
      </section>

      {/* Features Section - Editorial Layout */}
      <section className="landing-features">
        <div className="features-grid">
          <div className="feature-block">
            <div className="feature-number">01</div>
            <h3 className="feature-title">Alertas Tempranas</h3>
            <p className="feature-description">
              Identifica estudiantes en riesgo de abandono escolar de forma proactiva mediante algoritmos heurísticos especializados.
            </p>
          </div>
          <div className="feature-block">
            <div className="feature-number">02</div>
            <h3 className="feature-title">Análisis Integral</h3>
            <p className="feature-description">
              Visualiza el rendimiento por centro, ciclo y curso en un dashboard centralizado y extremadamente fácil de leer.
            </p>
          </div>
          <div className="feature-block">
            <div className="feature-number">03</div>
            <h3 className="feature-title">Seguimiento de Riesgo</h3>
            <p className="feature-description">
              Controla factores de riesgo socioeconómico, repeticiones y adaptaciones curriculares en una sola vista unificada.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
