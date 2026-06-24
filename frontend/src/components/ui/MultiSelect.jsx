import React, { useState, useRef, useEffect } from 'react';
import { ChevronDown, Check, Search, Minus } from 'lucide-react';
import './MultiSelect.css';

export const MultiSelect = ({ label, options, selectedValues, onChange, placeholder = "Todos", searchable = false, singleSelect = false }) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const dropdownRef = useRef(null);

  // Cerrar al hacer clic fuera
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false);
        setSearchTerm(''); // Resetear búsqueda al cerrar
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const toggleOption = (value) => {
    if (singleSelect) {
      // Si ya está seleccionado, lo deselecciona. Si no, selecciona solo este.
      if (selectedValues.includes(value)) {
        onChange([]);
      } else {
        onChange([value]);
        setIsOpen(false); // Cerramos el menú tras seleccionar en modo single
      }
      return;
    }
    
    let newValues;
    if (selectedValues.includes(value)) {
      newValues = selectedValues.filter(v => v !== value);
    } else {
      newValues = [...selectedValues, value];
    }
    onChange(newValues);
  };

  const allSelected = options.length > 0 && selectedValues.length === options.length;
  const isPartiallySelected = selectedValues.length > 0 && selectedValues.length < options.length;

  const toggleAll = () => {
    if (singleSelect) {
      onChange([]); // En singleSelect "Todos" simplemente limpia la selección
      return;
    }
    if (allSelected) {
      onChange([]);
    } else {
      onChange(options.map(o => o.value));
    }
  };

  // Filtrado de opciones
  const filteredOptions = searchable && searchTerm 
    ? options.filter(opt => opt.label.toLowerCase().includes(searchTerm.toLowerCase()))
    : options;

  // Texto a mostrar en el botón
  let displayText = placeholder;
  if (selectedValues.length === 1) {
    const opt = options.find(o => o.value === selectedValues[0]);
    displayText = opt ? opt.label : selectedValues[0];
  } else if (selectedValues.length > 1) {
    displayText = `Varios seleccionados (${selectedValues.length})`;
  }

  return (
    <div className="multi-select-container" ref={dropdownRef}>
      <button 
        type="button" 
        className={`multi-select-btn ${isOpen ? 'active' : ''} ${selectedValues.length > 0 ? 'has-values' : ''}`}
        onClick={() => setIsOpen(!isOpen)}
      >
        <span className="truncate">{displayText}</span>
        <ChevronDown size={16} className={`chevron ${isOpen ? 'rotate' : ''}`} />
      </button>

      {isOpen && (
        <div className="multi-select-dropdown">
          {searchable && (
            <div className="multi-select-search">
              <Search size={14} className="search-icon" />
              <input 
                type="text" 
                placeholder="Buscar..." 
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                onClick={(e) => e.stopPropagation()}
              />
            </div>
          )}

          <div className="multi-select-options-container">
            {options.length > 0 && !searchTerm && (
              <div 
                className="multi-select-option master-toggle"
                onClick={(e) => { e.stopPropagation(); toggleAll(); }}
              >
                {!singleSelect && (
                  <div className={`checkbox ${allSelected || isPartiallySelected ? 'checked' : ''} ${isPartiallySelected ? 'partial' : ''}`}>
                    {allSelected && <Check size={12} />}
                    {isPartiallySelected && <Minus size={12} />}
                  </div>
                )}
                <span className="option-label" style={{ fontWeight: 600 }}>
                  {singleSelect ? "Sin filtro (Todas las alertas)" : "Todos"}
                </span>
              </div>
            )}

            {filteredOptions.length === 0 ? (
              <div className="multi-select-empty">No hay resultados</div>
            ) : (
              filteredOptions.map((opt) => {
                const isSelected = selectedValues.includes(opt.value);
                return (
                  <div 
                    key={opt.value} 
                    className={`multi-select-option ${isSelected ? 'selected' : ''}`}
                    onClick={(e) => { e.stopPropagation(); toggleOption(opt.value); }}
                  >
                    <div className={`checkbox ${isSelected ? 'checked' : ''}`}>
                      {isSelected && <Check size={12} />}
                    </div>
                    <span className="option-label">{opt.label}</span>
                  </div>
                );
              })
            )}
          </div>
        </div>
      )}
    </div>
  );
};
