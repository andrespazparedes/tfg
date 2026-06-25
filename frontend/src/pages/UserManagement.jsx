import React, { useEffect, useState } from 'react';
import { useAuth } from '../context/AuthContext';
import { getUsers, createUser, updateUser, deleteUser } from '../api/users';
import { UserModal } from '../components/users/UserModal';
import { Card } from '../components/ui/Card';
import { Badge } from '../components/ui/Badge';
import { MultiSelect } from '../components/ui/MultiSelect';
import { Plus, Edit2, Trash2 } from 'lucide-react';
import { Forbidden } from './Forbidden';
import '../components/ui/StudentTable.css';
import './UserManagement.css';

export const UserManagement = () => {
  const { user: currentUser } = useAuth();
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  
  // Filtrado, Búsqueda y Ordenación
  const [searchTerm, setSearchTerm] = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [sortConfig, setSortConfig] = useState({ key: 'id', direction: 'asc' });

  // Modal state
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState(null);

  const fetchUsers = async () => {
    try {
      setError('');
      setLoading(true);
      const data = await getUsers();
      setUsers(data);
    } catch (err) {
      setError('Error al cargar la lista de usuarios. Verifica tus permisos.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleCreate = () => {
    setEditingUser(null);
    setIsModalOpen(true);
  };

  const handleEdit = (user) => {
    setEditingUser(user);
    setIsModalOpen(true);
  };

  const handleDelete = async (user) => {
    if (user.id === 1) {
      alert("No puedes borrar la cuenta del Superadmin.");
      return;
    }
    
    if (window.confirm(`¿Estás seguro de borrar al usuario ${user.email}?`)) {
      try {
        await deleteUser(user.id);
        fetchUsers();
      } catch (err) {
        alert(err.response?.data?.detail || "Error al borrar el usuario");
      }
    }
  };

  const handleSave = async (formData) => {
    if (editingUser) {
      await updateUser(editingUser.id, formData);
    } else {
      await createUser(formData);
    }
    fetchUsers();
  };

  const handleSort = (key) => {
    let direction = 'asc';
    if (sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });
  };

  const renderSortIcon = (key) => {
    if (sortConfig.key !== key) return <span className="sort-icon inactive">↕</span>;
    return <span className="sort-icon active">{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>;
  };

  const filteredAndSortedUsers = React.useMemo(() => {
    let result = [...users];

    // Filter by search term (email)
    if (searchTerm) {
      const term = searchTerm.toLowerCase();
      result = result.filter(u => u.email.toLowerCase().includes(term));
    }

    // Filter by role
    if (roleFilter) {
      result = result.filter(u => u.role === roleFilter);
    }

    // Sort
    result.sort((a, b) => {
      if (a[sortConfig.key] < b[sortConfig.key]) {
        return sortConfig.direction === 'asc' ? -1 : 1;
      }
      if (a[sortConfig.key] > b[sortConfig.key]) {
        return sortConfig.direction === 'asc' ? 1 : -1;
      }
      return 0;
    });

    return result;
  }, [users, searchTerm, roleFilter, sortConfig]);

  if (currentUser?.role !== 'admin') {
    return <Forbidden />;
  }

  return (
    <div className="users-page-container">
      <div className="page-header" style={{ marginBottom: '16px' }}>
        <div>
          <h1>Gestión de Usuarios</h1>
          <p className="subtitle">Administra los accesos y roles de la plataforma.</p>
        </div>
        <button 
          onClick={handleCreate}
          style={{
            display: 'inline-flex', alignItems: 'center', gap: '8px',
            backgroundColor: 'var(--color-primary)', color: 'white',
            padding: '8px 16px', borderRadius: '8px', fontWeight: '500',
            fontSize: '0.9rem', border: 'none', cursor: 'pointer',
            boxShadow: '0 4px 12px rgba(99, 102, 241, 0.3)',
            transition: 'all 0.2s ease'
          }}
          onMouseEnter={(e) => { 
            e.currentTarget.style.transform = 'translateY(-2px)'; 
            e.currentTarget.style.boxShadow = '0 6px 16px rgba(99, 102, 241, 0.4)';
            e.currentTarget.style.filter = 'brightness(1.1)';
          }}
          onMouseLeave={(e) => { 
            e.currentTarget.style.transform = 'none'; 
            e.currentTarget.style.boxShadow = '0 4px 12px rgba(99, 102, 241, 0.3)';
            e.currentTarget.style.filter = 'none';
          }}
        >
          <Plus size={18} /> Nuevo Usuario
        </button>
      </div>

      <div style={{ display: 'flex', gap: '16px', marginBottom: '24px' }}>
        <input
          type="text"
          className="table-filter-select"
          placeholder="Buscar por email..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          style={{ flex: 1, backgroundImage: 'none' }}
        />
        <div style={{ width: '250px' }}>
          <MultiSelect
            options={[
              { value: 'admin', label: 'Administrador' },
              { value: 'viewer', label: 'Visualizador' }
            ]}
            selectedValues={roleFilter ? [roleFilter] : []}
            onChange={(newVals) => setRoleFilter(newVals.length > 0 ? newVals[0] : '')}
            singleSelect={true}
            placeholder="Todos los roles"
          />
        </div>
      </div>

      {error && <div className="error-banner">{error}</div>}

      <Card className="table-wrapper">
        {loading ? (
          <div className="table-loading-overlay">Cargando usuarios...</div>
        ) : (
          <table className="student-table">
            <thead>
              <tr>
                <th onClick={() => handleSort('id')} style={{ cursor: 'pointer', userSelect: 'none' }}>ID {renderSortIcon('id')}</th>
                <th onClick={() => handleSort('email')} style={{ cursor: 'pointer', userSelect: 'none' }}>Email {renderSortIcon('email')}</th>
                <th onClick={() => handleSort('role')} style={{ cursor: 'pointer', userSelect: 'none' }}>Rol {renderSortIcon('role')}</th>
                <th onClick={() => handleSort('created_at')} style={{ cursor: 'pointer', userSelect: 'none' }}>Fecha Creación {renderSortIcon('created_at')}</th>
                <th className="text-center">Acciones</th>
              </tr>
            </thead>
            <tbody>
              {filteredAndSortedUsers.map(u => (
                <tr key={u.id}>
                  <td>{u.id}</td>
                  <td>{u.email}</td>
                  <td>
                    <div className="alerts-container">
                      <Badge type={u.role === 'admin' ? 'info' : 'success'} className="small-badge">
                        {u.role === 'admin' ? 'Administrador' : 'Visualizador'}
                      </Badge>
                    </div>
                  </td>
                  <td>{new Date(u.created_at).toLocaleDateString()}</td>
                  <td>
                    <div className="actions" style={{ justifyContent: 'center' }}>
                      <button 
                        className="action-btn edit" 
                        onClick={() => handleEdit(u)}
                        title="Editar"
                      >
                        <Edit2 size={16} />
                      </button>
                      <button 
                        className="action-btn delete" 
                        onClick={() => handleDelete(u)}
                        disabled={u.id === 1}
                        title={u.id === 1 ? "El superadmin no se puede borrar" : "Borrar"}
                      >
                        <Trash2 size={16} />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
              {filteredAndSortedUsers.length === 0 && (
                <tr>
                  <td colSpan="5" className="empty-state text-center" style={{ padding: '40px', color: 'var(--text-secondary)' }}>
                    No se encontraron usuarios que coincidan con la búsqueda.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        )}
      </Card>

      <UserModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onSave={handleSave}
        initialData={editingUser}
      />
    </div>
  );
};
