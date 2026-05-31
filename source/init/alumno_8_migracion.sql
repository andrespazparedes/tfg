-- CASO DE ESTUDIO 8: GABRIELA SILVA SANTOS (INCORPORACIÓN TARDÍA POR MIGRACIÓN Y ASIMETRÍA)
-- Archivo: alumno_8_migracion.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Juliana Silva Santos)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telephone_1, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP008', 'Juliana Silva Santos', NULL, '600080011', '600080011', NULL, 'juliana.silva@email.com', NULL, 'Rúa de la Torre 88, 3º Izq, CP 15002, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos de trabajadora de hostelería recién llegada)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP008', '2023-10-20', 16000.00, true, 'Estudios Secundarios', NULL, 1, 2), -- Encuesta al matricularse en 6º Primaria
('RESP008', '2025-09-12', 15500.00, true, 'Estudios Secundarios', NULL, 1, 2); -- Encuesta al matricularse en 2º ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014008', '55667788H', 'Gabriela Silva Santos', '2012-10-04', 'gabriela.silva@alumno.com', 'RESP008');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014008', '2023-10-15', 6, 'PRI-GEN', 'C001'), -- Admitida a mitad de curso en 6º Primaria en CEIP Emilia Pardo Bazán
('EXP2014008', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- Admitida en 1º ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Incorporación a mitad de 6º Primaria y continuidad en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Emilia Pardo Bazán)
('MAT-GABI-PRI6', '2023-10-16', '2023/2024', 'EXP2014008', 'C001', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-GABI-ESO1', '2024-09-02', '2024/2025', 'EXP2014008', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-GABI-ESO2', '2025-09-01', '2025/2026', 'EXP2014008', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual)

-- 6. Adaptación Curricular / Apoyo Lingüístico (Asignado en 6º Primaria por barrera de base y lectoescritura)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP008', '2023-11-02', 'Apoyo Educativo / Adaptación Lingüística', 'Alumna procedente de inmersión en el sistema brasileño con incorporación tardía. Presenta desfase ortográfico, léxico e instrumental en lengua castellana y gallega escrita. Requiere apoyo específico y adaptación de contenidos en materias con alta carga de lectoescritura académica.', 'EXP2014008');

-- Asociamos la adaptación a la asignatura de Lengua Castellana de 6º de Primaria
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP008', 'PRI6-LCL');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Aprobados muy ajustados con inmersión)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-GABI-PRI6', false),
('PRI6-MAT', 'MAT-GABI-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-GABI-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-GABI-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO (2024/2025 - Transición aprobada al límite en troncales teóricas y holgada en prácticas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-GABI-ESO1', false),
('ESO1-MAT', 'MAT-GABI-ESO1', false),
('ESO1-GH',  'MAT-GABI-ESO1', false),
('ESO1-EFI', 'MAT-GABI-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-GABI-ESO1', 'Final Ordinaria', 5.00), -- Aprobado raspado
('ESO1-MAT', 'MAT-GABI-ESO1', 'Final Ordinaria', 6.00), -- Aprobado holgado
('ESO1-GH',  'MAT-GABI-ESO1', 'Final Ordinaria', 5.00), -- Aprobado raspado
('ESO1-EFI', 'MAT-GABI-ESO1', 'Final Ordinaria', 7.00); -- Notable

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - Caída en 1ª Ev por exigencia teórica del nuevo curso)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-GABI-ESO2', false), -- Troncal de alta carga lingüística
('ESO2-GH',  'MAT-GABI-ESO2', false), -- Troncal de alta carga memorística/lectora
('ESO2-MAT', 'MAT-GABI-ESO2', false), -- Científico-práctica
('ESO2-EFI', 'MAT-GABI-ESO2', false); -- Práctica/Deportiva

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-GABI-ESO2', '1ª Evaluación', 4.00), -- Suspenso por barrera instrumental
('ESO2-GH',  'MAT-GABI-ESO2', '1ª Evaluación', 4.00), -- Suspenso por dificultades comprensivo-expresivas
('ESO2-MAT', 'MAT-GABI-ESO2', '1ª Evaluación', 6.50), -- Aprobado holgado (buen rendimiento lógico)
('ESO2-EFI', 'MAT-GABI-ESO2', '1ª Evaluación', 7.50); -- Notable alto (buena integración motriz y social)
