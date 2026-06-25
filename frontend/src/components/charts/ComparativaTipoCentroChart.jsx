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
import { getMacroRiskByType } from '../../api/dashboard';

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
        <p style={{ color: payload[0].color || payload[0].fill, margin: '4px 0', fontSize: '0.9rem' }}>
          Índice de Riesgo Medio: <strong>{dataObj.indice_riesgo_medio.toFixed(2)}</strong> / 10
        </p>
        <p style={{ color: 'var(--text-secondary)', margin: '4px 0', fontSize: '0.8rem' }}>
          Centros analizados: {dataObj.num_centros}
        </p>
      </div>
    );
  }
  return null;
};

export const ComparativaTipoCentroChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const response = await getMacroRiskByType(filters);
        const sortedData = response.data.sort((a, b) => b.indice_riesgo_medio - a.indice_riesgo_medio);
        setData(sortedData);
      } catch (error) {
        console.error("Error cargando ComparativaTipoCentroChart:", error);
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
    return <div className="placeholder-chart">No hay datos para los filtros seleccionados</div>;
  }

  // Colores para los tipos de centro
  const COLORS = ['var(--color-primary)', 'var(--color-purple)', 'var(--color-warning)', 'var(--color-danger)'];

  return (
    <div style={{ width: '100%', height: 280 }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} layout="vertical" margin={{ top: 10, right: 30, left: 10, bottom: 0 }}>
          <CartesianGrid strokeDasharray="3 3" horizontal={true} vertical={false} stroke="var(--border-light)" />
          <XAxis 
            type="number"
            domain={[0, 10]}
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <YAxis 
            type="category"
            dataKey="tipo_centro" 
            tick={{ fill: 'var(--text-secondary)', fontSize: 12, fontWeight: 500 }}
            axisLine={false}
            tickLine={false}
            width={80}
          />
          <Tooltip content={<CustomTooltip />} cursor={{ fill: 'var(--border-light)', opacity: 0.2 }} />
          
          <Bar dataKey="indice_riesgo_medio" radius={[0, 4, 4, 0]} barSize={32}>
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
