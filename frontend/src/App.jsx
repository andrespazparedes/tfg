import React, { useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { DashboardProvider } from './context/DashboardContext';
import { AppLayout } from './components/layout/AppLayout';
import { useAuth } from './context/AuthContext';
import LoginPage from './pages/LoginPage';

import { MicroDashboard } from './pages/MicroDashboard';
import { MacroDashboard } from './pages/MacroDashboard';
import { UserManagement } from './pages/UserManagement';
import { NotFound } from './pages/NotFound';
import { ErrorBoundary } from './components/ui/ErrorBoundary';

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
          element={isAuthenticated ? <ErrorBoundary><AppLayout /></ErrorBoundary> : <Navigate to="/login" replace />}
        >
          <Route index element={<Navigate to="/macro" replace />} />
          <Route path="macro" element={<MacroDashboard />} />
          <Route path="micro" element={<MicroDashboard />} />
          <Route path="users" element={<UserManagement />} />
          <Route path="*" element={<NotFound />} />
        </Route>
        <Route path="*" element={<NotFound />} />
      </Routes>
    </DashboardProvider>
  );
}

export default App;
