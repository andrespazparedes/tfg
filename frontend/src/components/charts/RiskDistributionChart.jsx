import React, { useEffect, useState } from 'react';
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer, Legend } from 'recharts';
import { useDashboardContext } from '../../context/DashboardContext';
import { getMicroRiskDistribution } from '../../api/dashboard';

const COLORS = {
  'Alto': 'var(--color-danger)',
  'Medio': 'var(--color-warning)',
  'Bajo': 'var(--color-success)'
};

const CustomTooltip = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const data = payload[0].payload;
    return (
      <div style={{
        backgroundColor: 'var(--bg-sidebar)',
        padding: '12px',
        border: '1px solid var(--border-light)',
        borderRadius: '8px',
        boxShadow: '0 4px 16px rgba(0,0,0,0.2)'
      }}>
        <p style={{ margin: '0 0 5px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>
          Riesgo {data.nivel_riesgo}
        </p>
        <p style={{ margin: 0, color: 'var(--text-secondary)', fontSize: '0.9rem' }}>
          {data.num_estudiantes} estudiantes
        </p>
      </div>
    );
  }
  return null;
};

export const RiskDistributionChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const response = await getMicroRiskDistribution(filters);
        setData(response.data);
      } catch (error) {
        console.error("Error cargando RiskDistributionChart:", error);
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
    return <div className="placeholder-chart">Sin datos de riesgo</div>;
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
            dataKey="num_estudiantes"
            nameKey="nivel_riesgo"
            stroke="none"
          >
            {data.map((entry, index) => (
              <Cell 
                key={`cell-${index}`} 
                fill={COLORS[entry.nivel_riesgo] || 'var(--text-secondary)'} 
              />
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
