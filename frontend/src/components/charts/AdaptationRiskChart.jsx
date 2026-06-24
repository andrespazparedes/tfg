import React, { useEffect, useState } from 'react';
import { 
  BarChart, 
  Bar,
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  Legend
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

export const AdaptationRiskChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/adaptation-vs-risk', { params });
        setData(response.data.data);
      } catch (error) {
        console.error("Error cargando AdaptationRiskChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Cargando adaptaciones...</div>;
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
            tick={{ fill: 'var(--text-secondary)' }}
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
          <Tooltip 
            cursor={{ fill: 'var(--bg-hover)' }}
            contentStyle={{ backgroundColor: 'var(--bg-sidebar)', borderColor: 'var(--border-light)', borderRadius: '8px' }}
            itemStyle={{ fontWeight: 'bold' }}
          />
          <Legend verticalAlign="bottom" height={36} wrapperStyle={{ paddingTop: '20px', color: 'var(--text-secondary)' }} />
          <Bar dataKey="riesgo_bajo" name="Riesgo Bajo" stackId="a" fill="var(--color-success)" animationDuration={1500} />
          <Bar dataKey="riesgo_medio" name="Riesgo Medio" stackId="a" fill="var(--color-warning)" animationDuration={1500} />
          <Bar dataKey="riesgo_alto" name="Riesgo Alto" stackId="a" fill="var(--color-danger)" animationDuration={1500} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
