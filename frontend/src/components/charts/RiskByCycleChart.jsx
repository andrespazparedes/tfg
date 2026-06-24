import React, { useEffect, useState } from 'react';
import { 
  BarChart, 
  Bar, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  Cell
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

const CustomTooltip = ({ active, payload, label }) => {
  if (active && payload && payload.length) {
    return (
      <div style={{
        backgroundColor: 'var(--bg-sidebar)',
        padding: '12px',
        border: '1px solid var(--border-light)',
        borderRadius: '8px',
        boxShadow: '0 4px 16px rgba(0,0,0,0.2)'
      }}>
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>
          Ciclo: {label}
        </p>
        <p style={{ margin: '0', color: 'var(--color-danger)', fontSize: '0.9rem' }}>
          Riesgo Crítico: <strong>{payload[0].value}</strong> alumnos
        </p>
        <p style={{ margin: '4px 0 0 0', color: 'var(--text-secondary)', fontSize: '0.85rem' }}>
          De un total de {payload[0].payload.num_estudiantes} matriculados
        </p>
      </div>
    );
  }
  return null;
};

export const RiskByCycleChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        Object.entries(filters).forEach(([key, values]) => {
          values.forEach(val => params.append(key, val));
        });

        const response = await api.get('/dashboard/overview/charts/risk-by-cycle', { params });
        // Ordenamos de mayor a menor riesgo para que sea más fácil de leer
        const sortedData = response.data.data.sort((a, b) => b.riesgo_abandono_critico - a.riesgo_abandono_critico);
        
        // Mostrar top 5 si hay muchos
        setData(sortedData.slice(0, 5));
      } catch (error) {
        console.error("Error cargando RiskByCycleChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div className="placeholder-chart">Cargando gráfico...</div>;
  }

  if (data.length === 0) {
    return <div className="placeholder-chart">Sin datos para los ciclos seleccionados</div>;
  }

  return (
    <div style={{ width: '100%', height: 280 }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart 
          data={data} 
          layout="vertical"
          margin={{ top: 10, right: 30, left: 10, bottom: 0 }}
        >
          <CartesianGrid strokeDasharray="3 3" horizontal={false} stroke="var(--border-light)" />
          <XAxis 
            type="number" 
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <YAxis 
            type="category" 
            dataKey="cod_ciclo" 
            tick={{ fill: 'var(--text-primary)', fontSize: 12, fontWeight: 500 }}
            axisLine={false}
            tickLine={false}
            width={70}
          />
          <Tooltip cursor={{ fill: 'var(--border-light)', opacity: 0.5 }} content={<CustomTooltip />} />
          
          <Bar 
            dataKey="riesgo_abandono_critico" 
            radius={[0, 4, 4, 0]}
            barSize={24}
          >
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill="var(--color-danger)" />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
