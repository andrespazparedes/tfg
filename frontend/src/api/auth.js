import client from './client';

export async function login(email, password) {
  const response = await client.post('/api/v1/auth/login', { email, password });
  return response.data;
}

export async function getMe() {
  const response = await client.get('/api/v1/auth/me');
  return response.data;
}
