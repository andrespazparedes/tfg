import React, { useState, useEffect } from 'react';
import { useDashboardContext } from '../context/DashboardContext';
import { getMacroCentros } from '../api/dashboard';
import { PageHeader } from '../components/layout/PageHeader';
import { KPICard } from '../components/ui/KPICard';
import { Card } from '../components/ui/Card';
import { CentroCard } from '../components/dashboard/CentroCard';
import { CentrosMap } from '../components/dashboard/CentrosMap';
import { TendenciaGlobalChart } from '../components/charts/TendenciaGlobalChart';
import { ComparativaTipoCentroChart } from '../components/charts/ComparativaTipoCentroChart';
import { MatrizRecursosChart } from '../components/charts/MatrizRecursosChart';
import { MacroKPIsGrid } from '../components/dashboard/MacroKPIsGrid';
import { MultiSelect } from '../components/ui/MultiSelect';
import { Building2, AlertTriangle, Activity, X } from 'lucide-react';
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
  const [localFilter, setLocalFilter] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const res = await getMacroCentros(filters);
        setData(res.data || []);
      } catch (err) {
        console.error('Error fetching macro data:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
    // Reset local filter when global filters change
    setLocalFilter(null);
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
    else if (c.indice_riesgo_centro !== null && c.indice_riesgo_centro !== undefined) distributionMap['Bajo (0-3)']++;
  });

  const chartData = [
    { name: 'Bajo (0-3)', count: distributionMap['Bajo (0-3)'], color: 'var(--success-color, #10b981)' },
    { name: 'Medio (4-6)', count: distributionMap['Medio (4-6)'], color: 'var(--warning-color, #f59e0b)' },
    { name: 'Alto (7-10)', count: distributionMap['Alto (7-10)'], color: 'var(--danger-color, #ef4444)' },
  ];

  const handleKpiClick = (kpiKey) => {
    // Si ya está activo, lo quitamos
    if (localFilter && localFilter.type === 'KPI' && localFilter.key === kpiKey) {
      setLocalFilter(null);
      return;
    }
    // Calculamos la media de ese KPI en frontend para filtrar
    const mean = data.reduce((acc, c) => acc + (c[kpiKey] / (c.num_estudiantes || 1)), 0) / (data.length || 1);
    setLocalFilter({ type: 'KPI', key: kpiKey, mean: mean, label: `Alerta: ${kpiKey.replace(/_/g, ' ')}` });
    
    // Scroll hacia el ranking
    setTimeout(() => {
      document.getElementById('ranking-section')?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
  };

  const handleBarClick = (barData) => {
    if (localFilter && localFilter.type === 'RISK_LEVEL' && localFilter.key === barData.name) {
      setLocalFilter(null);
      return;
    }
    setLocalFilter({ type: 'RISK_LEVEL', key: barData.name, label: `Riesgo: ${barData.name}` });
    
    // Scroll hacia el ranking
    setTimeout(() => {
      document.getElementById('ranking-section')?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
  };

  const kpiOptions = [
    { value: 'riesgo_abandono_alto', label: 'Alto Riesgo de Abandono' },
    { value: 'suspensos', label: 'Alumnos con Suspensos' },
    { value: 'desfase_edad', label: 'Desfase Académico' },
    { value: 'is_repetidor', label: 'Alumnos Repetidores' },
    { value: 'riesgo_socio_alto', label: 'Riesgo Socioeconómico Alto' },
    { value: 'brecha_digital', label: 'Brecha Digital' },
    { value: 'bajo_nivel_estudios_padres', label: 'Bajo Nivel Estudios Familia' },
    { value: 'adaptacion_curricular', label: 'Adaptación Curricular' },
    { value: 'repetidores_1_2_pri', label: 'Repetidores 1º/2º Primaria' },
    { value: 'suspensos_1_2_pri', label: 'Suspensos 1º/2º Primaria' }
  ];

  const handleSelectorChange = (selectedKeys) => {
    if (selectedKeys.length === 0) {
      setLocalFilter(null);
    } else {
      const kpiKey = selectedKeys[0];
      const opt = kpiOptions.find(o => o.value === kpiKey);
      const mean = data.reduce((acc, c) => acc + (c[kpiKey] / (c.num_estudiantes || 1)), 0) / (data.length || 1);
      setLocalFilter({ type: 'KPI', key: kpiKey, mean: mean, label: opt.label });
    }
  };

  // Aplicar local filter al ranking
  let filteredRanking = data;
  if (localFilter) {
    if (localFilter.type === 'RISK_LEVEL') {
      if (localFilter.key === 'Alto (7-10)') {
        filteredRanking = data.filter(c => c.indice_riesgo_centro >= 7);
      } else if (localFilter.key === 'Medio (4-6)') {
        filteredRanking = data.filter(c => c.indice_riesgo_centro >= 4 && c.indice_riesgo_centro < 7);
      } else {
        filteredRanking = data.filter(c => c.indice_riesgo_centro < 4);
      }
    } else if (localFilter.type === 'KPI') {
      filteredRanking = data.filter(c => (c[localFilter.key] / (c.num_estudiantes || 1)) > localFilter.mean);
    }
  }

  if (loading) {
    return <div className="loading-state">Cargando Centro de Mando...</div>;
  }

  if (data.length === 0) {
    return (
      <div className="page-container fade-in">
        <PageHeader 
          title="Centro de Mando Autonómico" 
          subtitle="Visión general del ecosistema educativo y alertas tempranas"
        />
        <div className="loading-state" style={{ marginTop: '40px' }}>
          No hay centros disponibles para los filtros seleccionados.
        </div>
      </div>
    );
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

      {/* MACRO KPIs GRID */}
      <MacroKPIsGrid onKpiClick={handleKpiClick} activeFilter={localFilter} />

      {/* MAPA GEOGRÁFICO */}
      <section className="map-section" style={{ marginTop: '30px' }}>
        <Card className="chart-card">
          <h3>Mapa de Centros en Alerta</h3>
          <p className="chart-desc">Distribución geográfica. El color indica el nivel de riesgo y el tamaño el volumen de estudiantes.</p>
          <div style={{ marginTop: '20px' }}>
            <CentrosMap centros={data} />
          </div>
        </Card>
      </section>

      {/* CHARTS GRID */}
      <section className="charts-grid" style={{ marginTop: '30px' }}>
        <Card className="chart-card">
          <h3>Evolución del Riesgo Autonómico</h3>
          <p className="chart-desc">Media histórica del índice de riesgo de los centros.</p>
          <TendenciaGlobalChart />
        </Card>

        <Card className="chart-card">
          <h3>Comparativa por Tipo de Centro</h3>
          <p className="chart-desc">Media del índice de riesgo según el tipo (IES, CEIP...).</p>
          <ComparativaTipoCentroChart />
        </Card>

        <Card className="chart-card">
          <h3>Distribución del Riesgo Institucional</h3>
          <p className="chart-desc">Número de colegios agrupados por su nivel de riesgo actual.</p>
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
                <Bar dataKey="count" radius={[0, 4, 4, 0]} barSize={40} onClick={handleBarClick} style={{ cursor: 'pointer' }}>
                  {chartData.map((entry, index) => (
                    <Cell 
                      key={`cell-${index}`} 
                      fill={entry.color} 
                      opacity={localFilter && localFilter.type === 'RISK_LEVEL' && localFilter.key !== entry.name ? 0.3 : 1}
                    />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>

        <Card className="chart-card">
          <h3>Matriz de Asignación de Recursos</h3>
          <p className="chart-desc">Gravedad del riesgo vs Volumen de alumnado por colegio.</p>
          <MatrizRecursosChart centros={filteredRanking} />
        </Card>
      </section>

      {/* CENTROS GRID */}
      <section id="ranking-section" className="centros-grid-section">
        <div style={{ marginBottom: '20px' }}>
          <h3 style={{ margin: '0 0 12px 0' }}>Ranking de Centros {localFilter && `(${filteredRanking.length})`}</h3>
          
          <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
            <span style={{ fontSize: '0.9rem', color: 'var(--text-secondary)', whiteSpace: 'nowrap' }}>Filtrar por alerta:</span>
            <div style={{ width: '280px' }}>
              <MultiSelect 
                singleSelect={true}
                placeholder="Todas las alertas"
                options={kpiOptions}
                selectedValues={localFilter && localFilter.type === 'KPI' ? [localFilter.key] : []}
                onChange={handleSelectorChange}
              />
            </div>
            
            {localFilter && (
              <button 
                onClick={() => setLocalFilter(null)}
                style={{
                  display: 'flex', alignItems: 'center', gap: '4px',
                  background: 'transparent', border: 'none', 
                  color: 'var(--text-secondary)', cursor: 'pointer',
                  fontSize: '0.85rem', padding: '4px 8px', borderRadius: '4px'
                }}
                onMouseEnter={(e) => { e.currentTarget.style.color = 'var(--text-primary)'; e.currentTarget.style.background = 'rgba(255,255,255,0.05)'; }}
                onMouseLeave={(e) => { e.currentTarget.style.color = 'var(--text-secondary)'; e.currentTarget.style.background = 'transparent'; }}
              >
                <X size={14} /> Limpiar
              </button>
            )}
          </div>
        </div>
        <div className="centros-grid">
          {filteredRanking.length === 0 ? (
            <p className="no-data">No se encontraron centros para los filtros seleccionados.</p>
          ) : (
            filteredRanking.map((centro) => (
              <CentroCard key={centro.cod_centro} centro={centro} />
            ))
          )}
        </div>
      </section>
    </div>
  );
};
