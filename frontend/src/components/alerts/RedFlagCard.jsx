import React from 'react';
import './RedFlagCard.css';

export default function RedFlagCard({ title, count, description, type = 'danger' }) {
  return (
    <div className={`red-flag-card red-flag-card--${type}`}>
      <div className="red-flag-content">
        <h4 className="red-flag-title">{title}</h4>
        <p className="red-flag-description">{description}</p>
      </div>
      <div className="red-flag-count-badge">
        {count || 0}
      </div>
    </div>
  );
}
