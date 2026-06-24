import { useState, useEffect } from 'react';
import { useFilters } from '../context/FilterContext';
import { getKPIs, getRiskDistribution, getRiskByCycle, getRedFlags } from '../api/dashboard';
import KpiCard from '../components/cards/KpiCard';
import RiskDistributionChart from '../components/charts/RiskDistributionChart';
import RiskByCycleChart from '../components/charts/RiskByCycleChart';
import RedFlagCard from '../components/alerts/RedFlagCard';
import PageHeader from '../components/layout/PageHeader';
import './OverviewPage.css';

export default function OverviewPage() {
  const { codCentro, cursoAcademico, codCiclo, tipoCentro } = useFilters();

  const [kpis, setKpis] = useState(null);
  const [riskDistribution, setRiskDistribution] = useState(null);
  const [riskByCycle, setRiskByCycle] = useState(null);
  const [redFlags, setRedFlags] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);

      const filterParams = {};
      if (codCentro) filterParams.cod_centro = codCentro;
      if (cursoAcademico) filterParams.curso_academico = cursoAcademico;
      if (codCiclo) filterParams.cod_ciclo = codCiclo;
      if (tipoCentro) filterParams.tipo_centro = tipoCentro;

      try {
        const [kpiData, riskDistData, riskCycleData, redFlagData] = await Promise.all([
          getKPIs(filterParams),
          getRiskDistribution(filterParams),
          getRiskByCycle(filterParams),
          getRedFlags(filterParams),
        ]);

        setKpis(kpiData);
        setRiskDistribution(riskDistData.data);
        setRiskByCycle(riskCycleData.data);
        setRedFlags(redFlagData);
      } catch (err) {
        setError('Error al cargar los datos. Inténtalo de nuevo.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [codCentro, cursoAcademico, codCiclo, tipoCentro]);

  if (loading) {
    return (
      <div className="overview-page">
        <PageHeader title="Visión General" />
        <div className="overview-layout">
          <div className="overview-main">
            <div className="kpi-grid">
              <div className="skeleton-card" />
              <div className="skeleton-card" />
              <div className="skeleton-card" />
              <div className="skeleton-card" />
            </div>
            <div className="charts-grid">
              <div className="skeleton-chart" />
              <div className="skeleton-chart" />
            </div>
          </div>
          <div className="overview-sidebar">
            <div className="skeleton-chart" style={{ height: '400px' }} />
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="overview-page">
        <PageHeader title="Visión General" />
        <div className="overview-error">
          <p>{error}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="overview-page">
      <PageHeader title="Visión General" />

      <div className="overview-layout">
        {/* Left Column: KPIs and Charts */}
        <div className="overview-main">
          <div className="kpi-grid">
            <KpiCard
              title="Total Alumnos"
              value={kpis?.total_alumnos}
              icon={null}
              color="#000"
            />
            <KpiCard
              title="Riesgo de Abandono"
              value={kpis?.pct_riesgo_abandono}
              subtext={`${kpis?.alumnos_riesgo_abandono || 0} alumnos`}
              icon={null}
              color="#000"
              suffix="%"
            />
            <KpiCard
              title="Abandono Temprano"
              value={kpis?.pct_abandono_temprano}
              subtext={`${kpis?.alumnos_abandono_temprano || 0} alumnos`}
              icon={null}
              color="#000"
              suffix="%"
            />
            <KpiCard
              title="Fracaso Escolar"
              value={kpis?.pct_fracaso_escolar}
              subtext={`${kpis?.alumnos_fracaso_escolar || 0} alumnos`}
              icon={null}
              color="#000"
              suffix="%"
            />
            <KpiCard
              title="Repetidores"
              value={kpis?.pct_repetidores}
              subtext={`${kpis?.alumnos_repetidores || 0} alumnos`}
              icon={null}
              color="#000"
              suffix="%"
            />
            <KpiCard
              title="Suspensos sin Repetir"
              value={kpis?.pct_suspensos_no_repetidores}
              subtext={`${kpis?.alumnos_suspensos_no_repetidores || 0} alumnos`}
              icon={null}
              color="#000"
              suffix="%"
            />
          </div>

          <div className="charts-grid">
            <RiskDistributionChart data={riskDistribution} />
            <RiskByCycleChart data={riskByCycle} />
          </div>
        </div>

        {/* Right Column: Alerts Feed */}
        <div className="overview-sidebar">
          <div className="alerts-section">
            <h2 className="alerts-title">Alertas Recientes</h2>
            <div className="alerts-grid">
              <RedFlagCard
                title="Repetidores 1º/2º"
                count={redFlags?.repetidores_1_2_primaria}
                description={`${(redFlags?.pct_repetidores_1_2_primaria || 0).toFixed(1)}% del total`}
                type="warning"
              />
              <RedFlagCard
                title="Suspensos 1º/2º"
                count={redFlags?.suspensos_1_2_primaria}
                description={`${(redFlags?.pct_suspensos_1_2_primaria || 0).toFixed(1)}% del total`}
                type="danger"
              />
              <RedFlagCard
                title="Riesgo Socioeconómico"
                count={redFlags?.riesgo_socioeconomico_alto}
                description={`${(redFlags?.pct_riesgo_socioeconomico_alto || 0).toFixed(1)}% del total`}
                type="danger"
              />
              <RedFlagCard
                title="Adaptación Curricular"
                count={redFlags?.con_adaptaciones_curriculares}
                description={`${(redFlags?.pct_con_adaptaciones_curriculares || 0).toFixed(1)}% del total`}
                type="warning"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
