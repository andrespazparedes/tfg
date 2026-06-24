import React, { useEffect, useState } from 'react';
import { 
  ScatterChart, 
  Scatter, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  ZAxis
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

const CustomTooltip = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const dataObj = payload[0].payload;
    return (
      <div className="custom-tooltip" style={{
        backgroundColor: 'var(--bg-sidebar)',
        padding: '12px',
        border: '1px solid var(--border-light)',
        borderRadius: '8px',
        boxShadow: '0 4px 16px rgba(0,0,0,0.2)'
      }}>
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>Correlación</p>
        <p style={{ color: 'var(--color-primary)', margin: '4px 0', fontSize: '0.95rem' }}>
          Renta: <strong>{dataObj.renta} u.c.</strong>
        </p>
        <p style={{ color: 'var(--color-danger)', margin: '4px 0', fontSize: '0.95rem' }}>
          Suspensos: <strong>{dataObj.suspensos}</strong>
        </p>
      </div>
    );
  }
  return null;
};

export const IncomeFailuresScatterChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/correlation-income-failures', { params });
        setData(response.data.data);
      } catch (error) {
        console.error("Error cargando IncomeFailuresScatterChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Procesando correlaciones...</div>;
  }

  if (!data || data.length === 0) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>No hay datos suficientes</div>;
  }

  return (
    <div style={{ width: '100%', height: 300 }}>
      <ResponsiveContainer>
        <ScatterChart margin={{ top: 20, right: 20, bottom: 20, left: 0 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="var(--border-light)" />
          <XAxis 
            type="number" 
            dataKey="renta" 
            name="Renta (u.c.)" 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            tickFormatter={(val) => val.toLocaleString()}
          />
          <YAxis 
            type="number" 
            dataKey="suspensos" 
            name="Suspensos" 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dx={-10}
          />
          <ZAxis type="number" range={[20, 20]} />
          <Tooltip cursor={{ strokeDasharray: '3 3', stroke: 'var(--text-secondary)' }} content={<CustomTooltip />} />
          <Scatter name="Alumnos" data={data} fill="var(--color-primary)" opacity={0.6} animationDuration={1500} />
        </ScatterChart>
      </ResponsiveContainer>
    </div>
  );
};
