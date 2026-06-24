import React from 'react';
import { Card } from './Card';
import { TrendingUp, TrendingDown, Minus } from 'lucide-react';
import { calculateYoY, formatNumber } from '../../utils/math';
import './KPICard.css';

export const KPICard = ({ 
  title, icon: Icon, valueT0, valueT1, totalValue, 
  value, trend,
  color = 'var(--color-primary)', 
  trendType = 'down-is-good', // 'down-is-good' | 'up-is-good' | 'neutral'
  onClick, isHoverable 
}) => {
  const finalValue = value !== undefined ? value : valueT0;
  const yoy = calculateYoY(finalValue, valueT1);
  const percentage = totalValue && totalValue > 0 ? ((finalValue / totalValue) * 100).toFixed(1) + '%' : null;
  
  let trendClass = 'neutral';
  let TrendIcon = Minus;
  
  if (yoy > 0) {
    trendClass = trendType === 'down-is-good' ? 'danger' : (trendType === 'up-is-good' ? 'success' : 'neutral');
    TrendIcon = TrendingUp;
  } else if (yoy < 0) {
    trendClass = trendType === 'down-is-good' ? 'success' : (trendType === 'up-is-good' ? 'danger' : 'neutral');
    TrendIcon = TrendingDown;
  }

  return (
    <Card isHoverable={isHoverable} onClick={onClick} className="kpi-card">
      <div className="kpi-header">
        <span className="kpi-title">{title}</span>
        <div className="kpi-icon" style={{ backgroundColor: `${color}20`, color: color }}>
          {Icon && <Icon size={20} />}
        </div>
      </div>
      
      <div className="kpi-body">
        <h2 className="kpi-value">{percentage ? percentage : formatNumber(finalValue)}</h2>

        {trend && (
          <div className="kpi-trend neutral">
            <span style={{ marginLeft: 0 }}>{trend}</span>
          </div>
        )}
        
        {!trend && yoy !== null && (
          <div className={`kpi-trend ${trendClass}`}>
            <TrendIcon size={16} />
            <span>{Math.abs(yoy)}%</span>
          </div>
        )}
      </div>
    </Card>
  );
};
