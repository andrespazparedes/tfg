import React, { useEffect, useState } from 'react';
import { NavLink } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Users, 
  GraduationCap, 
  Sun, 
  Moon, 
  ChevronLeft,
  Menu,
  RefreshCcw,
  LogOut
} from 'lucide-react';
import { useDashboardContext } from '../../context/DashboardContext';
import { useAuth } from '../../context/AuthContext';
import { api } from '../../services/api';
import { MultiSelect } from '../ui/MultiSelect';
import './Sidebar.css';

export const Sidebar = ({ isOpen, toggleSidebar }) => {
  const { theme, toggleTheme, filters, updateFilter, resetFilters } = useDashboardContext();
  const { logout } = useAuth();
  const [filterOptions, setFilterOptions] = useState({ centros: [], ciclos: [], cursos_academicos: [], tipos_centro: [] });

  useEffect(() => {
    // Cargar las opciones de los desplegables desde la API
    const loadFilters = async () => {
      try {
        const res = await api.get('/dashboard/filters');
        const cursos = res.data.cursos_academicos || [];
        
        setFilterOptions({
          centros: res.data.centros || [],
          ciclos: res.data.ciclos || [],
          cursos_academicos: cursos,
          tipos_centro: res.data.tipos_centro || []
        });

        // Seleccionar por defecto el último curso académico si no hay ninguno seleccionado
        if (cursos.length > 0 && filters.curso_academico.length === 0) {
          const sortedCursos = [...cursos].sort();
          const latestCurso = sortedCursos[sortedCursos.length - 1];
          updateFilter('curso_academico', [latestCurso]);
        }
      } catch (err) {
        console.error("Error cargando filtros:", err);
      }
    };
    loadFilters();
  }, []);

  const handleFilterChange = (newValues, filterKey) => {
    updateFilter(filterKey, newValues); // Ahora recibimos directamente el array del MultiSelect
  };

  return (
    <aside className={`sidebar ${isOpen ? 'open' : 'closed'}`}>
      <div className="sidebar-header">
        {isOpen && <h2 className="brand">EduAnalytics</h2>}
        <button onClick={toggleSidebar} className="toggle-btn" title="Alternar menú">
          {isOpen ? <ChevronLeft size={20} /> : <Menu size={20} />}
        </button>
      </div>

      <nav className="sidebar-nav">
        <NavLink to="/macro" className={({ isActive }) => `nav-link ${isActive ? 'active' : ''}`} title="Centro de Mando">
          <LayoutDashboard size={22} />
          {isOpen && <span>Centro de Mando</span>}
        </NavLink>
        <NavLink to="/micro" className={({ isActive }) => `nav-link ${isActive ? 'active' : ''}`} title="Análisis de Centro">
          <LayoutDashboard size={22} />
          {isOpen && <span>Análisis de Centro</span>}
        </NavLink>

      </nav>

      {isOpen && (
        <div className="sidebar-filters">
          <div className="filters-header">
            <h3>Filtros Globales</h3>
            <button 
              className="reset-filters-btn" 
              onClick={() => {
                let latestCurso = [];
                if (filterOptions.cursos_academicos.length > 0) {
                  const sortedCursos = [...filterOptions.cursos_academicos].sort();
                  latestCurso = [sortedCursos[sortedCursos.length - 1]];
                }
                resetFilters(latestCurso);
              }} 
              title="Limpiar todos los filtros"
            >
              <RefreshCcw size={14} /> Resetear
            </button>
          </div>
          
          <div className="filter-group">
            <label>Curso Académico</label>
            <MultiSelect 
              options={filterOptions.cursos_academicos.map(c => ({ value: c, label: c }))}
              selectedValues={filters.curso_academico}
              onChange={(vals) => handleFilterChange(vals, 'curso_academico')}
              placeholder="Último año"
              singleSelect={true}
            />
          </div>

          <div className="filter-group">
            <label>Tipo de Centro</label>
            <MultiSelect 
              options={filterOptions.tipos_centro.map(t => ({ value: t, label: t }))}
              selectedValues={filters.tipo_centro}
              onChange={(vals) => handleFilterChange(vals, 'tipo_centro')}
              placeholder="Todos los tipos"
            />
          </div>

          <div className="filter-group">
            <label>Centro Educativo</label>
            <MultiSelect 
              options={filterOptions.centros} 
              selectedValues={filters.cod_centro}
              onChange={(vals) => handleFilterChange(vals, 'cod_centro')}
              placeholder="Todos los centros"
              searchable={true}
            />
          </div>

          <div className="filter-group">
            <label>Ciclo Formativo</label>
            <MultiSelect 
              options={filterOptions.ciclos} // Ya vienen como {value, label} del backend
              selectedValues={filters.cod_ciclo}
              onChange={(vals) => handleFilterChange(vals, 'cod_ciclo')}
              placeholder="Todos los ciclos"
            />
          </div>
        </div>
      )}

      <div className="sidebar-footer">
        <button onClick={toggleTheme} className="theme-toggle" title="Cambiar tema">
          {theme === 'dark' ? <Sun size={20} /> : <Moon size={20} />}
          {isOpen && <span>Modo {theme === 'dark' ? 'Claro' : 'Oscuro'}</span>}
        </button>
        <button onClick={logout} className="logout-btn" title="Cerrar sesión" style={{ color: 'var(--color-danger)' }}>
          <LogOut size={20} />
          {isOpen && <span>Cerrar sesión</span>}
        </button>
      </div>
    </aside>
  );
};
