-- Script de Inicialización del Catálogo Académico Completo (LOMLOE)
-- Abarca: Todos los niveles de Educación Infantil, Educación Primaria y ESO
-- Base de Datos: Source (Simulación Origen - TFG)

-- Limpiar todas las tablas para asegurar consistencia absoluta
TRUNCATE LINEA_EXPEDIENTE, ASIGNATURA_MATRICULA, MATRICULA, ADMISION, CENTRO, 
         ADAPTACION_ASIGNATURA, ADAPTACION_CURRICULAR, ESTUDIANTE, ENCUESTA, 
         RESPONSABLE_LEGAL, ASIGNATURA, CURSO, ESPECIALIDAD, CICLO_EDUCATIVO RESTART IDENTITY CASCADE;

-- =========================================================================
-- 1. CICLO_EDUCATIVO
-- =========================================================================
INSERT INTO CICLO_EDUCATIVO (cod_ciclo, nombre, real_decreto, decreto_autonomico) VALUES
('INF', 'Educación Infantil (Segundo Ciclo)', 'RD 95/2022', 'Decreto 100/2023'),
('PRI', 'Educación Primaria', 'RD 157/2022', 'Decreto 101/2023'),
('ESO', 'Educación Secundaria Obligatoria', 'RD 217/2022', 'Decreto 102/2023');

-- =========================================================================
-- 2. ESPECIALIDAD (Itinerarios / Programas Académicos)
-- =========================================================================
-- En la enseñanza no universitaria española no hay especialidades como tal,
-- pero se modelan como Itinerarios o Programas de Aprendizaje específicos:
-- - INF-GEN: Infantil General (3 a 6 años).
-- - PRI-GEN: Primaria General (1º a 6º).
-- - ESO-GEN: ESO Vía Académica General (1º a 4º).
-- - ESO-DIV: Programa de Diversificación Curricular (LOMLOE - 3º y 4º de ESO).
--   Orientado a la permanencia y éxito escolar de alumnos con dificultades.
-- - ESO-GB: Ciclo Formativo de Grado Básico (FP Básica - 3º y 4º de ESO).
--   Vía clave alternativa para evitar el abandono escolar temprano.
INSERT INTO ESPECIALIDAD (cod_especialidad, nombre, cod_ciclo) VALUES
('INF-GEN', 'Segundo Ciclo de Educación Infantil (General)', 'INF'),
('PRI-GEN', 'Educación Primaria (Itinerario General)', 'PRI'),
('ESO-GEN', 'ESO - Itinerario Ordinario/General', 'ESO'),
('ESO-DIV', 'ESO - Programa de Diversificación Curricular', 'ESO'),
('ESO-GB',  'ESO - Ciclo Formativo de Grado Básico (FP Básica)', 'ESO');

-- =========================================================================
-- 3. CURSO (Todos los niveles de Infantil, Primaria y ESO)
-- =========================================================================
INSERT INTO CURSO (num_curso, cod_especialidad, num_optativas) VALUES
-- Educación Infantil (Segundo Ciclo completo: 3, 4 y 5 años)
(1, 'INF-GEN', 0), -- 1º Infantil (3 años)
(2, 'INF-GEN', 0), -- 2º Infantil (4 años)
(3, 'INF-GEN', 0), -- 3º Infantil (5 años)

-- Educación Primaria (Todos los niveles: 1º a 6º)
(1, 'PRI-GEN', 0), -- 1º de Primaria
(2, 'PRI-GEN', 0), -- 2º de Primaria
(3, 'PRI-GEN', 0), -- 3º de Primaria
(4, 'PRI-GEN', 0), -- 4º de Primaria
(5, 'PRI-GEN', 0), -- 5º de Primaria
(6, 'PRI-GEN', 0), -- 6º de Primaria

-- ESO - Itinerario Ordinario General (1º a 4º)
(1, 'ESO-GEN', 1), -- 1º de ESO (General)
(2, 'ESO-GEN', 1), -- 2º de ESO (General)
(3, 'ESO-GEN', 2), -- 3º de ESO (General)
(4, 'ESO-GEN', 3), -- 4º de ESO (General)

-- ESO - Programa de Diversificación Curricular (LOMLOE - 3º y 4º de ESO)
-- Equivale a 1º y 2º de Diversificación respectivamente
(3, 'ESO-DIV', 0), -- 3º ESO Diversificación
(4, 'ESO-DIV', 1), -- 4º ESO Diversificación

-- ESO - Ciclo Formativo de Grado Básico (3º y 4º de ESO)
-- Equivale a 1º y 2º de FP Básica
(3, 'ESO-GB', 0),  -- 1º Grado Básico (equivalente a 3º ESO)
(4, 'ESO-GB', 0);  -- 2º Grado Básico (equivalente a 4º ESO)

-- =========================================================================
-- 4. ASIGNATURA (Catálogo Completo Oficial LOMLOE)
-- =========================================================================
INSERT INTO ASIGNATURA (cod_asignatura, nombre, tipo, num_horas, num_curso, cod_especialidad) VALUES
-- -------------------------------------------------------------------------
-- 4.1. EDUCACIÓN INFANTIL (Áreas de desarrollo y experiencia LOMLOE)
-- -------------------------------------------------------------------------
-- 1º Infantil (3 años)
('INF1-CRE', 'Crecimiento en Armonía', 'Obligatoria', 150, 1, 'INF-GEN'),
('INF1-DES', 'Descubrimiento y Exploración del Entorno', 'Obligatoria', 150, 1, 'INF-GEN'),
('INF1-COM', 'Comunicación y Representación de la Realidad', 'Obligatoria', 150, 1, 'INF-GEN'),
-- 2º Infantil (4 años)
('INF2-CRE', 'Crecimiento en Armonía', 'Obligatoria', 150, 2, 'INF-GEN'),
('INF2-DES', 'Descubrimiento y Exploración del Entorno', 'Obligatoria', 150, 2, 'INF-GEN'),
('INF2-COM', 'Comunicación y Representación de la Realidad', 'Obligatoria', 150, 2, 'INF-GEN'),
-- 3º Infantil (5 años)
('INF3-CRE', 'Crecimiento en Armonía', 'Obligatoria', 150, 3, 'INF-GEN'),
('INF3-DES', 'Descubrimiento y Exploración del Entorno', 'Obligatoria', 150, 3, 'INF-GEN'),
('INF3-COM', 'Comunicación y Representación de la Realidad', 'Obligatoria', 150, 3, 'INF-GEN'),

-- -------------------------------------------------------------------------
-- 4.2. EDUCACIÓN PRIMARIA (Materias Oficiales)
-- -------------------------------------------------------------------------
-- 1º Primaria
('PRI1-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 1, 'PRI-GEN'),
('PRI1-MAT', 'Matemáticas', 'Obligatoria', 175, 1, 'PRI-GEN'),
('PRI1-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 1, 'PRI-GEN'),
('PRI1-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 1, 'PRI-GEN'),
('PRI1-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 1, 'PRI-GEN'),
('PRI1-EFI', 'Educación Física', 'Obligatoria', 100, 1, 'PRI-GEN'),

-- 2º Primaria
('PRI2-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 2, 'PRI-GEN'),
('PRI2-MAT', 'Matemáticas', 'Obligatoria', 175, 2, 'PRI-GEN'),
('PRI2-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 2, 'PRI-GEN'),
('PRI2-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 2, 'PRI-GEN'),
('PRI2-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 2, 'PRI-GEN'),
('PRI2-EFI', 'Educación Física', 'Obligatoria', 100, 2, 'PRI-GEN'),

-- 3º Primaria
('PRI3-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 3, 'PRI-GEN'),
('PRI3-MAT', 'Matemáticas', 'Obligatoria', 175, 3, 'PRI-GEN'),
('PRI3-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 3, 'PRI-GEN'),
('PRI3-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 3, 'PRI-GEN'),
('PRI3-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 3, 'PRI-GEN'),
('PRI3-EFI', 'Educación Física', 'Obligatoria', 100, 3, 'PRI-GEN'),

-- 4º Primaria
('PRI4-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 4, 'PRI-GEN'),
('PRI4-MAT', 'Matemáticas', 'Obligatoria', 175, 4, 'PRI-GEN'),
('PRI4-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 4, 'PRI-GEN'),
('PRI4-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 4, 'PRI-GEN'),
('PRI4-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 4, 'PRI-GEN'),
('PRI4-EFI', 'Educación Física', 'Obligatoria', 100, 4, 'PRI-GEN'),

-- 5º Primaria
('PRI5-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 5, 'PRI-GEN'),
('PRI5-MAT', 'Matemáticas', 'Obligatoria', 175, 5, 'PRI-GEN'),
('PRI5-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 5, 'PRI-GEN'),
('PRI5-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 5, 'PRI-GEN'),
('PRI5-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 5, 'PRI-GEN'),
('PRI5-EFI', 'Educación Física', 'Obligatoria', 100, 5, 'PRI-GEN'),

-- 6º Primaria
('PRI6-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 175, 6, 'PRI-GEN'),
('PRI6-MAT', 'Matemáticas', 'Obligatoria', 175, 6, 'PRI-GEN'),
('PRI6-CON', 'Conocimiento del Medio Natural, Social y Cultural', 'Obligatoria', 140, 6, 'PRI-GEN'),
('PRI6-ING', 'Lengua Extranjera (Inglés)', 'Obligatoria', 105, 6, 'PRI-GEN'),
('PRI6-ART', 'Educación Artística (Plástica y Música)', 'Obligatoria', 105, 6, 'PRI-GEN'),
('PRI6-EFI', 'Educación Física', 'Obligatoria', 100, 6, 'PRI-GEN'),

-- -------------------------------------------------------------------------
-- 4.3. EDUCACIÓN SECUNDARIA OBLIGATORIA (Vía Ordinaria)
-- -------------------------------------------------------------------------
-- 1º ESO
('ESO1-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 140, 1, 'ESO-GEN'),
('ESO1-MAT', 'Matemáticas', 'Obligatoria', 140, 1, 'ESO-GEN'),
('ESO1-ING', 'Primera Lengua Extranjera (Inglés)', 'Obligatoria', 105, 1, 'ESO-GEN'),
('ESO1-GH',  'Geografía e Historia', 'Obligatoria', 105, 1, 'ESO-GEN'),
('ESO1-BG',  'Biología y Geología', 'Obligatoria', 105, 1, 'ESO-GEN'),
('ESO1-EFI', 'Educación Física', 'Obligatoria', 70, 1, 'ESO-GEN'),
('ESO1-EPV', 'Educación Plástica, Visual y Audiovisual', 'Obligatoria', 70, 1, 'ESO-GEN'),
('ESO1-FRA', 'Segunda Lengua Extranjera (Francés)', 'Optativa', 70, 1, 'ESO-GEN'),

-- 2º ESO
('ESO2-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 140, 2, 'ESO-GEN'),
('ESO2-MAT', 'Matemáticas', 'Obligatoria', 140, 2, 'ESO-GEN'),
('ESO2-ING', 'Primera Lengua Extranjera (Inglés)', 'Obligatoria', 105, 2, 'ESO-GEN'),
('ESO2-GH',  'Geografía e Historia', 'Obligatoria', 105, 2, 'ESO-GEN'),
('ESO2-FQ',  'Física y Química', 'Obligatoria', 105, 2, 'ESO-GEN'),
('ESO2-TEC', 'Tecnología y Digitalización', 'Obligatoria', 70, 2, 'ESO-GEN'),
('ESO2-MUS', 'Música', 'Obligatoria', 70, 2, 'ESO-GEN'),
('ESO2-EFI', 'Educación Física', 'Obligatoria', 70, 2, 'ESO-GEN'),
('ESO2-CUL', 'Cultura Clásica', 'Optativa', 70, 2, 'ESO-GEN'),

-- 3º ESO
('ESO3-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 140, 3, 'ESO-GEN'),
('ESO3-MAT', 'Matemáticas', 'Obligatoria', 140, 3, 'ESO-GEN'),
('ESO3-ING', 'Primera Lengua Extranjera (Inglés)', 'Obligatoria', 105, 3, 'ESO-GEN'),
('ESO3-GH',  'Geografía e Historia', 'Obligatoria', 105, 3, 'ESO-GEN'),
('ESO3-FQ',  'Física y Química', 'Obligatoria', 70, 3, 'ESO-GEN'),
('ESO3-BG',  'Biología y Geología', 'Obligatoria', 70, 3, 'ESO-GEN'),
('ESO3-TEC', 'Tecnología y Digitalización', 'Obligatoria', 70, 3, 'ESO-GEN'),
('ESO3-EFI', 'Educación Física', 'Obligatoria', 70, 3, 'ESO-GEN'),
('ESO3-FRA', 'Segunda Lengua Extranjera (Francés)', 'Optativa', 70, 3, 'ESO-GEN'),
('ESO3-EUP', 'Educación en Valores Cívicos y Éticos', 'Obligatoria', 50, 3, 'ESO-GEN'),

-- 4º ESO
('ESO4-LCL', 'Lengua Castellana y Literatura', 'Obligatoria', 140, 4, 'ESO-GEN'),
('ESO4-MATE', 'Matemáticas B (Orientación Académica)', 'Obligatoria', 140, 4, 'ESO-GEN'),
('ESO4-MATP', 'Matemáticas A (Orientación Aplicada)', 'Obligatoria', 140, 4, 'ESO-GEN'),
('ESO4-ING', 'Primera Lengua Extranjera (Inglés)', 'Obligatoria', 105, 4, 'ESO-GEN'),
('ESO4-GH',  'Geografía e Historia', 'Obligatoria', 105, 4, 'ESO-GEN'),
('ESO4-EFI', 'Educación Física', 'Obligatoria', 70, 4, 'ESO-GEN'),
-- Opciones/Especialidades de 4º ESO
('ESO4-BIO', 'Biología y Geología', 'Optativa', 105, 4, 'ESO-GEN'),
('ESO4-FYQ', 'Física y Química', 'Optativa', 105, 4, 'ESO-GEN'),
('ESO4-LAT', 'Latín', 'Optativa', 105, 4, 'ESO-GEN'),
('ESO4-ECO', 'Economía y Emprendimiento', 'Optativa', 105, 4, 'ESO-GEN'),
('ESO4-TEC', 'Tecnología', 'Optativa', 105, 4, 'ESO-GEN'),
('ESO4-DIG', 'Digitalización', 'Optativa', 105, 4, 'ESO-GEN'),

-- -------------------------------------------------------------------------
-- 4.4. EDUCACIÓN SECUNDARIA OBLIGATORIA (Diversificación Curricular)
-- -------------------------------------------------------------------------
-- 3º ESO Diversificación (1º de Diversificación)
('ESOD3-ACT', 'Ámbito Científico-Tecnológico (Refuerzo)', 'Obligatoria', 280, 3, 'ESO-DIV'),
('ESOD3-ALS', 'Ámbito Lingüístico y Social (Refuerzo)', 'Obligatoria', 245, 3, 'ESO-DIV'),
('ESOD3-ING', 'Primera Lengua Extranjera (Inglés Adaptado)', 'Obligatoria', 105, 3, 'ESO-DIV'),
('ESOD3-EFI', 'Educación Física', 'Obligatoria', 70, 3, 'ESO-DIV'),
('ESOD3-ART', 'Educación Plástica o Música (Integradora)', 'Obligatoria', 70, 3, 'ESO-DIV'),

-- 4º ESO Diversificación (2º de Diversificación)
('ESOD4-ACT', 'Ámbito Científico-Tecnológico (Refuerzo)', 'Obligatoria', 280, 4, 'ESO-DIV'),
('ESOD4-ALS', 'Ámbito Lingüístico y Social (Refuerzo)', 'Obligatoria', 245, 4, 'ESO-DIV'),
('ESOD4-ING', 'Primera Lengua Extranjera (Inglés Adaptado)', 'Obligatoria', 105, 4, 'ESO-DIV'),
('ESOD4-EFI', 'Educación Física', 'Obligatoria', 70, 4, 'ESO-DIV'),
('ESOD4-ECO', 'Economía y Emprendimiento Adaptado', 'Optativa', 105, 4, 'ESO-DIV'),

-- -------------------------------------------------------------------------
-- 4.5. EDUCACIÓN SECUNDARIA OBLIGATORIA (Ciclos de Grado Básico / FP Básica)
-- -------------------------------------------------------------------------
-- 3º ESO - 1º Grado Básico (Ámbitos comunes de FPB + Talleres prácticos)
('ESOGB1-ACT', 'Ámbito de Ciencias Aplicadas (Matemáticas y Ciencias)', 'Obligatoria', 180, 3, 'ESO-GB'),
('ESOGB1-ALS', 'Ámbito de Comunicación y Ciencias Sociales (Lengua e Inglés)', 'Obligatoria', 200, 3, 'ESO-GB'),
('ESOGB1-PRAC', 'Taller Práctico de la Especialidad Profesional', 'Obligatoria', 320, 3, 'ESO-GB'),
('ESOGB1-EFI', 'Educación Física', 'Obligatoria', 70, 3, 'ESO-GB'),

-- 4º ESO - 2º Grado Básico (Ámbitos comunes de FPB + Talleres prácticos)
('ESOGB2-ACT', 'Ámbito de Ciencias Aplicadas (Matemáticas y Ciencias)', 'Obligatoria', 180, 4, 'ESO-GB'),
('ESOGB2-ALS', 'Ámbito de Comunicación y Ciencias Sociales (Lengua e Inglés)', 'Obligatoria', 200, 4, 'ESO-GB'),
('ESOGB2-PRAC', 'Taller Práctico y Formación en Centros de Trabajo (FCT)', 'Obligatoria', 360, 4, 'ESO-GB'),
('ESOGB2-EFI', 'Educación Física', 'Obligatoria', 70, 4, 'ESO-GB');

-- =========================================================================
-- 5. CENTRO (Red de Centros Educativos en la ciudad de A Coruña)
-- =========================================================================
-- Registramos 18 centros reales (6 CEIP, 6 Colegios Concertados, 6 IES)
INSERT INTO CENTRO (cod_centro, nombre, email, tipo, direccion, telefono, naturaleza) VALUES
-- 5.1. CEIPs Públicos (Educación Infantil y Primaria)
('C001', 'CEIP Emilia Pardo Bazán', 'ceip.emilia.pardobazan@edu.xunta.gal', 'Público', 'Rúa de la Torre 55, CP 15002, A Coruña', '981001111', 'CEIP'),
('C002', 'CEIP María Pita', 'ceip.mariapita@edu.xunta.gal', 'Público', 'Rúa de la Sardiñeira s/n, CP 15007, A Coruña', '981001112', 'CEIP'),
('C003', 'CEIP Salgado Torres', 'ceip.salgadotorres@edu.xunta.gal', 'Público', 'Rúa Xeneral Salgado Torres s/n, CP 15008, A Coruña', '981001113', 'CEIP'),
('C004', 'CEIP Alborada', 'ceip.alborada@edu.xunta.gal', 'Público', 'Rúa de la Alborada s/n, CP 15008, A Coruña', '981001114', 'CEIP'),
('C005', 'CEIP Ramón de la Sagra', 'ceip.ramondesagra@edu.xunta.gal', 'Público', 'Rúa Ramón de la Sagra 8, CP 15005, A Coruña', '981001115', 'CEIP'),
('C006', 'CEIP Cidade Vella', 'ceip.cidadevella@edu.xunta.gal', 'Público', 'Rúa Herrerías 2, CP 15001, A Coruña', '981001116', 'CEIP'),

-- 5.2. Colegios Concertados (Infantil, Primaria y ESO)
('C007', 'Colegio Compañía de María', 'ciademaria.coruna@educacion.es', 'Concertado', 'Avda. de Hércules 12, CP 15002, A Coruña', '981002222', 'Colegio Concertado'),
('C008', 'Colegio Maristas Cristo Rey', 'maristas.cristorey@educacion.es', 'Concertado', 'Rúa Francisco Mariño 4, CP 15004, A Coruña', '981002223', 'Colegio Concertado'),
('C009', 'Colegio Santa María del Mar', 'santamariadelmar@educacion.es', 'Concertado', 'Avda. Pasaxe 80, CP 15006, A Coruña', '981002224', 'Colegio Concertado'),
('C010', 'Colegio Salesianos San Juan Bosco', 'salesianos.coruna@educacion.es', 'Concertado', 'Rúa Hospital 14, CP 15002, A Coruña', '981002225', 'Colegio Concertado'),
('C011', 'Colegio Santo Domingo', 'dominicos.coruna@educacion.es', 'Concertado', 'Rúa Santo Domingo 10, CP 15001, A Coruña', '981002226', 'Colegio Concertado'),
('C012', 'Colegio Calasanz Escolapios', 'calasanz.coruna@educacion.es', 'Concertado', 'Rúa Calasanz 6, CP 15011, A Coruña', '981002227', 'Colegio Concertado'),

-- 5.3. IES Públicos (Educación Secundaria Obligatoria y FP Básica)
('I001', 'IES Eusebio da Guarda', 'ies.eusebio.daguarda@edu.xunta.gal', 'Público', 'Praza de Pontevedra 4, CP 15004, A Coruña', '981003333', 'IES'),
('I002', 'IES Fernando Wirtz Suárez', 'ies.fernando.wirtz@edu.xunta.gal', 'Público', 'Rúa Caballeros 3, CP 15009, A Coruña', '981004444', 'IES'),
('I003', 'IES Agra do Orzán', 'ies.agradoorzan@edu.xunta.gal', 'Público', 'Rúa de la Educación s/n, CP 15010, A Coruña', '981003334', 'IES'),
('I004', 'IES de Monelos', 'ies.monelos@edu.xunta.gal', 'Público', 'Rúa de la Educación 1, CP 15010, A Coruña', '981003335', 'IES'),
('I005', 'IES Adormideras', 'ies.adormideras@edu.xunta.gal', 'Público', 'Rúa de la Dársena s/n, CP 15002, A Coruña', '981003336', 'IES'),
('I006', 'IES Ramón Menéndez Pidal (Zalaeta)', 'ies.zalaeta@edu.xunta.gal', 'Público', 'Rúa Colegio 2, CP 15002, A Coruña', '981003337', 'IES');
