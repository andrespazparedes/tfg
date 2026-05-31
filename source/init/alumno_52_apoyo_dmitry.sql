-- CASO DE ESTUDIO 52: DMITRY CASTRO GÓMEZ (ALUMNO CON PARÁLISIS CEREBRAL LEVE / ADAPTACIÓN MOTÓRICA Y METODOLÓGICA / NEAE)
-- Archivo: alumno_52_apoyo_dmitry.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Castro Varela y Ana Gómez Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP052', 'Sergio Castro Varela', 'Ana Gómez Otero', '600520011', '600520022', 'sergio.castro.v@email.com', 'ana.gomez.otero@email.com', 'Rúa Alfredo Vicenti 40, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos de clase media con gastos médicos cubiertos)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP052', '2023-09-10', 21000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP052', '2025-09-12', 21500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015052', '78901248Y', 'Dmitry Castro Gómez', '2012-08-15', 'dmitry.castro@alumno.com', 'RESP052');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015052', '2023-06-15', 6, 'PRI-GEN', 'C002'), -- CEIP María Pita
('EXP2015052', '2024-07-04', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-DMIT-PRI6', '2023-09-01', '2023/2024', 'EXP2015052', 'C002', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-DMIT-ESO1', '2024-09-02', '2024/2025', 'EXP2015052', 'I001', 1, 'ESO-GEN'),
('MAT-DMIT-ESO2', '2025-09-01', '2025/2026', 'EXP2015052', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Diversidad Funcional Motórica (Activada por parálisis cerebral leve con afectación en escritura manual)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP052', '2024-10-10', 'Apoyo Educativo - Diversidad Funcional Motórica', 'Estudiante diagnosticado con Parálisis Cerebral Infantil leve de carácter hemiparésico. Presenta espasticidad moderada en miembro superior derecho, dificultando la escritura manual fluida y rápida. Se prescribe Adaptación de Acceso: uso preferente de procesador de textos para tareas y exámenes, y exención de penalizaciones por caligrafía.', 'EXP2015052');

-- Relacionamos la adaptación con todas las asignaturas de 2º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP052', 'ESO2-LCL'),
('ADAP052', 'ESO2-MAT'),
('ADAP052', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-DMIT-PRI6', false), ('PRI6-MAT', 'MAT-DMIT-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-DMIT-PRI6', 'Final Ordinaria', 7.00),
('PRI6-MAT', 'MAT-DMIT-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025 - Transición satisfactoria con adaptación digital)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-DMIT-ESO1', false), ('ESO1-MAT', 'MAT-DMIT-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-DMIT-ESO1', 'Final Ordinaria', 7.00),
('ESO1-MAT', 'MAT-DMIT-ESO1', 'Final Ordinaria', 7.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-DMIT-ESO2', false), ('ESO2-MAT', 'MAT-DMIT-ESO2', false), ('ESO2-FQ', 'MAT-DMIT-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-DMIT-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-MAT', 'MAT-DMIT-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-FQ',  'MAT-DMIT-ESO2', '1ª Evaluación', 6.50); -- Bien
