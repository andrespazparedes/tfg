/**
 * Motor de cálculos (Client-Side DAX)
 */

/**
 * Calcula la variación porcentual interanual (Year-over-Year).
 * @param {number} current - Valor en T0
 * @param {number} previous - Valor en T-1
 * @returns {number|null} - Porcentaje de variación (ej. 15.5 para +15.5%, o -10.2 para -10.2%)
 */
export const calculateYoY = (current, previous) => {
  if (current === undefined || current === null) return null;
  if (previous === undefined || previous === null) return null;
  
  if (previous === 0) {
    if (current === 0) return 0;
    return null; // Matemáticamente no se puede calcular % de incremento desde 0
  }
  
  const variation = ((current - previous) / previous) * 100;
  return Number(variation.toFixed(1));
};

/**
 * Calcula qué porcentaje representa una parte sobre un total.
 * @param {number} part - La parte (ej. alumnos suspensos)
 * @param {number} total - El total (ej. total de alumnos)
 * @returns {number|null} - Porcentaje (ej. 45.2)
 */
export const calculatePercentage = (part, total) => {
  if (part === undefined || part === null || !total) return null;
  const percentage = (part / total) * 100;
  return Number(percentage.toFixed(1));
};

/**
 * Formatea un número grande para visualización (ej. 15000 -> 15.0k)
 */
export const formatNumber = (num) => {
  if (!num) return '0';
  if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
  if (num >= 1000) return (num / 1000).toFixed(1) + 'k';
  return num.toString();
};
