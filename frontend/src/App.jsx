import React, { useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { DashboardProvider } from './context/DashboardContext';
import { AppLayout } from './components/layout/AppLayout';
import { useAuth } from './context/AuthContext';
import LoginPage from './pages/LoginPage';

import { MicroDashboard } from './pages/MicroDashboard';
import { MacroDashboard } from './pages/MacroDashboard';

function App() {
  const { isAuthenticated } = useAuth();

  return (
    <DashboardProvider>
      <Routes>
        <Route 
          path="/login" 
          element={isAuthenticated ? <Navigate to="/macro" replace /> : <LoginPage />} 
        />
        
        <Route 
          path="/" 
          element={isAuthenticated ? <AppLayout /> : <Navigate to="/login" replace />}
        >
          <Route index element={<Navigate to="/macro" replace />} />
          <Route path="macro" element={<MacroDashboard />} />
          <Route path="micro" element={<MicroDashboard />} />
        </Route>
      </Routes>
    </DashboardProvider>
  );
}

export default App;
