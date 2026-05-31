-- CASO DE ESTUDIO 40: CLARA ROMERO VARELA (ALUMNA DE CONTROL / RENDIMIENTO ALTO-EXCELENTE)
-- Archivo: alumno_40_control_clara.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Romero Otero y Laura Varela Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP040', 'Sergio Romero Otero', 'Laura Varela Rey', '600400011', '600400022', 'sergio.romero@email.com', 'laura.varela@email.com', 'Rúa Real 12, 4º Izq, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan alto nivel socioeconómico)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP040', '2023-09-09', 37000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3), -- Encuesta en Primaria
('RESP040', '2025-09-12', 38000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015040', '78901236K', 'Clara Romero Varela', '2012-05-15', 'clara.romero@alumno.com', 'RESP040');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015040', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015040', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-CLAR-PRI6', '2023-09-01', '2023/2024', 'EXP2015040', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-CLAR-ESO1', '2024-09-02', '2024/2025', 'EXP2015040', 'I001', 1, 'ESO-GEN'),
('MAT-CLAR-ESO2', '2025-09-01', '2025/2026', 'EXP2015040', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento sobresaliente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-CLAR-PRI6', false), ('PRI6-MAT', 'MAT-CLAR-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-CLAR-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'MAT-CLAR-PRI6', 'Final Ordinaria', 9.50);

-- B. 1º ESO (2024/2025 - Rendimiento sobresaliente continuo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-CLAR-ESO1', false), ('ESO1-MAT', 'MAT-CLAR-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-CLAR-ESO1', 'Final Ordinaria', 9.00),
('ESO1-MAT', 'MAT-CLAR-ESO1', 'Final Ordinaria', 9.25);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-CLAR-ESO2', false), ('ESO2-MAT', 'MAT-CLAR-ESO2', false), ('ESO2-FQ', 'MAT-CLAR-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-CLAR-ESO2', '1ª Evaluación', 9.25), -- Sobresaliente
('ESO2-MAT', 'MAT-CLAR-ESO2', '1ª Evaluación', 9.50), -- Sobresaliente
('ESO2-FQ',  'MAT-CLAR-ESO2', '1ª Evaluación', 9.00); -- Sobresaliente
