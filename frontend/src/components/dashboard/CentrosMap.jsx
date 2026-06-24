import React from 'react';
import { MapContainer, TileLayer, CircleMarker, Tooltip, Popup } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { useDashboardContext } from '../../context/DashboardContext';
import { useNavigate } from 'react-router-dom';

// Utility para calcular el color degradado según el riesgo (0-10)
const getGradientColor = (risk) => {
  // 0 -> Verde, 5 -> Amarillo/Naranja, 10 -> Rojo
  // Verde: rgb(16, 185, 129)
  // Rojo: rgb(239, 68, 68)
  const normalized = Math.max(0, Math.min(10, risk)) / 10;
  
  // Interpolar de Verde a Amarillo a Rojo
  let r, g, b;
  if (normalized < 0.5) {
    // Verde a Amarillo
    // Verde: 16, 185, 129
    // Amarillo: 245, 158, 11
    const pct = normalized * 2;
    r = Math.round(16 + pct * (245 - 16));
    g = Math.round(185 + pct * (158 - 185));
    b = Math.round(129 + pct * (11 - 129));
  } else {
    // Amarillo a Rojo
    // Amarillo: 245, 158, 11
    // Rojo: 239, 68, 68
    const pct = (normalized - 0.5) * 2;
    r = Math.round(245 + pct * (239 - 245));
    g = Math.round(158 + pct * (68 - 158));
    b = Math.round(11 + pct * (68 - 11));
  }
  return `rgb(${r}, ${g}, ${b})`;
};

export const CentrosMap = ({ centros }) => {
  const { theme, setDrillDownCentro } = useDashboardContext();
  const navigate = useNavigate();

  // Filtrar centros que tienen coordenadas válidas
  const validCentros = centros.filter(c => c.lat !== null && c.lon !== null);

  // Calcular centroide dinámico para centrar el mapa donde están los datos
  const centerPosition = validCentros.length > 0
    ? [
        validCentros.reduce((sum, c) => sum + c.lat, 0) / validCentros.length,
        validCentros.reduce((sum, c) => sum + c.lon, 0) / validCentros.length
      ]
    : [40.4168, -3.7038]; // fallback: centro de España
  
  // Calcular límites geográficos si hay datos para centrar el mapa dinámicamente
  // (Simplificado, usamos bounds por defecto en el TileLayer)

  const handleAuditar = (cod_centro) => {
    setDrillDownCentro(cod_centro);
    navigate('/micro');
  };

  return (
    <div style={{ height: '400px', width: '100%', borderRadius: '12px', overflow: 'hidden', border: '1px solid var(--border-light)' }}>
      <MapContainer 
        center={centerPosition} 
        zoom={13} 
        scrollWheelZoom={false} 
        style={{ height: '100%', width: '100%' }}
      >
        <TileLayer
          url={theme === 'dark' 
            ? "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png" 
            : "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"}
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
        />
        
        {validCentros.map((centro) => {
          const color = getGradientColor(centro.indice_riesgo_centro);
          
          return (
            <CircleMarker
              key={centro.id_centro}
              center={[centro.lat, centro.lon]}
              radius={12 + Math.min(12, centro.num_estudiantes / 50)} // Puntos más grandes
              pathOptions={{
                color: 'white',
                weight: 1,
                fillColor: color,
                fillOpacity: 0.8
              }}
              eventHandlers={{
                click: () => handleAuditar(centro.cod_centro)
              }}
            >
              <Tooltip direction="top" offset={[0, -10]} opacity={1}>
                <div style={{ textAlign: 'center' }}>
                  <strong>{centro.nombre_centro}</strong><br/>
                  {centro.localidad}<br/>
                  <span style={{ color: color, fontWeight: 'bold' }}>Riesgo: {centro.indice_riesgo_centro}/10</span>
                </div>
              </Tooltip>
            </CircleMarker>
          );
        })}
      </MapContainer>
    </div>
  );
};
