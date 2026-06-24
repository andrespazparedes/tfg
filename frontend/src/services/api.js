import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api/v1';

// Cliente Axios principal
export const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Mock Login: Función para obtener y guardar un token automáticamente
export const mockLogin = async () => {
  try {
    const response = await axios.post(`${API_URL}/auth/login`, {
      email: 'admin@tfg.com',
      password: 'admin123',
    });
    const token = response.data.access_token;
    localStorage.setItem('token', token);
    return token;
  } catch (error) {
    console.error('Error en el auto-login:', error);
    return null;
  }
};

// Interceptor de Peticiones: Inyecta el JWT en cada llamada
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Interceptor de Respuestas: Para atrapar errores de autenticación (401)
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    // Si da 401 (token expirado o inválido), intentamos reconectar
    if (error.response && error.response.status === 401) {
      console.warn('Token expirado. Intentando reconexión...');
      const newToken = await mockLogin();
      if (newToken) {
        error.config.headers.Authorization = `Bearer ${newToken}`;
        return axios(error.config); // Re-intenta la petición original
      }
    }
    return Promise.reject(error);
  }
);
