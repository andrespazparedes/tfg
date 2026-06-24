import React, { useEffect, useState } from 'react';
import { 
  ComposedChart, 
  Bar,
  Line,
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  Legend
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

const CustomTooltip = ({ active, payload, label }) => {
  if (active && payload && payload.length) {
    return (
      <div className="custom-tooltip" style={{
        backgroundColor: 'var(--bg-sidebar)',
        padding: '12px',
        border: '1px solid var(--border-light)',
        borderRadius: '8px',
        boxShadow: '0 4px 16px rgba(0,0,0,0.2)'
      }}>
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>{label}</p>
        {payload.map((entry, index) => (
          <p key={index} style={{ color: entry.color || entry.fill, margin: '4px 0', fontSize: '0.95rem' }}>
            {entry.name}: <strong>{entry.value}{entry.name.includes("Tasa") ? "%" : ""}</strong>
          </p>
        ))}
      </div>
    );
  }
  return null;
};

export const AdaptationPerformanceChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/adaptation-vs-performance', { params });
        setData(response.data.data);
      } catch (error) {
        console.error("Error cargando AdaptationPerformanceChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Cargando rendimiento...</div>;
  }

  if (!data || data.length === 0) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>No hay datos suficientes</div>;
  }

  return (
    <div style={{ width: '100%', height: 300 }}>
      <ResponsiveContainer>
        <ComposedChart
          data={data}
          margin={{ top: 20, right: 30, left: 0, bottom: 0 }}
        >
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="name" 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)', fontWeight: 'bold' }}
            axisLine={false}
            tickLine={false}
            dy={10}
          />
          <YAxis 
            yAxisId="left"
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dx={-10}
            unit="%"
            domain={[0, 100]}
          />
          <YAxis 
            yAxisId="right"
            orientation="right"
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dx={10}
          />
          <Tooltip content={<CustomTooltip />} cursor={{ fill: 'var(--bg-hover)' }} />
          <Legend verticalAlign="bottom" height={36} wrapperStyle={{ paddingTop: '20px', color: 'var(--text-secondary)' }} />
          <Bar yAxisId="left" dataKey="tasa_aprobado" name="Tasa Aprobados" fill="var(--color-primary)" radius={[4, 4, 0, 0]} barSize={40} animationDuration={1500} />
          <Line yAxisId="right" type="monotone" dataKey="suspensos" name="Media Suspensos" stroke="var(--color-danger)" strokeWidth={3} dot={{ r: 6 }} animationDuration={1500} />
        </ComposedChart>
      </ResponsiveContainer>
    </div>
  );
};
