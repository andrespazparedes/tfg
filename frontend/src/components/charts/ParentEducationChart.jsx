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
import { getMicroParentEducation } from '../../api/dashboard';

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
          {label}
        </p>
        <p style={{ margin: '4px 0', color: 'var(--color-primary)', fontSize: '0.9rem' }}>
          Total Alumnos: <strong>{payload[0].payload.num_estudiantes}</strong>
        </p>
        <p style={{ margin: '4px 0', color: 'var(--color-danger)', fontSize: '0.9rem' }}>
          Riesgo Crítico: <strong>{payload[0].payload.riesgo_abandono_critico}</strong> alumnos
        </p>
      </div>
    );
  }
  return null;
};

export const ParentEducationChart = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchChartData = async () => {
      setLoading(true);
      try {
        const response = await getMicroParentEducation(filters);

        const order = ["Sin Estudios", "Estudios Primarios", "Estudios Secundarios", "Estudios Universitarios", "Desconocido"];
        const sortedData = response.data.sort((a, b) => {
          return order.indexOf(a.max_nivel_estudios_padres) - order.indexOf(b.max_nivel_estudios_padres);
        });
        
        setData(sortedData);
      } catch (error) {
        console.error("Error cargando ParentEducationChart:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchChartData();
  }, [filters]);

  if (loading) return <div className="placeholder-chart">Cargando gráfico...</div>;
  if (data.length === 0) return <div className="placeholder-chart">Sin datos</div>;

  return (
    <div style={{ width: '100%', height: 300 }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart 
          data={data} 
          layout="vertical"
          margin={{ top: 10, right: 30, left: 40, bottom: 0 }}
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
            dataKey="max_nivel_estudios_padres" 
            tick={{ fill: 'var(--text-primary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
            width={120}
          />
          <Tooltip cursor={{ fill: 'var(--border-light)', opacity: 0.3 }} content={<CustomTooltip />} />
          
          <Bar 
            dataKey="num_estudiantes" 
            radius={[0, 4, 4, 0]}
            barSize={20}
          >
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill="var(--color-primary)" />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
