import React, { useEffect, useState } from 'react';
import { 
  PieChart, 
  Pie,
  Cell,
  Tooltip, 
  ResponsiveContainer,
  Legend
} from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';

const COLORS = {
  'Muy Baja': 'var(--color-danger)',
  'Baja': 'var(--color-warning)',
  'Media/Alta': 'var(--color-success)',
  'Desconocida': 'var(--text-secondary)'
};

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
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>Renta: {dataObj.name}</p>
        <p style={{ color: payload[0].fill, margin: '4px 0', fontSize: '0.95rem' }}>
          Alumnos: <strong>{dataObj.value}</strong>
        </p>
      </div>
    );
  }
  return null;
};

export const IncomeDistributionChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/income-distribution', { params });
        
        const formattedData = response.data.data.map(d => {
          const rawName = (d.name || 'Desconocida').toLowerCase();
          let displayName = 'Desconocida';
          if (rawName.includes('muy baja')) displayName = 'Muy Baja';
          else if (rawName.includes('baja')) displayName = 'Baja';
          else if (rawName.includes('media/alta') || rawName.includes('media') || rawName.includes('alta')) displayName = 'Media/Alta';
          
          return { name: displayName, value: d.value };
        });
        setData(formattedData);
      } catch (error) {
        console.error("Error cargando IncomeDistributionChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Cargando datos de renta...</div>;
  }

  if (!data || data.length === 0) {
    return <div style={{ height: 300, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>No hay datos suficientes</div>;
  }

  return (
    <div style={{ width: '100%', height: 280 }}>
      <ResponsiveContainer width="100%" height="100%">
        <PieChart>
          <Pie
            data={data}
            cx="50%"
            cy="50%"
            innerRadius={70}
            outerRadius={100}
            paddingAngle={3}
            dataKey="value"
            stroke="none"
            animationDuration={1000}
          >
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[entry.name] || 'var(--color-primary)'} />
            ))}
          </Pie>
          <Tooltip content={<CustomTooltip />} />
          <Legend 
            verticalAlign="bottom" 
            height={36} 
            iconType="circle" 
            formatter={(value) => <span style={{ color: 'var(--text-primary)' }}>{value}</span>}
          />
        </PieChart>
      </ResponsiveContainer>
    </div>
  );
};
