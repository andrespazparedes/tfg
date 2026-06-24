import React, { useEffect, useState } from 'react';
import { 
  BarChart, 
  Bar,
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

const CustomTooltip = ({ active, payload, label }) => {
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
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>{label}</p>
        <p style={{ color: payload[0].fill, margin: '4px 0', fontSize: '0.95rem' }}>
          Alumnos repetidores: <strong>{dataObj.repetidores}</strong>
        </p>
      </div>
    );
  }
  return null;
};

export const RepeatersByCourseChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/repeaters-by-course', { params });
        setData(response.data.data);
      } catch (error) {
        console.error("Error cargando RepeatersByCourseChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Cargando repetidores...</div>;
  }

  if (!data || data.length === 0) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>No hay datos suficientes</div>;
  }

  return (
    <div style={{ width: '100%', height: 300 }}>
      <ResponsiveContainer>
        <BarChart
          data={data}
          margin={{ top: 20, right: 30, left: 0, bottom: 0 }}
        >
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="name" 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)', fontSize: '0.85rem' }}
            axisLine={false}
            tickLine={false}
            dy={10}
          />
          <YAxis 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dx={-10}
          />
          <Tooltip content={<CustomTooltip />} cursor={{ fill: 'var(--bg-hover)' }} />
          <Bar 
            dataKey="repetidores" 
            fill="var(--color-purple)" 
            radius={[4, 4, 0, 0]} 
            animationDuration={1500}
            barSize={40}
          />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
