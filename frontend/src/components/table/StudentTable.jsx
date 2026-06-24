import React from 'react';
import './StudentTable.css';

function getProgressColor(value) {
  if (value >= 70) return '#16a34a';
  if (value >= 40) return '#d97706';
  return '#dc2626';
}

function getRiskBadgeClass(riesgo) {
  if (riesgo <= 25) return 'badge--success';
  if (riesgo <= 50) return 'badge--warning';
  return 'badge--danger';
}

export default function StudentTable({
  data,
  total,
  page,
  pageSize,
  onPageChange,
  riesgoNivel,
  setRiesgoNivel,
  isRepetidor,
  setIsRepetidor,
  sortConfig,
  setSortConfig,
}) {
  const totalPages = Math.ceil(total / pageSize) || 1;

  const handleSort = (key) => {
    let direction = 'desc';
    if (sortConfig.key === key && sortConfig.direction === 'desc') {
      direction = 'asc';
    }
    setSortConfig({ key, direction });
  };

  const getSortIndicator = (key) => {
    if (sortConfig.key !== key) return null;
    return sortConfig.direction === 'desc' ? ' ↓' : ' ↑';
  };

  return (
    <div className="student-table-wrapper">
      <div className="student-table__toolbar">
        <div className="student-table__filters">
          <div className="filter-group">
            <label className="filter-label">Riesgo:</label>
            <select
              className="filter-select"
              value={riesgoNivel}
              onChange={(e) => setRiesgoNivel(e.target.value)}
            >
              <option value="Todos">Todos</option>
              <option value="Bajo">Bajo (0-25)</option>
              <option value="Medio">Medio (26-50)</option>
              <option value="Alto">Alto (>50)</option>
            </select>
          </div>
          
          <div className="filter-group">
            <label className="filter-label">Repetidor:</label>
            <select
              className="filter-select"
              value={isRepetidor}
              onChange={(e) => setIsRepetidor(e.target.value)}
            >
              <option value="Todos">Todos</option>
              <option value="Sí">Sí</option>
              <option value="No">No</option>
            </select>
          </div>
        </div>
        <span style={{ fontSize: 13, color: 'var(--text-muted)' }}>
          {total.toLocaleString('es-ES')} alumno{total !== 1 ? 's' : ''}
        </span>
      </div>

      {(!data || data.length === 0) ? (
        <div className="student-table__empty">
          No se encontraron alumnos
        </div>
      ) : (
        <>
          <div className="student-table__scroll">
            <table className="student-table">
              <thead>
                <tr>
                  <th onClick={() => handleSort('num_expediente')} className="sortable">
                    Expediente{getSortIndicator('num_expediente')}
                  </th>
                  <th onClick={() => handleSort('nombre')} className="sortable">
                    Nombre{getSortIndicator('nombre')}
                  </th>
                  <th onClick={() => handleSort('nombre_centro')} className="sortable">
                    Centro{getSortIndicator('nombre_centro')}
                  </th>
                  <th onClick={() => handleSort('nombre_ciclo')} className="sortable">
                    Ciclo{getSortIndicator('nombre_ciclo')}
                  </th>
                  <th onClick={() => handleSort('num_curso')} className="sortable">
                    Curso{getSortIndicator('num_curso')}
                  </th>
                  <th onClick={() => handleSort('tasa_aprobado')} className="sortable">
                    Tasa Aprobado{getSortIndicator('tasa_aprobado')}
                  </th>
                  <th onClick={() => handleSort('is_repetidor')} className="sortable">
                    Repetidor{getSortIndicator('is_repetidor')}
                  </th>
                  <th onClick={() => handleSort('riesgo_abandono')} className="sortable">
                    Riesgo Abandono{getSortIndicator('riesgo_abandono')}
                  </th>
                </tr>
              </thead>
              <tbody>
                {data.map((student, index) => {
                  const tasaPercent = Math.min(
                    100,
                    Math.max(0, (student.tasa_aprobado ?? 0))
                  );
                  const riesgoScore = student.riesgo_abandono ?? 0;

                  return (
                    <tr key={student.num_expediente || index}>
                      <td>{student.num_expediente}</td>
                      <td>{student.nombre}</td>
                      <td>{student.nombre_centro}</td>
                      <td>
                        <span className="badge badge--accent">
                          {student.nombre_ciclo}
                        </span>
                      </td>
                      <td>{student.num_curso}</td>
                      <td>
                        <div className="progress-bar">
                          <div className="progress-bar__track">
                            <div
                              className="progress-bar__fill"
                              style={{
                                width: `${tasaPercent}%`,
                                backgroundColor: getProgressColor(tasaPercent),
                              }}
                            />
                          </div>
                          <span className="progress-bar__label">
                            {tasaPercent.toFixed(0)}%
                          </span>
                        </div>
                      </td>
                      <td>
                        <span
                          className={`badge ${
                            student.is_repetidor
                              ? 'badge--danger'
                              : 'badge--success'
                          }`}
                        >
                          {student.is_repetidor ? 'Sí' : 'No'}
                        </span>
                      </td>
                      <td>
                        <span
                          className={`badge ${getRiskBadgeClass(
                            riesgoScore
                          )}`}
                        >
                          {riesgoScore.toFixed(0)} pts
                        </span>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>

          <div className="student-table__pagination">
            <span className="student-table__page-info">
              Página {page} de {totalPages}
            </span>
            <div className="student-table__page-buttons">
              <button
                className="student-table__page-btn"
                disabled={page <= 1}
                onClick={() => onPageChange(page - 1)}
              >
                Anterior
              </button>
              <button
                className="student-table__page-btn"
                disabled={page >= totalPages}
                onClick={() => onPageChange(page + 1)}
              >
                Siguiente
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
