import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || '/api/v1';

// Cliente Axios principal
export const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});



// Interceptor de Peticiones: Inyecta el JWT en cada llamada
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('access_token') || localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    // Si da 401 (token expirado o inválido), redirigir a login
    if (error.response && error.response.status === 401) {
      console.warn('Token expirado o no autorizado.');
      localStorage.removeItem('access_token');
      localStorage.removeItem('token');
      // Podríamos despachar un evento o redirigir directamente
      if (window.location.pathname !== '/login') {
        window.location.href = '/login';
      }
    }
    return Promise.reject(error);
  }
);
