import React, { useEffect, useState } from 'react';
import { 
  AreaChart, 
  Area,
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { getMicroFailedSubjects } from '../../api/dashboard';

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
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>
          {label === "0" ? "Ningún suspenso" : label === "1" ? "1 suspenso" : `${label} suspensos`}
        </p>
        <p style={{ color: payload[0].color || payload[0].fill, margin: '4px 0', fontSize: '0.95rem' }}>
          Alumnos afectados: <strong>{dataObj.alumnos}</strong>
        </p>
        <p style={{ color: 'var(--text-secondary)', margin: '4px 0', fontSize: '0.85rem' }}>
          Porcentaje: {dataObj.porcentaje}%
        </p>
      </div>
    );
  }
  return null;
};

export const FailedSubjectsChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const response = await getMicroFailedSubjects(filters);
        setData(response.data);
      } catch (error) {
        console.error("Error cargando FailedSubjectsChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return (
      <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'var(--text-secondary)' }}>
        Cargando análisis de suspensos...
      </div>
    );
  }

  if (!data || data.length === 0) {
    return (
      <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'var(--text-secondary)' }}>
        No hay datos suficientes
      </div>
    );
  }

  return (
    <div style={{ width: '100%', height: 300 }}>
      <ResponsiveContainer>
        <AreaChart
          data={data}
          margin={{ top: 20, right: 30, left: 0, bottom: 0 }}
        >
          <defs>
            <linearGradient id="colorAlumnos" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="var(--color-danger)" stopOpacity={0.6}/>
              <stop offset="95%" stopColor="var(--color-warning)" stopOpacity={0.1}/>
            </linearGradient>
          </defs>
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="name" 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dy={10}
            tickFormatter={(value) => value === "0" ? "0" : value}
          />
          <YAxis 
            stroke="var(--text-secondary)" 
            tick={{ fill: 'var(--text-secondary)' }}
            axisLine={false}
            tickLine={false}
            dx={-10}
          />
          <Tooltip content={<CustomTooltip />} />
          <Area 
            type="monotone" 
            dataKey="alumnos" 
            stroke="var(--color-danger)" 
            fillOpacity={1} 
            fill="url(#colorAlumnos)" 
            strokeWidth={3}
            animationDuration={1500}
            animationEasing="ease-out"
          />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  );
};
