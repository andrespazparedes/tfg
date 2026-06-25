import { api } from '../services/api';

/**
 * Serializa filtros globales y parámetros extra al formato que espera FastAPI
 * (?cod_centro=A&cod_centro=B).
 */
export function toQueryParams(filters = {}, extra = {}) {
  const params = new URLSearchParams();

  Object.entries(filters).forEach(([key, values]) => {
    if (Array.isArray(values)) {
      values.forEach((v) => {
        if (v !== undefined && v !== null && v !== '') {
          params.append(key, v);
        }
      });
    }
  });

  Object.entries(extra).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') {
      params.append(key, value);
    }
  });

  return params;
}

// ── Compartidos ──────────────────────────────────────────────────────

export async function getFilters() {
  const response = await api.get('/dashboard/filters');
  return response.data;
}

// ── Macro (visión autonómica) ────────────────────────────────────────

export async function getMacroKpis(filters) {
  const response = await api.get('/dashboard/macro/kpis', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMacroCentros(filters, extra = {}) {
  const response = await api.get('/dashboard/macro/centros', {
    params: toQueryParams(filters, { page: 1, page_size: 1000, ...extra }),
  });
  return response.data;
}

export async function getMacroTrend(filters) {
  const response = await api.get('/dashboard/macro/charts/trend', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMacroRiskByType(filters) {
  const response = await api.get('/dashboard/macro/charts/risk-by-type', {
    params: toQueryParams(filters),
  });
  return response.data;
}

// ── Micro (visión granular) ──────────────────────────────────────────

export async function getMicroKpis(filters) {
  const response = await api.get('/dashboard/micro/kpis', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroStudents(filters, extra = {}) {
  const response = await api.get('/dashboard/micro/students', {
    params: toQueryParams(filters, extra),
  });
  return response.data;
}

export async function getMicroRiskDistribution(filters) {
  const response = await api.get('/dashboard/micro/charts/risk-distribution', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroRiskByCycle(filters) {
  const response = await api.get('/dashboard/micro/charts/risk-by-cycle', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroTrend(filters) {
  const response = await api.get('/dashboard/micro/charts/trend', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroFailedSubjects(filters) {
  const response = await api.get('/dashboard/micro/charts/failed-subjects', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroIncomeDistribution(filters) {
  const response = await api.get('/dashboard/micro/charts/income-distribution', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroCorrelationIncomeFailures(filters) {
  const response = await api.get('/dashboard/micro/charts/correlation-income-failures', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroDigitalGap(filters) {
  const response = await api.get('/dashboard/micro/charts/digital-gap', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroParentEducation(filters) {
  const response = await api.get('/dashboard/micro/charts/parent-education', {
    params: toQueryParams(filters),
  });
  return response.data;
}

export async function getMicroIncomeRisk(filters) {
  const response = await api.get('/dashboard/micro/charts/income-risk', {
    params: toQueryParams(filters),
  });
  return response.data;
}
