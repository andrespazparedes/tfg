import React, { useEffect, useState } from 'react';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip as RechartsTooltip,
  ResponsiveContainer,
  Cell
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

export const RiesgoPorCicloChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        Object.entries(filters).forEach(([key, values]) => {
          values.forEach(val => params.append(key, val));
        });

        const response = await api.get('/dashboard/overview/charts/risk-by-cycle', { params });
        
        // Transformar datos para calcular porcentaje
        const chartData = response.data.data.map(item => {
          const perc = item.num_estudiantes > 0 
            ? (item.riesgo_abandono_critico / item.num_estudiantes) * 100 
            : 0;
            
          return {
            name: item.cod_ciclo,
            porcentaje: parseFloat(perc.toFixed(1)),
            criticos: item.riesgo_abandono_critico,
            total: item.num_estudiantes
          };
        }).sort((a, b) => b.porcentaje - a.porcentaje); // Ordenar por porcentaje descendente

        setData(chartData);
      } catch (error) {
        console.error("Error cargando riesgo por ciclo:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [filters]);

  if (loading) return <div className="loading-state">Cargando datos...</div>;
  if (!data || data.length === 0) return <div className="empty-state">No hay datos disponibles</div>;

  const CustomTooltip = ({ active, payload, label }) => {
    if (active && payload && payload.length) {
      const { porcentaje, criticos, total } = payload[0].payload;
      return (
        <div style={{ backgroundColor: 'var(--bg-card)', border: '1px solid var(--border-light)', padding: '10px', borderRadius: '8px', color: 'var(--text-primary)' }}>
          <p style={{ margin: '0 0 5px 0', fontWeight: 'bold' }}>{label}</p>
          <p style={{ margin: 0 }}><strong>{porcentaje}%</strong> en riesgo crítico</p>
          <p style={{ margin: 0, fontSize: '0.85rem', color: 'var(--text-secondary)' }}>{criticos} de {total} alumnos</p>
        </div>
      );
    }
    return null;
  };

  return (
    <div className="chart-container" style={{ height: 250, marginTop: '20px' }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} layout="vertical" margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="var(--border-color)" horizontal={false} />
          <XAxis type="number" stroke="var(--text-secondary)" domain={[0, 'dataMax + 5']} tickFormatter={(v) => `${v}%`} />
          <YAxis dataKey="name" type="category" stroke="var(--text-secondary)" width={60} />
          <RechartsTooltip content={<CustomTooltip />} cursor={{fill: 'var(--bg-card)'}} />
          <Bar dataKey="porcentaje" radius={[0, 4, 4, 0]} barSize={25}>
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill="var(--color-danger)" opacity={0.8} />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
