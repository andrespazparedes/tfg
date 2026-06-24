import { api } from '../services/api';

function cleanParams(params) {
  if (!params) return {};
  const cleaned = {};
  for (const [key, value] of Object.entries(params)) {
    if (value !== undefined && value !== null && value !== '') {
      cleaned[key] = value;
    }
  }
  return cleaned;
}

export async function getFilters() {
  const response = await api.get('/dashboard/filters');
  return response.data;
}

export async function getKPIs(params) {
  const response = await api.get('/dashboard/kpis', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRiskDistribution(params) {
  const response = await api.get('/dashboard/charts/risk-distribution', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRiskByCycle(params) {
  const response = await api.get('/dashboard/charts/risk-by-cycle', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRedFlags(params) {
  const response = await api.get('/dashboard/insights/red-flags', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getStudents(params) {
  const response = await api.get('/dashboard/students', {
    params: cleanParams(params),
  });
  return response.data;
}
