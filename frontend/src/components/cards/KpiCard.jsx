import React from 'react';
import './KpiCard.css';

export default function KpiCard({ title, value, icon, color, suffix, subtext }) {
  const formatValue = () => {
    if (value === null || value === undefined) return '—';
    if (suffix === '%') return `${Number(value).toFixed(1)}%`;
    return value.toLocaleString('es-ES');
  };

  return (
    <div className="kpi-card">
      <div className="kpi-card__header">
        <span className="kpi-card__title">{title}</span>
        <div
          className="kpi-card__icon"
          style={{ backgroundColor: `${color}1A`, color }}
        >
          {icon}
        </div>
      </div>
      <div className="kpi-card__content">
        <span className="kpi-card__value">
          {formatValue()}
          {suffix && suffix !== '%' && (
            <span className="kpi-card__suffix">{suffix}</span>
          )}
        </span>
        {subtext && (
          <span className="kpi-card__subtext">
            {subtext}
          </span>
        )}
      </div>
    </div>
  );
}
