import React from 'react';
import { AlertOctagon } from 'lucide-react';

export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.error("Error caught by ErrorBoundary:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '100%', minHeight: '60vh', textAlign: 'center', gap: '16px' }}>
          <AlertOctagon size={64} color="var(--color-danger)" />
          <h2 style={{ fontSize: '2rem', color: 'var(--text-primary)', margin: 0 }}>Error Inesperado</h2>
          <p style={{ color: 'var(--text-secondary)', maxWidth: '500px' }}>
            Ha ocurrido un problema grave en la interfaz de usuario.
          </p>
          <button 
            onClick={() => window.location.href = '/'}
            style={{ marginTop: '16px', padding: '10px 20px', borderRadius: '8px', cursor: 'pointer', border: 'none', backgroundColor: 'var(--color-primary)', color: 'white', fontWeight: '500' }}
          >
            Recargar Aplicación
          </button>
        </div>
      );
    }

    return this.props.children; 
  }
}
