import React from 'react';
import { MapPinOff } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export const NotFound = () => {
  const navigate = useNavigate();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '100%', minHeight: '60vh', textAlign: 'center', gap: '16px' }}>
      <MapPinOff size={64} color="var(--text-secondary)" />
      <h2 style={{ fontSize: '2rem', color: 'var(--text-primary)', margin: 0 }}>404 - Página no encontrada</h2>
      <p style={{ color: 'var(--text-secondary)', maxWidth: '400px' }}>
        Lo sentimos, la ruta a la que intentas acceder no existe en el sistema.
      </p>
      <button 
        onClick={() => navigate('/')}
        style={{ marginTop: '16px', padding: '10px 20px', borderRadius: '8px', cursor: 'pointer', border: 'none', backgroundColor: 'var(--color-primary)', color: 'white', fontWeight: '500' }}
      >
        Volver al Inicio
      </button>
    </div>
  );
};
