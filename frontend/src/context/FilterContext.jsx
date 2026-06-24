import { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { getFilters } from '../api/dashboard';

const FilterContext = createContext(null);

export function FilterProvider({ children }) {
  const [codCentro, setCodCentro] = useState('');
  const [cursoAcademico, setCursoAcademico] = useState('');
  const [codCiclo, setCodCiclo] = useState('');
  const [tipoCentro, setTipoCentro] = useState('');
  const [filters, setFilters] = useState({
    centros: [],
    cursos_academicos: [],
    ciclos: [],
    tipos_centro: [],
  });

  useEffect(() => {
    let cancelled = false;

    async function fetchFilters() {
      try {
        const data = await getFilters();
        if (!cancelled) {
          setFilters(data);
        }
      } catch (error) {
        console.error('Failed to load filters:', error);
      }
    }

    fetchFilters();

    return () => {
      cancelled = true;
    };
  }, []);

  const setFilter = useCallback((name, value) => {
    switch (name) {
      case 'codCentro':
        setCodCentro(value);
        break;
      case 'cursoAcademico':
        setCursoAcademico(value);
        break;
      case 'codCiclo':
        setCodCiclo(value);
        break;
      case 'tipoCentro':
        setTipoCentro(value);
        break;
      default:
        console.warn(`Unknown filter: ${name}`);
    }
  }, []);

  const resetFilters = useCallback(() => {
    setCodCentro('');
    setCursoAcademico('');
    setCodCiclo('');
    setTipoCentro('');
  }, []);

  return (
    <FilterContext.Provider
      value={{
        codCentro,
        cursoAcademico,
        codCiclo,
        tipoCentro,
        filters,
        setFilter,
        resetFilters,
      }}
    >
      {children}
    </FilterContext.Provider>
  );
}

export function useFilters() {
  const context = useContext(FilterContext);
  if (!context) {
    throw new Error('useFilters must be used within a FilterProvider');
  }
  return context;
}

export default FilterContext;
