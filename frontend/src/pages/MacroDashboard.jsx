import React, { useState, useEffect } from 'react';
import { useDashboardContext } from '../context/DashboardContext';
import { api } from '../services/api';
import { PageHeader } from '../components/layout/PageHeader';
import { KPICard } from '../components/ui/KPICard';
import { Card } from '../components/ui/Card';
import { CentroCard } from '../components/dashboard/CentroCard';
import { Building2, AlertTriangle, Activity } from 'lucide-react';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip as RechartsTooltip,
  ResponsiveContainer,
  Cell
} from 'recharts';
import './MacroDashboard.css';

export const MacroDashboard = () => {
  const { filters } = useDashboardContext();
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const queryParams = new URLSearchParams();
        if (filters.curso_academico?.length) {
          filters.curso_academico.forEach((c) => queryParams.append('curso_academico', c));
        }
        if (filters.tipo_centro?.length) {
          filters.tipo_centro.forEach((t) => queryParams.append('tipo_centro', t));
        }
        if (filters.cod_ciclo?.length) {
          filters.cod_ciclo.forEach((c) => queryParams.append('cod_ciclo', c));
        }
        // Force page_size to a high number to get all for the macro view
        queryParams.append('page_size', '100');

        const res = await api.get(`/dashboard/centros?${queryParams.toString()}`);
        setData(res.data.data || []);
      } catch (err) {
        console.error('Error fetching macro data:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [filters]);

  // Derived Metrics
  const totalCentros = data.length;
  const criticalCentros = data.filter((c) => c.indice_riesgo_centro >= 7).length;
  
  const avgIndex = totalCentros > 0 
    ? (data.reduce((acc, c) => acc + c.indice_riesgo_centro, 0) / totalCentros).toFixed(1)
    : 0;

  // Chart Data preparation (Distribution)
  const distributionMap = {
    'Bajo (0-3)': 0,
    'Medio (4-6)': 0,
    'Alto (7-10)': 0
  };

  data.forEach((c) => {
    if (c.indice_riesgo_centro >= 7) distributionMap['Alto (7-10)']++;
    else if (c.indice_riesgo_centro >= 4) distributionMap['Medio (4-6)']++;
    else distributionMap['Bajo (0-3)']++;
  });

  const chartData = [
    { name: 'Bajo (0-3)', count: distributionMap['Bajo (0-3)'], color: 'var(--success-color, #10b981)' },
    { name: 'Medio (4-6)', count: distributionMap['Medio (4-6)'], color: 'var(--warning-color, #f59e0b)' },
    { name: 'Alto (7-10)', count: distributionMap['Alto (7-10)'], color: 'var(--danger-color, #ef4444)' },
  ];

  if (loading) {
    return <div className="loading-state">Cargando Centro de Mando...</div>;
  }

  return (
    <div className="page-container fade-in">
      <PageHeader 
        title="Centro de Mando Autonómico" 
        subtitle="Visión general del ecosistema educativo y alertas tempranas"
      />

      {/* TOP METRICS */}
      <section className="kpi-grid">
        <KPICard 
          title="Centros Analizados" 
          value={totalCentros} 
          icon={Building2}
          trend="Total en la selección actual" 
        />
        <KPICard 
          title="Centros Críticos" 
          value={criticalCentros} 
          icon={AlertTriangle}
          color="var(--danger-color)"
          trend="Índice de Riesgo >= 7" 
        />
        <KPICard 
          title="Media del Índice de Riesgo" 
          value={`${avgIndex} / 10`} 
          icon={Activity}
          trend="Promedio autonómico" 
        />
      </section>

      {/* DISTRIBUTION CHART */}
      <section className="distribution-section">
        <Card className="chart-card">
          <h3>Distribución del Riesgo Institucional</h3>
          <p className="chart-desc">Número de colegios agrupados por su índice de riesgo general.</p>
          <div className="chart-container" style={{ height: 250, marginTop: '20px' }}>
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={chartData} layout="vertical" margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="var(--border-color)" horizontal={false} />
                <XAxis type="number" stroke="var(--text-secondary)" />
                <YAxis dataKey="name" type="category" stroke="var(--text-secondary)" width={100} />
                <RechartsTooltip 
                  contentStyle={{ backgroundColor: 'var(--bg-app)', border: '1px solid var(--border-light)', borderRadius: '8px', color: 'var(--text-primary)' }}
                  cursor={{fill: 'var(--bg-card)'}}
                />
                <Bar dataKey="count" radius={[0, 4, 4, 0]} barSize={40}>
                  {chartData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </section>

      {/* CENTROS GRID */}
      <section className="centros-grid-section">
        <h3>Ranking de Centros</h3>
        <div className="centros-grid">
          {data.length === 0 ? (
            <p className="no-data">No se encontraron centros para los filtros seleccionados.</p>
          ) : (
            data.map((centro) => (
              <CentroCard key={centro.cod_centro} centro={centro} />
            ))
          )}
        </div>
      </section>
    </div>
  );
};
