import React, { useState, useEffect } from 'react';
import { X, Save } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { MultiSelect } from '../ui/MultiSelect';
import '../ui/Card.css';
import '../ui/StudentTable.css';
import './UserModal.css';

export const UserModal = ({ isOpen, onClose, onSave, initialData }) => {
  const { user: currentUser } = useAuth();
  
  const [formData, setFormData] = useState({
    email: '',
    role: 'viewer',
    password: '',
    confirmPassword: ''
  });

  const [error, setError] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const isSuperadmin = currentUser?.id === 1; // El superadmin es siempre el primer usuario de la BBDD
  const isEditing = !!initialData;

  useEffect(() => {
    if (initialData) {
      setFormData({
        email: initialData.email || '',
        role: initialData.role || 'viewer',
        password: '', // No rellenamos la contraseña al editar
        confirmPassword: ''
      });
    } else {
      setFormData({
        email: '',
        role: 'viewer',
        password: '',
        confirmPassword: ''
      });
    }
    setError('');
  }, [initialData, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    // Validaciones básicas manuales por si acaso
    if (!formData.email) {
      setError('El email es obligatorio');
      return;
    }
    if (!isEditing) {
      if (!formData.password || formData.password.length < 8) {
        setError('La contraseña debe tener al menos 8 caracteres');
        return;
      }
      if (formData.password !== formData.confirmPassword) {
        setError('Las contraseñas no coinciden');
        return;
      }
    } else {
      if (formData.password || formData.confirmPassword) {
        if (!formData.password || formData.password.length < 8) {
          setError('La nueva contraseña debe tener al menos 8 caracteres (déjela en blanco para no cambiarla)');
          return;
        }
        if (formData.password !== formData.confirmPassword) {
          setError('Las contraseñas no coinciden');
          return;
        }
      }
    }

    try {
      setIsSubmitting(true);
      const payload = { ...formData };
      delete payload.confirmPassword;
      if (!payload.password) {
        delete payload.password;
      }
      await onSave(payload);
      onClose();
    } catch (err) {
      setError(err.response?.data?.detail || 'Error al guardar el usuario');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="modal-overlay">
      <div className="modal-content glass-card">
        <div className="modal-header">
          <h2>{isEditing ? 'Editar Usuario' : 'Nuevo Usuario'}</h2>
          <button className="close-btn" onClick={onClose}><X size={20} /></button>
        </div>
        
        <form onSubmit={handleSubmit} className="modal-body" autoComplete="off">
          
          <div className="form-group">
            <label>Correo Electrónico</label>
            <input 
              type="email" 
              className="table-filter-select"
              style={{ backgroundImage: 'none', width: '100%', boxSizing: 'border-box' }}
              value={formData.email}
              onChange={(e) => setFormData({...formData, email: e.target.value})}
              placeholder="usuario@ejemplo.com"
              required
              autoComplete="new-password" // "new-password" u "off" funciona mejor en Chrome para evitar autofill
            />
          </div>

          <div className="form-group">
            <label>Rol</label>
            <div style={(!isSuperadmin || initialData?.id === 1) ? { pointerEvents: 'none', opacity: 0.6 } : {}}>
              <MultiSelect
                options={[
                  { value: 'admin', label: 'Administrador' },
                  { value: 'viewer', label: 'Visualizador' }
                ]}
                selectedValues={formData.role ? [formData.role] : []}
                onChange={(newVals) => setFormData({...formData, role: newVals.length > 0 ? newVals[0] : 'viewer'})}
                singleSelect={true}
                placeholder="Seleccionar rol"
              />
            </div>
            {initialData?.id === 1 && (
              <span className="help-text">El rol del Superadmin no puede ser modificado.</span>
            )}
            {!isSuperadmin && initialData?.id !== 1 && (
              <span className="help-text">Solo el Superadmin puede asignar el rol de Administrador.</span>
            )}
          </div>

          <div className="form-group">
            <label>Contraseña {isEditing && '(Opcional)'}</label>
            <input 
              type="password" 
              className="table-filter-select"
              style={{ backgroundImage: 'none', width: '100%', boxSizing: 'border-box' }}
              value={formData.password}
              onChange={(e) => setFormData({...formData, password: e.target.value})}
              placeholder={isEditing ? "Dejar en blanco para no cambiar" : "Contraseña inicial (min 8)"}
              minLength={8}
              required={!isEditing || !!formData.confirmPassword}
              autoComplete="new-password"
            />
          </div>

          <div className="form-group">
            <label>Repetir Contraseña</label>
            <input 
              type="password" 
              className="table-filter-select"
              style={{ backgroundImage: 'none', width: '100%', boxSizing: 'border-box' }}
              value={formData.confirmPassword}
              onChange={(e) => setFormData({...formData, confirmPassword: e.target.value})}
              placeholder="Repite la contraseña"
              minLength={8}
              required={!isEditing || !!formData.password}
              autoComplete="new-password"
            />
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onClose}>Cancelar</button>
            <button type="submit" className="btn btn-primary" disabled={isSubmitting} style={{
              display: 'inline-flex', alignItems: 'center', gap: '8px',
              backgroundColor: 'var(--color-primary)', color: 'white',
              padding: '8px 16px', borderRadius: '8px', fontWeight: '500',
              fontSize: '0.9rem', border: 'none', cursor: 'pointer',
              boxShadow: '0 4px 12px rgba(99, 102, 241, 0.3)',
              transition: 'all 0.2s ease'
            }}
            onMouseEnter={(e) => { 
              if(isSubmitting) return;
              e.currentTarget.style.transform = 'translateY(-2px)'; 
              e.currentTarget.style.boxShadow = '0 6px 16px rgba(99, 102, 241, 0.4)';
              e.currentTarget.style.filter = 'brightness(1.1)';
            }}
            onMouseLeave={(e) => { 
              if(isSubmitting) return;
              e.currentTarget.style.transform = 'none'; 
              e.currentTarget.style.boxShadow = '0 4px 12px rgba(99, 102, 241, 0.3)';
              e.currentTarget.style.filter = 'none';
            }}>
              <Save size={16} /> {isSubmitting ? 'Guardando...' : 'Guardar'}
            </button>
          </div>
          {error && <div className="modal-error" style={{ marginTop: '16px', marginBottom: 0 }}>{error}</div>}
        </form>
      </div>
    </div>
  );
};
