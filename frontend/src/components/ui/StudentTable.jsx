import React, { useEffect, useState } from 'react';
import { useDashboardContext } from '../../context/DashboardContext';
import { getMicroStudents } from '../../api/dashboard';
import { Badge } from './Badge';
import { ChevronLeft, ChevronRight, AlertTriangle, ArrowRight, X } from 'lucide-react';
import { MultiSelect } from './MultiSelect';
import './StudentTable.css';

export const StudentTable = () => {
  const { filters, activeAlerts, setActiveAlerts, triggerDrilldown, clearDrilldown } = useDashboardContext();
  const [data, setData] = useState([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  
  // Paginación y ordenación
  const [page, setPage] = useState(1);
  const pageSize = 25;
  const [sortBy, setSortBy] = useState('riesgo_abandono');
  const [sortDesc, setSortDesc] = useState(true);

  useEffect(() => {
    // Resetear a la página 1 cuando cambian los filtros principales
    setPage(1);
  }, [filters, activeAlerts]);

  useEffect(() => {
    const fetchStudents = async () => {
      setLoading(true);
      try {
        const alertParams = {};
        if (activeAlerts && activeAlerts.length > 0) {
          activeAlerts.forEach((alertKey) => {
            alertParams[alertKey] = 'true';
          });
        }

        const response = await getMicroStudents(filters, {
          ...alertParams,
          page,
          page_size: pageSize,
          sort_by: sortBy,
          sort_desc: sortDesc,
        });
        setData(response.data);
        setTotal(response.total);
      } catch (error) {
        console.error("Error cargando StudentTable:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchStudents();
  }, [filters, activeAlerts, page, pageSize, sortBy, sortDesc]);

  const handleSort = (column) => {
    if (sortBy === column) {
      setSortDesc(!sortDesc);
    } else {
      setSortBy(column);
      setSortDesc(true); // Por defecto descendente al cambiar de columna
    }
  };

  const renderSortIcon = (column) => {
    if (sortBy !== column) return <span className="sort-icon inactive">↕</span>;
    return <span className="sort-icon active">{sortDesc ? '↓' : '↑'}</span>;
  };

  const totalPages = Math.ceil(total / pageSize);

  return (
    <div className="student-table-container">
      {loading && <div className="table-loading-overlay">Actualizando datos...</div>}
      
      <div className="table-toolbar" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px', padding: '0 16px', paddingTop: '16px' }}>
        <div className="table-filters" style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
          <span style={{ fontSize: '0.9rem', color: 'var(--text-secondary)', whiteSpace: 'nowrap' }}>Filtro Rápido:</span>
          <div style={{ width: '300px' }}>
            <MultiSelect 
              singleSelect={false}
              placeholder="Todas las alertas"
              options={[
                { value: 'alerta_riesgo_alto', label: 'Alto Riesgo de Abandono' },
                { value: 'alerta_suspensos', label: 'Alumnos con Suspensos' },
                { value: 'alerta_desfase_edad', label: 'Desfase Académico' },
                { value: 'is_repetidor', label: 'Alumnos Repetidores' },
                { value: 'alerta_renta_baja', label: 'Riesgo Socioeconómico Alto' },
                { value: 'alerta_brecha_digital', label: 'Brecha Digital' },
                { value: 'alerta_bajo_estudios', label: 'Bajo Nivel Estudios Familia' },
                { value: 'alerta_adaptacion', label: 'Adaptación Curricular' },
                { value: 'alerta_repetidores_pri', label: 'Repetidores 1º/2º Primaria' },
                { value: 'alerta_suspensos_pri', label: 'Suspensos 1º/2º Primaria' }
              ]}
              selectedValues={activeAlerts || []}
              onChange={(newVals) => {
                setActiveAlerts(newVals);
              }}
            />
          </div>
          {activeAlerts && activeAlerts.length > 0 && (
            <button 
              onClick={clearDrilldown}
              style={{
                display: 'flex', alignItems: 'center', gap: '4px',
                background: 'transparent', border: 'none', 
                color: 'var(--text-secondary)', cursor: 'pointer',
                fontSize: '0.85rem', padding: '4px 8px', borderRadius: '4px'
              }}
              onMouseEnter={(e) => { e.currentTarget.style.color = 'var(--text-primary)'; e.currentTarget.style.background = 'rgba(255,255,255,0.05)'; }}
              onMouseLeave={(e) => { e.currentTarget.style.color = 'var(--text-secondary)'; e.currentTarget.style.background = 'transparent'; }}
            >
              <X size={14} /> Limpiar
            </button>
          )}
        </div>
        <div className="table-stats" style={{ fontSize: '0.9rem', color: 'var(--text-secondary)' }}>
          Total: <strong style={{ color: 'var(--text-primary)' }}>{total.toLocaleString('es-ES')}</strong> alumnos
        </div>
      </div>

      <div className="table-wrapper">
        <table className="student-table">
          <thead>
            <tr>
              <th onClick={() => handleSort('num_expediente')}>Expediente {renderSortIcon('num_expediente')}</th>
              <th onClick={() => handleSort('nombre_centro')}>Centro {renderSortIcon('nombre_centro')}</th>
              <th onClick={() => handleSort('nombre_ciclo')}>Ciclo / Curso {renderSortIcon('nombre_ciclo')}</th>
              <th onClick={() => handleSort('tasa_aprobado')} className="text-center">Tasa Aprobado {renderSortIcon('tasa_aprobado')}</th>
              <th onClick={() => handleSort('riesgo_abandono')} className="text-center">Riesgo {renderSortIcon('riesgo_abandono')}</th>
              <th>Alertas</th>
            </tr>
          </thead>
          <tbody>
            {data.length === 0 ? (
              <tr>
                <td colSpan="6" className="text-center empty-state">No se encontraron estudiantes para los filtros seleccionados.</td>
              </tr>
            ) : (
              data.map(student => (
                <tr key={student.id_estudiante}>
                  <td className="font-medium">
                    <div className="student-expediente">Exp: {student.num_expediente}</div>
                  </td>
                  <td>{student.nombre_centro}</td>
                  <td>
                    {student.nombre_ciclo}
                    <div className="student-expediente">Curso {student.num_curso}º</div>
                  </td>
                  <td className="text-center">
                    {student.tasa_aprobado !== null ? `${student.tasa_aprobado.toFixed(1)}%` : 'N/A'}
                  </td>
                  <td className="text-center">
                    <Badge type={
                      student.desglose_riesgo.nivel_riesgo === 'Alto' ? 'danger' :
                      student.desglose_riesgo.nivel_riesgo === 'Medio' ? 'warning' : 'success'
                    }>
                      {student.desglose_riesgo.total_pts !== null ? `${student.desglose_riesgo.total_pts.toFixed(1)} pts` : 'N/A'}
                    </Badge>
                  </td>
                  <td>
                    <div className="alerts-container">
                      {student.alertas.brecha_digital && <Badge type="danger" className="small-badge">Brecha Digital</Badge>}
                      {student.alertas.renta_baja && <Badge type="danger" className="small-badge">Renta Baja</Badge>}
                      {student.alertas.is_repetidor && <Badge type="info" className="small-badge">Repetidor</Badge>}
                      {student.desglose_riesgo.adaptacion_pts >= 10 && <Badge type="success" className="small-badge">Discapacidad</Badge>}
                      {(student.desglose_riesgo.adaptacion_pts === 5 || student.desglose_riesgo.adaptacion_pts === 15) && <Badge type="success" className="small-badge">Compensatoria</Badge>}
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Paginación */}
      {totalPages > 1 && (
        <div className="table-pagination">
          <span className="pagination-info">Mostrando {(page - 1) * pageSize + 1} - {Math.min(page * pageSize, total)} de {total} estudiantes</span>
          <div className="pagination-controls">
            <button 
              className="pagination-btn" 
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1}
            >
              <ChevronLeft size={16} />
            </button>
            <span className="page-number">Página {page} de {totalPages}</span>
            <button 
              className="pagination-btn" 
              onClick={() => setPage(p => Math.min(totalPages, p + 1))}
              disabled={page === totalPages}
            >
              <ChevronRight size={16} />
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
