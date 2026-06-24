import React from 'react';
import { ShieldAlert } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export const Forbidden = () => {
  const navigate = useNavigate();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '100%', minHeight: '60vh', textAlign: 'center', gap: '16px' }}>
      <ShieldAlert size={64} color="var(--color-danger)" />
      <h2 style={{ fontSize: '2rem', color: 'var(--text-primary)', margin: 0 }}>Acceso Denegado</h2>
      <p style={{ color: 'var(--text-secondary)', maxWidth: '400px' }}>
        No tienes los permisos necesarios para ver esta página o realizar esta acción.
      </p>
      <button 
        onClick={() => navigate('/')}
        className="btn btn-primary"
        style={{ marginTop: '16px', padding: '10px 20px', borderRadius: '8px', cursor: 'pointer', border: 'none', backgroundColor: 'var(--color-primary)', color: 'white', fontWeight: '500' }}
      >
        Volver al Inicio
      </button>
    </div>
  );
};
