import { createContext, useContext, useState, useCallback, useEffect } from 'react';
import { login as apiLogin, getMe } from '../api/auth';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [token, setToken] = useState(() => localStorage.getItem('access_token'));
  const [user, setUser] = useState(null);

  const [isInitializing, setIsInitializing] = useState(true);

  useEffect(() => {
    const fetchUser = async () => {
      if (token) {
        try {
          const userData = await getMe();
          setUser(userData);
        } catch (err) {
          console.error("Token invalid or expired", err);
          logout();
        }
      }
      setIsInitializing(false);
    };
    fetchUser();
  }, [token]);

  const login = useCallback(async (email, password) => {
    const data = await apiLogin(email, password);
    const accessToken = data.access_token;
    localStorage.setItem('access_token', accessToken);
    setToken(accessToken);
    // User will be fetched by the useEffect when token changes
    return data;
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem('access_token');
    setToken(null);
    setUser(null);
    window.location.href = '/';
  }, []);

  const isAuthenticated = !!token;

  return (
    <AuthContext.Provider value={{ token, user, isAuthenticated, isInitializing, login, logout }}>
      {!isInitializing && children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

export default AuthContext;
