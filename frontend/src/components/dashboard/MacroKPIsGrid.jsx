import React, { useEffect, useState } from 'react';
import { AlertOctagon, BookX, RefreshCcw, Home, History, FileWarning, Puzzle, MonitorX, AlertCircle } from 'lucide-react';
import { useDashboardContext } from '../../context/DashboardContext';
import { api } from '../../services/api';
import { KPICard } from '../ui/KPICard';

export const MacroKPIsGrid = ({ onKpiClick, activeFilter }) => {
  const { filters } = useDashboardContext();
  const [kpis, setKpis] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchMacroKPIs = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        Object.entries(filters).forEach(([key, values]) => {
          values.forEach(val => params.append(key, val));
        });

        const response = await api.get('/dashboard/overview/kpis', { params });
        setKpis(response.data);
      } catch (error) {
        console.error("Error cargando Macro KPIs:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchMacroKPIs();
  }, [filters]);

  if (loading) {
    return <div className="loading-state">Calculando agregaciones...</div>;
  }

  if (!kpis || kpis.num_estudiantes === 0) {
    return null;
  }

  const getOpacity = (key) => {
    if (activeFilter && activeFilter.type === 'KPI' && activeFilter.key !== key) {
      return 0.4;
    }
    return 1;
  };

  return (
    <div style={{ marginTop: '24px' }}>
      <h2 style={{ fontSize: '1.2rem', marginBottom: '16px', color: 'var(--text-secondary)' }}>
        Resumen de Indicadores Clave Autonómicos
      </h2>
      <section className="kpi-grid">
        <div style={{ opacity: getOpacity('riesgo_abandono_alto'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Alto Riesgo de Abandono" 
            valueT0={kpis.riesgo_abandono_alto} 
            valueT1={kpis.riesgo_abandono_alto_a1}
            totalValue={kpis.num_estudiantes}
            icon={AlertOctagon}
            color="var(--color-danger)"
            isHoverable={true}
            onClick={() => onKpiClick('riesgo_abandono_alto')}
          />
        </div>
        <div style={{ opacity: getOpacity('suspensos'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Alumnos con Suspensos" 
            valueT0={kpis.suspensos} 
            valueT1={kpis.suspensos_a1}
            totalValue={kpis.num_estudiantes}
            icon={BookX}
            color="var(--color-warning)"
            isHoverable={true}
            onClick={() => onKpiClick('suspensos')}
          />
        </div>
        <div style={{ opacity: getOpacity('desfase_edad'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Desfase Académico" 
            valueT0={kpis.desfase_edad} 
            valueT1={kpis.desfase_edad_a1}
            totalValue={kpis.num_estudiantes}
            icon={History}
            color="var(--color-purple)"
            isHoverable={true}
            onClick={() => onKpiClick('desfase_edad')}
          />
        </div>
        <div style={{ opacity: getOpacity('is_repetidor'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Alumnos Repetidores" 
            valueT0={kpis.is_repetidor} 
            valueT1={kpis.is_repetidor_a1}
            totalValue={kpis.num_estudiantes}
            icon={RefreshCcw}
            color="var(--color-warning)"
            isHoverable={true}
            onClick={() => onKpiClick('is_repetidor')}
          />
        </div>
        <div style={{ opacity: getOpacity('riesgo_socio_alto'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Riesgo Socioeconómico Alto" 
            valueT0={kpis.riesgo_socio_alto} 
            valueT1={kpis.riesgo_socio_alto_a1}
            totalValue={kpis.num_estudiantes}
            icon={Home}
            color="var(--color-danger)"
            isHoverable={true}
            onClick={() => onKpiClick('riesgo_socio_alto')}
          />
        </div>
        
        <div style={{ opacity: getOpacity('brecha_digital'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Brecha Digital" 
            valueT0={kpis.brecha_digital} 
            valueT1={kpis.brecha_digital_a1}
            totalValue={kpis.num_estudiantes}
            icon={MonitorX}
            color="var(--color-danger)"
            isHoverable={true}
            onClick={() => onKpiClick('brecha_digital')}
          />
        </div>
        <div style={{ opacity: getOpacity('bajo_nivel_estudios_padres'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Bajo Nivel Estudios Familia" 
            valueT0={kpis.bajo_nivel_estudios_padres} 
            valueT1={kpis.bajo_nivel_estudios_padres_a1}
            totalValue={kpis.num_estudiantes}
            icon={AlertCircle}
            color="var(--color-warning)"
            isHoverable={true}
            onClick={() => onKpiClick('bajo_nivel_estudios_padres')}
          />
        </div>
        <div style={{ opacity: getOpacity('adaptacion_curricular'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Adaptación Curricular" 
            valueT0={kpis.adaptacion_curricular} 
            valueT1={kpis.adaptacion_curricular_a1}
            totalValue={kpis.num_estudiantes}
            icon={Puzzle}
            color="var(--color-success)"
            isHoverable={true}
            onClick={() => onKpiClick('adaptacion_curricular')}
          />
        </div>
        <div style={{ opacity: getOpacity('repetidores_1_2_pri'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Repetidores 1º/2º Primaria" 
            valueT0={kpis.repetidores_1_2_pri} 
            valueT1={kpis.repetidores_1_2_pri_a1}
            totalValue={kpis.num_estudiantes}
            icon={History}
            color="var(--color-purple)"
            isHoverable={true}
            onClick={() => onKpiClick('repetidores_1_2_pri')}
          />
        </div>
        <div style={{ opacity: getOpacity('suspensos_1_2_pri'), transition: 'opacity 0.2s' }}>
          <KPICard 
            title="Suspensos 1º/2º Primaria" 
            valueT0={kpis.suspensos_1_2_pri} 
            valueT1={kpis.suspensos_1_2_pri_a1}
            totalValue={kpis.num_estudiantes}
            icon={FileWarning}
            color="var(--color-purple)"
            isHoverable={true}
            onClick={() => onKpiClick('suspensos_1_2_pri')}
          />
        </div>
      </section>
    </div>
  );
};
