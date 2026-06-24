import React from 'react';
import {
  ScatterChart,
  Scatter,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip as RechartsTooltip,
  ResponsiveContainer,
  Cell,
  ReferenceLine
} from 'recharts';

export const MatrizRecursosChart = ({ centros }) => {
  if (!centros || centros.length === 0) {
    return <div className="empty-state">No hay datos disponibles</div>;
  }

  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload;
      return (
        <div style={{ backgroundColor: 'var(--bg-card)', border: '1px solid var(--border-light)', padding: '12px', borderRadius: '8px', color: 'var(--text-primary)', maxWidth: '250px' }}>
          <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', borderBottom: '1px solid var(--border-light)', paddingBottom: '4px' }}>
            {data.nombre_centro}
          </p>
          <p style={{ margin: '4px 0', fontSize: '0.9rem' }}>
            <span style={{ color: 'var(--text-secondary)' }}>Alumnado:</span> <strong>{data.num_estudiantes}</strong>
          </p>
          <p style={{ margin: '4px 0', fontSize: '0.9rem' }}>
            <span style={{ color: 'var(--text-secondary)' }}>Índice de Riesgo:</span> <strong>{data.indice_riesgo_centro.toFixed(1)} / 10</strong>
          </p>
        </div>
      );
    }
    return null;
  };

  // Determinar color por nivel de riesgo
  const getColor = (riesgo) => {
    if (riesgo >= 7) return 'var(--color-danger)';
    if (riesgo >= 4) return 'var(--color-warning)';
    return 'var(--color-success)';
  };

  // Calcular la media de alumnos para la línea de referencia
  const mediaAlumnos = centros.reduce((acc, c) => acc + (c.num_estudiantes || 0), 0) / centros.length;

  return (
    <div className="chart-container" style={{ height: 250, marginTop: '20px' }}>
      <ResponsiveContainer width="100%" height="100%">
        <ScatterChart margin={{ top: 20, right: 30, left: 0, bottom: 20 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="var(--border-color)" />
          
          <XAxis 
            type="number" 
            dataKey="num_estudiantes" 
            name="Alumnos" 
            stroke="var(--text-secondary)"
            label={{ value: 'Volumen de Estudiantes', position: 'insideBottom', offset: -15, fill: 'var(--text-secondary)', fontSize: 12 }}
          />
          
          <YAxis 
            type="number" 
            dataKey="indice_riesgo_centro" 
            name="Riesgo" 
            domain={[0, 10]} 
            stroke="var(--text-secondary)"
            label={{ value: 'Índice de Riesgo (0-10)', angle: -90, position: 'insideLeft', fill: 'var(--text-secondary)', fontSize: 12 }}
          />
          
          <RechartsTooltip content={<CustomTooltip />} cursor={{ strokeDasharray: '3 3' }} />
          
          {/* Líneas de cuadrantes (Media de alumnos y umbral crítico) */}
          <ReferenceLine y={7} stroke="var(--color-danger)" strokeDasharray="3 3" opacity={0.5} />
          <ReferenceLine x={mediaAlumnos} stroke="var(--color-primary)" strokeDasharray="3 3" opacity={0.3} />

          <Scatter data={centros} shape="circle">
            {centros.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={getColor(entry.indice_riesgo_centro)} opacity={0.8} />
            ))}
          </Scatter>
        </ScatterChart>
      </ResponsiveContainer>
    </div>
  );
};
