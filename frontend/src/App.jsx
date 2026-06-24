import React, { useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { DashboardProvider } from './context/DashboardContext';
import { AppLayout } from './components/layout/AppLayout';
import { mockLogin } from './services/api';

import { MicroDashboard } from './pages/MicroDashboard';
import { MacroDashboard } from './pages/MacroDashboard';
import { Socioeconomic } from './pages/Socioeconomic';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    const initAuth = async () => {
      const token = await mockLogin();
      if (token) {
        setIsAuthenticated(true);
      }
    };
    initAuth();
  }, []);

  if (!isAuthenticated) {
    return <div style={{ padding: '50px', textAlign: 'center' }}>Iniciando sesión segura...</div>;
  }

  return (
    <DashboardProvider>
      <Routes>
        <Route path="/" element={<AppLayout />}>
          <Route index element={<Navigate to="/macro" replace />} />
          <Route path="macro" element={<MacroDashboard />} />
          <Route path="micro" element={<MicroDashboard />} />
          <Route path="socioeconomic" element={<Socioeconomic />} />
        </Route>
      </Routes>
    </DashboardProvider>
  );
}

export default App;
