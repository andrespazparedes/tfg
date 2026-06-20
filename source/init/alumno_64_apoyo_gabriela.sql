-- CASO DE ESTUDIO 64: GABRIELA OTERO VARELA (ALUMNA CON ENFERMEDAD CRÓNICA / ASMA BRONQUIAL GRAVE / ABSENTISMO MÉDICO JUSTIFICADO / NEAE)
-- Archivo: alumno_64_apoyo_gabriela.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Fernando Otero Castro y Laura Varela Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP064', 'Fernando Otero Castro', 'Laura Varela Rey', '600640011', '600640022', 'fernando.otero@email.com', 'laura.varela.re@email.com', 'Rúa Real 50, N/A, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad económica y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP064', '2023-09-10', 23500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP064', '2025-09-12', 24000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015064', '78901253D', 'Gabriela Otero Varela', '2012-10-18', 'gabriela.otero@alumno.com', 'RESP064');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015064', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015064', '2024-07-04', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-GAB3-PRI6', '2023-09-01', '2023/2024', 'EXP2015064', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-GAB3-ESO1', '2024-09-02', '2024/2025', 'EXP2015064', 'I001', 1, 'ESO-GEN'),
('MAT-GAB3-ESO2', '2025-09-01', '2025/2026', 'EXP2015064', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Salud - Asma Crónica (Activada en 1º ESO ante inasistencias recurrentes por hospitalizaciones puntuales)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP064', '2024-10-15', 'Apoyo Educativo - Enfermedad Crónica (Asma)', 'Estudiante diagnosticada con Asma Bronquial Severo persistente de difícil control. Presenta crisis respiratorias recurrentes que requieren hospitalización o reposo domiciliario estricto (absentismo justificado ~15%). Se prescribe Adaptación de Acceso: flexibilización de plazos, reprogramación de exámenes y soporte telemático de tareas.', 'EXP2015064');

-- Relacionamos la adaptación con todas las asignaturas de 2º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP064', 'ESO2-LCL'),
('ADAP064', 'ESO2-MAT'),
('ADAP064', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-GAB3-PRI6', false), ('PRI6-MAT', 'MAT-GAB3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-GAB3-PRI6', 'Final Ordinaria', 7.00),
('PRI6-MAT', 'MAT-GAB3-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025 - Rendimiento estable con flexibilización activa)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-GAB3-ESO1', false), ('ESO1-MAT', 'MAT-GAB3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-GAB3-ESO1', 'Final Ordinaria', 7.00),
('ESO1-MAT', 'MAT-GAB3-ESO1', 'Final Ordinaria', 6.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-GAB3-ESO2', false), ('ESO2-MAT', 'MAT-GAB3-ESO2', false), ('ESO2-FQ', 'MAT-GAB3-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-GAB3-ESO2', '1ª Evaluación', 6.50), -- Aprobado holgado
('ESO2-MAT', 'MAT-GAB3-ESO2', '1ª Evaluación', 6.00), -- Aprobado holgado
('ESO2-FQ',  'MAT-GAB3-ESO2', '1ª Evaluación', 6.00); -- Aprobado holgado
