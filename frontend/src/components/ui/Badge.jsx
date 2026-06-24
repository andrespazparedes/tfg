import React from 'react';
import './Badge.css';

export const Badge = ({ type = 'info', children, className = '' }) => {
  return (
    <span className={`badge badge-${type} ${className}`}>
      {children}
    </span>
  );
};
