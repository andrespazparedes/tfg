-- CASO DE ESTUDIO 51: JULIA ROMERO BLANCO (ALUMNA DE CONTROL / RENDIMIENTO NOTABLE ESTABLE)
-- Archivo: alumno_51_control_julia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Manuel Romero Otero y Laura Blanco Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP051', 'Manuel Romero Otero', 'Laura Blanco Rey', '600510011', '600510022', 'manuel.romero.o@email.com', 'laura.blanco.r@email.com', 'Rúa Santo Tomás 12, 3º Izq, CP 15002, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP051', '2023-09-10', 26500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP051', '2025-09-12', 27000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015051', '78901247X', 'Julia Romero Blanco', '2012-05-18', 'julia.romero.b@alumno.com', 'RESP051');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015051', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015051', '2024-07-03', 1, 'ESO-GEN', 'I005'); -- IES Adormideras

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-JULI2-PRI6', '2023-09-01', '2023/2024', 'EXP2015051', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-JULI2-ESO1', '2024-09-02', '2024/2025', 'EXP2015051', 'I005', 1, 'ESO-GEN'),
('MAT-JULI2-ESO2', '2025-09-01', '2025/2026', 'EXP2015051', 'I005', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-JULI2-PRI6', false), ('PRI6-MAT', 'MAT-JULI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-JULI2-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-JULI2-PRI6', 'Final Ordinaria', 7.00);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-JULI2-ESO1', false), ('ESO1-MAT', 'MAT-JULI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-JULI2-ESO1', 'Final Ordinaria', 7.50),
('ESO1-MAT', 'MAT-JULI2-ESO1', 'Final Ordinaria', 7.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-JULI2-ESO2', false), ('ESO2-MAT', 'MAT-JULI2-ESO2', false), ('ESO2-FQ', 'MAT-JULI2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-JULI2-ESO2', '1ª Evaluación', 7.50), -- Notable
('ESO2-MAT', 'MAT-JULI2-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-FQ',  'MAT-JULI2-ESO2', '1ª Evaluación', 7.25); -- Notable
