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
import { api } from '../../services/api';

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
          Renta: {label}
        </p>
        <p style={{ margin: '4px 0', color: 'var(--color-primary)', fontSize: '0.9rem' }}>
          Total Alumnos: <strong>{payload[0].payload.num_estudiantes}</strong>
        </p>
        <p style={{ margin: '4px 0', color: 'var(--color-danger)', fontSize: '0.9rem' }}>
          Riesgo Crítico: <strong>{payload[0].payload.riesgo_abandono_critico}</strong>
        </p>
        <p style={{ margin: '4px 0', color: 'var(--color-warning)', fontSize: '0.9rem' }}>
          Suspensos Acumulados: <strong>{payload[0].payload.num_suspensas}</strong>
        </p>
      </div>
    );
  }
  return null;
};

export const IncomeRiskChart = () => {
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

        const response = await api.get('/dashboard/socioeconomic/charts/income-risk', { params });
        
        const order = ["Muy Baja", "Baja", "Media", "Alta", "Muy Alta", "Desconocida"];
        const sortedData = response.data.data.sort((a, b) => {
          return order.indexOf(a.nivel_renta) - order.indexOf(b.nivel_renta);
        });
        
        setData(sortedData);
      } catch (error) {
        console.error("Error cargando IncomeRiskChart:", error);
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
          margin={{ top: 20, right: 30, left: 0, bottom: 5 }}
        >
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="nivel_renta" 
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <YAxis 
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <Tooltip cursor={{ fill: 'var(--border-light)', opacity: 0.3 }} content={<CustomTooltip />} />
          
          <Bar 
            dataKey="riesgo_abandono_critico" 
            radius={[4, 4, 0, 0]}
            barSize={30}
          >
            {data.map((entry, index) => (
              <Cell 
                key={`cell-${index}`} 
                fill={['Muy Baja', 'Baja'].includes(entry.nivel_renta) ? 'var(--color-danger)' : 'var(--color-primary)'} 
              />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
