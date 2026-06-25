import React, { useEffect, useState } from 'react';
import { Users, AlertOctagon, TrendingDown, BookX, RefreshCcw, Home, History, FileWarning, Puzzle, MonitorX, AlertCircle } from 'lucide-react';
import { useDashboardContext } from '../context/DashboardContext';
import { useNavigate } from 'react-router-dom';
import { getMicroKpis } from '../api/dashboard';
import { PageHeader } from '../components/layout/PageHeader';
import { KPICard } from '../components/ui/KPICard';
import { Card } from '../components/ui/Card';
import { TrendChart } from '../components/charts/TrendChart';
import { RiskDistributionChart } from '../components/charts/RiskDistributionChart';
import { RiskByCycleChart } from '../components/charts/RiskByCycleChart';
import { FailedSubjectsChart } from '../components/charts/FailedSubjectsChart';
import { IncomeDistributionChart } from '../components/charts/IncomeDistributionChart';
import { IncomeFailuresScatterChart } from '../components/charts/IncomeFailuresScatterChart';
import { DigitalGapChart } from '../components/charts/DigitalGapChart';
import { ParentEducationChart } from '../components/charts/ParentEducationChart';
import { StudentTable } from '../components/ui/StudentTable';
import './MicroDashboard.css';

export const MicroDashboard = () => {
  const { filters, triggerDrilldown } = useDashboardContext();
  const navigate = useNavigate();
  const [kpis, setKpis] = useState(null);
  const [loading, setLoading] = useState(true);

  const handleDrilldown = (alertKey) => {
    triggerDrilldown(alertKey);
    // Hacer scroll suave hacia la tabla de alumnos
    const tableEl = document.getElementById('students-table');
    if (tableEl) {
      tableEl.scrollIntoView({ behavior: 'smooth' });
    }
  };

  // Cada vez que cambien los filtros, volvemos a pedir los KPIs
  useEffect(() => {
    const fetchKPIs = async () => {
      setLoading(true);
      try {
        // Convertimos el estado de filtros en Query Params (ej: ?cod_centro=123)
        const data = await getMicroKpis(filters);
        setKpis(data);
      } catch (error) {
        console.error("Error cargando KPIs:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchKPIs();
  }, [filters]);

  if (loading) {
    return <div className="loading-state">Calculando agregaciones...</div>;
  }

  if (!kpis || !kpis.num_estudiantes) {
    return (
      <div className="page-container fade-in">
        <PageHeader 
          title="Análisis de Centro" 
          subtitle="Visión ejecutiva del rendimiento del alumnado"
        />
        <div className="loading-state" style={{ marginTop: '40px' }}>
          No hay datos de alumnos disponibles para los filtros seleccionados.
        </div>
      </div>
    );
  }

  return (
    <div className="page-container fade-in">
      <PageHeader 
        title="Visión General" 
        subtitle="Resumen ejecutivo del rendimiento del alumnado"
      />

      {/* RESUMEN DE INDICADORES CLAVE */}
      <h2 style={{ fontSize: '1.2rem', marginBottom: '16px', color: 'var(--text-secondary)' }}>Resumen de Indicadores Clave</h2>
      <section className="kpi-grid">
        <KPICard 
          title="Alto Riesgo de Abandono" 
          valueT0={kpis.riesgo_abandono_alto} 
          valueT1={kpis.riesgo_abandono_alto_a1}
          totalValue={kpis.num_estudiantes}
          icon={AlertOctagon}
          color="var(--color-danger)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_riesgo_alto')}
        />
        <KPICard 
          title="Alumnos con Suspensos" 
          valueT0={kpis.suspensos} 
          valueT1={kpis.suspensos_a1}
          totalValue={kpis.num_estudiantes}
          icon={BookX}
          color="var(--color-warning)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_suspensos')}
        />
        <KPICard 
          title="Desfase Académico" 
          valueT0={kpis.desfase_edad} 
          valueT1={kpis.desfase_edad_a1}
          totalValue={kpis.num_estudiantes}
          icon={History}
          color="var(--color-purple)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_desfase_edad')}
        />
        <KPICard 
          title="Alumnos Repetidores" 
          valueT0={kpis.is_repetidor} 
          valueT1={kpis.is_repetidor_a1}
          totalValue={kpis.num_estudiantes}
          icon={RefreshCcw}
          color="var(--color-warning)"
          isHoverable={true}
          onClick={() => handleDrilldown('is_repetidor')}
        />
        <KPICard 
          title="Riesgo Socioeconómico Alto" 
          valueT0={kpis.riesgo_socio_alto} 
          valueT1={kpis.riesgo_socio_alto_a1}
          totalValue={kpis.num_estudiantes}
          icon={Home}
          color="var(--color-danger)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_renta_baja')}
        />
        
        <KPICard 
          title="Brecha Digital" 
          valueT0={kpis.brecha_digital} 
          valueT1={kpis.brecha_digital_a1}
          totalValue={kpis.num_estudiantes}
          icon={MonitorX}
          color="var(--color-danger)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_brecha_digital')}
        />
        <KPICard 
          title="Bajo Nivel Estudios Familia" 
          valueT0={kpis.bajo_nivel_estudios_padres} 
          valueT1={kpis.bajo_nivel_estudios_padres_a1}
          totalValue={kpis.num_estudiantes}
          icon={AlertCircle}
          color="var(--color-warning)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_bajo_estudios')}
        />
        <KPICard 
          title="Adaptación Curricular" 
          valueT0={kpis.adaptacion_curricular} 
          valueT1={kpis.adaptacion_curricular_a1}
          totalValue={kpis.num_estudiantes}
          icon={Puzzle}
          color="var(--color-success)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_adaptacion')}
        />
        <KPICard 
          title="Repetidores 1º/2º Primaria" 
          valueT0={kpis.repetidores_1_2_pri} 
          valueT1={kpis.repetidores_1_2_pri_a1}
          totalValue={kpis.num_estudiantes}
          icon={History}
          color="var(--color-purple)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_repetidores_pri')}
        />
        <KPICard 
          title="Suspensos 1º/2º Primaria" 
          valueT0={kpis.suspensos_1_2_pri} 
          valueT1={kpis.suspensos_1_2_pri_a1}
          totalValue={kpis.num_estudiantes}
          icon={FileWarning}
          color="var(--color-purple)"
          isHoverable={true}
          onClick={() => handleDrilldown('alerta_suspensos_pri')}
        />
      </section>

      {/* FILA 2: GRÁFICOS */}
      <section className="charts-grid">
        <Card className="chart-container">
          <h3>Evolución Histórica</h3>
          <TrendChart />
        </Card>
        <Card className="chart-container">
          <h3>Distribución de Suspensos</h3>
          <FailedSubjectsChart />
        </Card>
        <Card className="chart-container">
          <h3>Distribución de Riesgo</h3>
          <RiskDistributionChart />
        </Card>
        <Card className="chart-container">
          <h3>Riesgo por Ciclo</h3>
          <RiskByCycleChart />
        </Card>
        
        {/* NUEVOS GRÁFICOS */}
        <Card className="chart-container">
          <h3>Distribución del Nivel de Renta</h3>
          <IncomeDistributionChart />
        </Card>

        <Card className="chart-container">
          <h3>Renta vs Suspensos (Correlación)</h3>
          <IncomeFailuresScatterChart />
        </Card>
        
        {/* GRÁFICOS MOVIDOS DESDE CONTEXTO SOCIOECONÓMICO */}
        <Card className="chart-container">
          <h3>Brecha Digital vs Aprobados</h3>
          <DigitalGapChart />
        </Card>
        <Card className="chart-container">
          <h3>Nivel Educativo Familiar</h3>
          <ParentEducationChart />
        </Card>
      </section>

      {/* FILA 3: TABLA DE ALUMNOS (COMPLETA) */}
      <section id="students-table" className="table-section" style={{ marginTop: '24px' }}>
        <Card style={{ padding: '0', overflow: 'hidden' }}>
          <div style={{ padding: '20px 20px 0 20px' }}>
            <h3 style={{ margin: 0, paddingBottom: '16px' }}>Directorio de Alumnos</h3>
          </div>
          <StudentTable />
        </Card>
      </section>
    </div>
  );
};


