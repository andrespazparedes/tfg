import React, { useEffect, useState } from 'react';
import { WifiOff, Wallet, GraduationCap, Users } from 'lucide-react';
import { useDashboardContext } from '../context/DashboardContext';
import { api } from '../services/api';
import { PageHeader } from '../components/layout/PageHeader';
import { KPICard } from '../components/ui/KPICard';
import { Card } from '../components/ui/Card';
import { DigitalGapChart } from '../components/charts/DigitalGapChart';
import { ParentEducationChart } from '../components/charts/ParentEducationChart';
import { IncomeRiskChart } from '../components/charts/IncomeRiskChart';

export const Socioeconomic = () => {
  const { filters, triggerDrilldown } = useDashboardContext();
  const [kpis, setKpis] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchKPIs = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        Object.entries(filters).forEach(([key, values]) => {
          values.forEach(val => params.append(key, val));
        });

        const response = await api.get('/dashboard/socioeconomic/kpis', { params });
        setKpis(response.data);
      } catch (error) {
        console.error("Error cargando KPIs socioeconómicos:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchKPIs();
  }, [filters]);

  if (loading || !kpis) {
    return <div className="loading-state">Calculando agregaciones familiares...</div>;
  }

  return (
    <div className="page-container fade-in">
      <PageHeader 
        title="Contexto Socioeconómico y Familiar" 
        subtitle="Análisis del entorno familiar y su correlación con el riesgo de abandono y fracaso escolar."
      />

      {/* FILA 1: KPIs SUPERIORES */}
      <section className="kpi-grid">
        <KPICard 
          title="Alumnos Analizados" 
          valueT0={kpis.num_estudiantes} 
          valueT1={kpis.num_estudiantes_a1}
          icon={Users}
          color="var(--color-primary)"
        />
        <KPICard 
          title="Brecha Digital Extrema" 
          valueT0={kpis.brecha_digital_extrema} 
          valueT1={kpis.brecha_digital_extrema_a1}
          icon={WifiOff}
          color="var(--color-danger)"
          isHoverable={true}
          onClick={() => triggerDrilldown('alerta_brecha_digital')}
        />
        <KPICard 
          title="Renta Baja o Muy Baja" 
          valueT0={kpis.nivel_renta_baja} 
          valueT1={kpis.nivel_renta_baja_a1}
          icon={Wallet}
          color="var(--color-warning)"
          isHoverable={true}
          onClick={() => triggerDrilldown('alerta_renta_baja')}
        />
        <KPICard 
          title="Padres sin Secundarios" 
          valueT0={kpis.sin_estudios_secundarios} 
          valueT1={kpis.sin_estudios_secundarios_a1}
          icon={GraduationCap}
          color="var(--color-purple)"
        />
      </section>

      {/* FILA 2: GRÁFICOS PRINCIPALES */}
      <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '20px', marginTop: '24px' }}>
        <Card className="chart-container" style={{ gridColumn: 'span 2' }}>
          <h3>Aprobados y Suspensos vs Equipamiento Tecnológico</h3>
          <p style={{ margin: '0 0 16px 0', color: 'var(--text-secondary)', fontSize: '0.9rem' }}>
            Impacto directo de la brecha digital en la superación de las asignaturas.
          </p>
          <DigitalGapChart />
        </Card>
      </section>

      {/* FILA 3: GRÁFICOS SECUNDARIOS */}
      <section style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '20px', marginTop: '24px' }}>
        <Card className="chart-container">
          <h3>Nivel Educativo de los Responsables Legales</h3>
          <ParentEducationChart />
        </Card>
        <Card className="chart-container">
          <h3>Riesgo de Abandono Crítico vs Nivel de Renta</h3>
          <IncomeRiskChart />
        </Card>
      </section>
    </div>
  );
};
