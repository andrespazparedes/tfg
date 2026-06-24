import React, { useEffect, useState } from 'react';
import { 
  ComposedChart, 
  Bar, 
  Area,
  Line,
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
    const dataObj = payload[0].payload;
    
    const formatDiff = (dif) => {
      if (dif === null || dif === undefined) return "";
      const sign = dif > 0 ? "+" : "";
      return ` (${sign}${dif} vs a-1)`;
    };

    return (
      <div className="custom-tooltip" style={{
        backgroundColor: 'var(--bg-sidebar)',
        padding: '12px',
        border: '1px solid var(--border-light)',
        borderRadius: '8px',
        boxShadow: '0 4px 16px rgba(0,0,0,0.2)'
      }}>
        <p style={{ margin: '0 0 8px 0', fontWeight: 'bold', color: 'var(--text-primary)' }}>{label}</p>
        {payload.map((entry, index) => {
          let extraInfo = "";
          if (entry.dataKey === "riesgo_alto") {
            extraInfo = ` - ${dataObj.pct_alto}% ${formatDiff(dataObj.dif_alto)}`;
          } else if (entry.dataKey === "riesgo_medio") {
            extraInfo = ` - ${dataObj.pct_medio}% ${formatDiff(dataObj.dif_medio)}`;
          }

          return (
            <p key={index} style={{ color: entry.color || entry.fill, margin: '4px 0', fontSize: '0.9rem' }}>
              {entry.name}: <strong>{entry.value}</strong>
              <span style={{ fontSize: '0.8rem', opacity: 0.8 }}>{extraInfo}</span>
            </p>
          );
        })}
      </div>
    );
  }
  return null;
};

export const TrendChart = () => {
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

        const response = await api.get('/dashboard/overview/charts/trend', { params });
        const sortedData = response.data.data.sort((a, b) => a.curso_academico.localeCompare(b.curso_academico));
        
        // Calcular porcentajes y cambios respecto al año anterior (a-1)
        const enrichedData = sortedData.map((item, index) => {
          const total = item.num_estudiantes || 1;
          
          const pct_alto = ((item.riesgo_alto || 0) / total * 100).toFixed(1);
          const pct_medio = ((item.riesgo_medio || 0) / total * 100).toFixed(1);
          
          let dif_alto = null;
          let dif_medio = null;
          
          if (index > 0) {
            const prev = sortedData[index - 1];
            dif_alto = (item.riesgo_alto || 0) - (prev.riesgo_alto || 0);
            dif_medio = (item.riesgo_medio || 0) - (prev.riesgo_medio || 0);
          }

          return { ...item, pct_alto, pct_medio, dif_alto, dif_medio };
        });

        setData(enrichedData);
      } catch (error) {
        console.error("Error cargando TrendChart:", error);
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
            <linearGradient id="colorAlto" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="var(--color-danger)" stopOpacity={0.8}/>
              <stop offset="95%" stopColor="var(--color-danger)" stopOpacity={0}/>
            </linearGradient>
            <linearGradient id="colorMedio" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="var(--color-warning)" stopOpacity={0.8}/>
              <stop offset="95%" stopColor="var(--color-warning)" stopOpacity={0}/>
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
            tick={{ fill: 'var(--text-secondary)', fontSize: 12 }}
            axisLine={false}
            tickLine={false}
          />
          <Tooltip content={<CustomTooltip />} cursor={{ fill: 'var(--border-light)', opacity: 0.2 }} />
          <Legend wrapperStyle={{ paddingTop: '20px' }} />
          
          <Bar 
            dataKey="num_estudiantes" 
            name="Total Alumnos" 
            barSize={24} 
            fill="var(--color-primary)" 
            opacity={0.15} 
            radius={[4, 4, 0, 0]} 
          />
          <Area 
            type="monotone" 
            dataKey="riesgo_medio" 
            name="Riesgo Medio" 
            stackId="1"
            fillOpacity={1} 
            fill="url(#colorMedio)" 
            stroke="var(--color-warning)" 
            strokeWidth={2}
          />
          <Area 
            type="monotone" 
            dataKey="riesgo_alto" 
            name="Riesgo Alto" 
            stackId="1"
            fillOpacity={1} 
            fill="url(#colorAlto)" 
            stroke="var(--color-danger)" 
            strokeWidth={3}
          />
        </ComposedChart>
      </ResponsiveContainer>
    </div>
  );
};
