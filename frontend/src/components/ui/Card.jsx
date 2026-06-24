import React from 'react';
import './Card.css';

export const Card = ({ children, className = '', isHoverable = false, onClick }) => {
  return (
    <div 
      className={`glass-card ${isHoverable ? 'hoverable' : ''} ${className}`}
      onClick={onClick}
    >
      {children}
    </div>
  );
};
