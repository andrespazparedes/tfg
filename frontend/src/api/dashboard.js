import client from './client';

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
  const response = await client.get('/api/v1/dashboard/filters');
  return response.data;
}

export async function getKPIs(params) {
  const response = await client.get('/api/v1/dashboard/kpis', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRiskDistribution(params) {
  const response = await client.get('/api/v1/dashboard/charts/risk-distribution', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRiskByCycle(params) {
  const response = await client.get('/api/v1/dashboard/charts/risk-by-cycle', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getRedFlags(params) {
  const response = await client.get('/api/v1/dashboard/insights/red-flags', {
    params: cleanParams(params),
  });
  return response.data;
}

export async function getStudents(params) {
  const response = await client.get('/api/v1/dashboard/students', {
    params: cleanParams(params),
  });
  return response.data;
}
