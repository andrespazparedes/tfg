-- CASO DE ESTUDIO 30: MATEO IGLESIAS VARELA (ALUMNO DE CONTROL / RENDIMIENTO ALTO-EXCELENTE)
-- Archivo: alumno_30_control_mateo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Daniel Iglesias Otero e Irene Varela Sanz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP030', 'Daniel Iglesias Otero', 'Irene Varela Sanz', '600300011', '600300022', 'daniel.iglesias.o@email.com', 'irene.varela.s@email.com', 'Praza de Pontevedra 5, 2º B, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-alta y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP030', '2023-09-10', 36500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP030', '2025-09-12', 36000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015030', '12341234J', 'Mateo Iglesias Varela', '2012-11-20', 'mateo.iglesias@alumno.com', 'RESP030');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015030', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015030', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MATE2-PRI6', '2023-09-01', '2023/2024', 'EXP2015030', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MATE2-ESO1', '2024-09-02', '2024/2025', 'EXP2015030', 'I001', 1, 'ESO-GEN'),
('MAT-MATE2-ESO2', '2025-09-01', '2025/2026', 'EXP2015030', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MATE2-PRI6', false), ('PRI6-MAT', 'MAT-MATE2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MATE2-PRI6', 'Final Ordinaria', 8.50),
('PRI6-MAT', 'MAT-MATE2-PRI6', 'Final Ordinaria', 9.00);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MATE2-ESO1', false), ('ESO1-MAT', 'MAT-MATE2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MATE2-ESO1', 'Final Ordinaria', 8.50),
('ESO1-MAT', 'MAT-MATE2-ESO1', 'Final Ordinaria', 8.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MATE2-ESO2', false), ('ESO2-MAT', 'MAT-MATE2-ESO2', false), ('ESO2-FQ', 'MAT-MATE2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MATE2-ESO2', '1ª Evaluación', 8.50), -- Notable alto
('ESO2-MAT', 'MAT-MATE2-ESO2', '1ª Evaluación', 9.00), -- Sobresaliente
('ESO2-FQ',  'MAT-MATE2-ESO2', '1ª Evaluación', 8.50); -- Notable alto
