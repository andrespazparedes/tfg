import React, { createContext, useContext, useState, useEffect } from 'react';

const DashboardContext = createContext();

export const useDashboardContext = () => useContext(DashboardContext);

export const DashboardProvider = ({ children }) => {
  // 1. Estado del Tema (Claro/Oscuro)
  const [theme, setTheme] = useState(localStorage.getItem('theme') || 'dark');

  useEffect(() => {
    // Aplicamos el tema al documento HTML para que las variables CSS surtan efecto
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [theme]);

  const toggleTheme = () => {
    setTheme((prev) => (prev === 'dark' ? 'light' : 'dark'));
  };

  // 2. Filtros Globales (Centro, Curso, Ciclo, Tipo)
  const [filters, setFilters] = useState({
    cod_centro: [],
    curso_academico: [],
    cod_ciclo: [],
    tipo_centro: [],
  });

  const updateFilter = (key, value) => {
    setFilters((prev) => ({
      ...prev,
      [key]: value,
    }));
  };

  const resetFilters = (defaultCurso = []) => {
    setFilters({ cod_centro: [], curso_academico: defaultCurso, cod_ciclo: [], tipo_centro: [] });
  };

  // 3. Estado de Cross-Filtering (Alertas)
  // activeAlerts guardará un array con las alertas activas. Ej: ['alerta_abandono_temprano']
  const [activeAlerts, setActiveAlerts] = useState([]);

  const triggerDrilldown = (alertKey) => {
    setActiveAlerts([alertKey]);
  };

  const clearDrilldown = () => {
    setActiveAlerts([]);
  };

  // 4. Drill-down de Macro a Micro
  const setDrillDownCentro = (cod_centro) => {
    updateFilter('cod_centro', [cod_centro]);
  };

  return (
    <DashboardContext.Provider
      value={{
        theme,
        toggleTheme,
        filters,
        updateFilter,
        resetFilters,
        activeAlerts,
        setActiveAlerts,
        triggerDrilldown,
        clearDrilldown,
        setDrillDownCentro,
      }}
    >
      {children}
    </DashboardContext.Provider>
  );
};
