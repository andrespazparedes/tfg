-- CASO DE ESTUDIO 34: ADRIÁN ROMERO GÓMEZ (ALUMNO CON TDAH / APOYO METODOLÓGICO ACTIVO)
-- Archivo: alumno_34_apoyo_adrian.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Manuel Romero Vázquez e Irene Gómez Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP034', 'Manuel Romero Vázquez', 'Irene Gómez Castro', '600340011', '600340022', 'manuel.romero.g@email.com', 'irene.gomez.c@email.com', 'Rúa Barcelona 14, 1º Izq, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP034', '2023-09-10', 26500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP034', '2025-09-12', 26000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016034', '12341234N', 'Adrián Romero Gómez', '2013-09-14', 'adrian.romero@alumno.com', 'RESP034');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016034', '2023-06-15', 5, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2016034', '2025-07-04', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ADRI3-PRI5', '2023-09-01', '2023/2024', 'EXP2016034', 'C004', 5, 'PRI-GEN'),
('MAT-ADRI3-PRI6', '2024-09-02', '2024/2025', 'EXP2016034', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ADRI3-ESO1', '2025-09-01', '2025/2026', 'EXP2016034', 'I002',     1, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Apoyo TDAH (Activada en 5º de Primaria por déficit de atención)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP034', '2023-10-10', 'Apoyo Educativo - TDAH Metodológico', 'Estudiante diagnosticado con TDAH. Presenta problemas de concentración y fatiga en exámenes largos. Se prescribe Adaptación Metodológica de Acceso: exámenes segmentados, más tiempo (+30%) y recordatorios constantes de tareas.', 'EXP2016034');

-- Relacionamos la adaptación con las asignaturas instrumentales troncales adaptadas en 1º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP034', 'ESO1-LCL'),
('ADAP034', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-ADRI3-PRI5', false), ('PRI5-MAT', 'MAT-ADRI3-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-ADRI3-PRI5', 'Final Ordinaria', 7.00),
('PRI5-MAT', 'MAT-ADRI3-PRI5', 'Final Ordinaria', 7.50);

-- B. 6º PRIMARIA (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ADRI3-PRI6', false), ('PRI6-MAT', 'MAT-ADRI3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ADRI3-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-ADRI3-PRI6', 'Final Ordinaria', 7.00);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ADRI3-ESO1', false), ('ESO1-MAT', 'MAT-ADRI3-ESO1', false), ('ESO1-GH', 'MAT-ADRI3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ADRI3-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-MAT', 'MAT-ADRI3-ESO1', '1ª Evaluación', 7.50), -- Notable alto
('ESO1-GH',  'MAT-ADRI3-ESO1', '1ª Evaluación', 7.00); -- Notable
