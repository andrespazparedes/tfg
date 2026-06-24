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
        {payload.map((entry, index) => (
          <p key={index} style={{ margin: '4px 0', color: entry.color, fontSize: '0.9rem' }}>
            {entry.name}: <strong>{entry.value}</strong>
          </p>
        ))}
      </div>
    );
  }
  return null;
};

export const DigitalGapChart = () => {
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

        const response = await api.get('/dashboard/socioeconomic/charts/digital-gap', { params });
        
        // Transformar datos booleanos en etiquetas legibles
        const formattedData = response.data.data.map(item => {
          let category = 'Conectados';
          if (!item.conexion_internet && item.ordenadores_suficientes === false) {
            category = 'Sin Acceso Ni Equipo';
          } else if (!item.conexion_internet) {
            category = 'Sin Internet';
          } else if (item.ordenadores_suficientes === false) {
            category = 'Sin Equipo Suficiente';
          }

          return {
            category,
            "Total Alumnos": item.num_estudiantes,
            "Aprobados": item.num_aprobados,
            "Suspensos": item.num_estudiantes - item.num_aprobados
          };
        });

        // Agrupar por categoría en caso de que vengan separadas
        const groupedMap = formattedData.reduce((acc, curr) => {
          if (!acc[curr.category]) {
            acc[curr.category] = { category: curr.category, "Total Alumnos": 0, "Aprobados": 0, "Suspensos": 0 };
          }
          acc[curr.category]["Total Alumnos"] += curr["Total Alumnos"];
          acc[curr.category]["Aprobados"] += curr["Aprobados"];
          acc[curr.category]["Suspensos"] += curr["Suspensos"];
          return acc;
        }, {});

        setData(Object.values(groupedMap));
      } catch (error) {
        console.error("Error cargando DigitalGapChart:", error);
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
        <BarChart data={data} margin={{ top: 20, right: 30, left: 0, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="var(--border-light)" />
          <XAxis 
            dataKey="category" 
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
          <Legend wrapperStyle={{ paddingTop: '20px' }} />
          
          <Bar dataKey="Aprobados" stackId="a" fill="var(--color-success)" radius={[0, 0, 4, 4]} />
          <Bar dataKey="Suspensos" stackId="a" fill="var(--color-danger)" radius={[4, 4, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
