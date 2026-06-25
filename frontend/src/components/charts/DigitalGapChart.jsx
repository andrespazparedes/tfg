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
import { getMicroDigitalGap } from '../../api/dashboard';

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
          Tasa Aprobados: <strong>{payload[0].payload["Tasa Aprobados"]}%</strong>
        </p>
        <p style={{ margin: '4px 0', color: 'var(--text-secondary)', fontSize: '0.85rem' }}>
          Total Alumnos: {payload[0].payload["Total Alumnos"]}
        </p>
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
        const response = await getMicroDigitalGap(filters);

        const formattedData = response.data.map((item) => {
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

        const finalData = Object.values(groupedMap).map(item => ({
          ...item,
          "Tasa Aprobados": item["Total Alumnos"] > 0 
            ? Math.round((item["Aprobados"] / item["Total Alumnos"]) * 100) 
            : 0
        }));

        const order = ['Conectados', 'Sin Equipo Suficiente', 'Sin Internet', 'Sin Acceso Ni Equipo'];
        finalData.sort((a, b) => {
          const indexA = order.indexOf(a.category);
          const indexB = order.indexOf(b.category);
          return (indexA === -1 ? 99 : indexA) - (indexB === -1 ? 99 : indexB);
        });

        setData(finalData);
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
            domain={[0, 100]}
            tickFormatter={(tick) => `${tick}%`}
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <Tooltip cursor={{ fill: 'var(--border-light)', opacity: 0.3 }} content={<CustomTooltip />} />
          <Legend wrapperStyle={{ paddingTop: '20px' }} />
          
          <Bar dataKey="Tasa Aprobados" name="Tasa de Aprobados" fill="var(--color-primary)" radius={[4, 4, 0, 0]} animationDuration={1500} barSize={45} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};
