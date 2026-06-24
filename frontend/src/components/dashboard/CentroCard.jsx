import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useDashboardContext } from '../../context/DashboardContext';
import { Building2, TrendingUp, TrendingDown, Minus } from 'lucide-react';
import { Card } from '../ui/Card';
import './CentroCard.css';

export const CentroCard = ({ centro }) => {
  const { setDrillDownCentro } = useDashboardContext();
  const navigate = useNavigate();

  const handleAuditar = () => {
    setDrillDownCentro(centro.cod_centro);
    navigate('/micro');
  };

  const getRiskColor = (score) => {
    if (score >= 7) return 'var(--danger-color, #ef4444)';
    if (score >= 4) return 'var(--warning-color, #f59e0b)';
    return 'var(--success-color, #10b981)';
  };

  const riskColor = getRiskColor(centro.indice_riesgo_centro);

  // Evolución (Trend) vs T-1
  let trendIcon = <Minus size={16} color="var(--text-muted)" />;
  let trendText = "Estable";
  let trendClass = "trend-stable";

  if (centro.indice_riesgo_centro_a1 !== null) {
    const diff = centro.indice_riesgo_centro - centro.indice_riesgo_centro_a1;
    if (diff > 0) {
      trendIcon = <TrendingUp size={16} color="var(--danger-color)" />;
      trendText = `↑ +${diff} pts vs T-1`;
      trendClass = "trend-up";
    } else if (diff < 0) {
      trendIcon = <TrendingDown size={16} color="var(--success-color)" />;
      trendText = `↓ ${diff} pts vs T-1`;
      trendClass = "trend-down";
    }
  } else {
    trendText = "Sin datos T-1";
  }

  return (
    <Card isHoverable={true} className="centro-card" onClick={handleAuditar}>
      <div className="centro-card-header">
        <div className="centro-icon">
          <Building2 size={20} />
        </div>
        <div className="centro-title">
          <h3>{centro.nombre_centro}</h3>
          <span className="centro-tipo">{centro.tipo_centro || 'Desconocido'}</span>
        </div>
      </div>

      <div className="centro-card-body">
        <div className="score-ring-container">
          <svg viewBox="0 0 36 36" className="score-ring">
            <path
              className="ring-bg"
              d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
            />
            <path
              className="ring-progress"
              strokeDasharray={`${(centro.indice_riesgo_centro / 10) * 100}, 100`}
              stroke={riskColor}
              d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
            />
            <text x="18" y="20.35" className="ring-text">
              {centro.indice_riesgo_centro}/10
            </text>
          </svg>
          <div className="score-label">Índice de Riesgo</div>
        </div>

        <div className="centro-metrics">
          <div className="metric-row">
            <span className="metric-label">Estudiantes</span>
            <span className="metric-value">{centro.num_estudiantes}</span>
          </div>
          <div className={`metric-row ${trendClass}`}>
            <span className="metric-label">Evolución</span>
            <span className="metric-value trend-value">
              {trendIcon} {trendText}
            </span>
          </div>
        </div>
      </div>

      <div className="centro-card-footer">
        <button className="btn-audit" onClick={handleAuditar}>
          Auditar Centro
        </button>
      </div>
    </Card>
  );
};
