import React, { useEffect, useState } from 'react';
import { 
  ComposedChart, 
  Line,
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  Legend,
  Area
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { getMacroTrend } from '../../api/dashboard';

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
          <p key={index} style={{ color: entry.color || entry.fill, margin: '4px 0', fontSize: '0.9rem' }}>
            {entry.name}: <strong>{entry.value.toFixed(2)}</strong> / 10
          </p>
        ))}
      </div>
    );
  }
  return null;
};

export const TendenciaGlobalChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const response = await getMacroTrend(filters);
        const sortedData = response.data.sort((a, b) => a.curso_academico.localeCompare(b.curso_academico));
        setData(sortedData);
      } catch (error) {
        console.error("Error cargando TendenciaGlobalChart:", error);
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
    return <div className="placeholder-chart">No hay datos históricos para los filtros seleccionados</div>;
  }

  return (
    <div style={{ width: '100%', height: 280 }}>
      <ResponsiveContainer width="100%" height="100%">
        <ComposedChart data={data} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
          <defs>
            <linearGradient id="colorIndice" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="var(--color-primary)" stopOpacity={0.4}/>
              <stop offset="95%" stopColor="var(--color-primary)" stopOpacity={0}/>
            </linearGradient>
          </defs>
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="curso_academico" 
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <YAxis 
            domain={[0, 10]}
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <Tooltip content={<CustomTooltip />} cursor={{ fill: 'var(--border-light)', opacity: 0.2 }} />
          <Legend wrapperStyle={{ paddingTop: '20px' }} />
          
          <Area 
            type="monotone" 
            dataKey="indice_riesgo_medio" 
            name="Índice de Riesgo Medio (Autonómico)" 
            fillOpacity={1} 
            fill="url(#colorIndice)" 
            stroke="var(--color-primary)" 
            strokeWidth={3}
            activeDot={{ r: 6, fill: "var(--color-primary)", stroke: "white", strokeWidth: 2 }}
          />
        </ComposedChart>
      </ResponsiveContainer>
    </div>
  );
};
