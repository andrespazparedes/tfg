-- CASO DE ESTUDIO 49: BRUNO CASTRO OTERO (ALUMNO DE CONTROL / RENDIMIENTO NOTABLE)
-- Archivo: alumno_49_control_bruno.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Pedro Castro Varela y María Otero Blanco)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP049', 'Pedro Castro Varela', 'María Otero Blanco', '600490011', '600490022', 'pedro.castro@email.com', 'maria.otero@email.com', 'Rúa Orillamar 60, 3º A, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP049', '2023-09-09', 27000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP049', '2025-09-12', 27500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015049', '78901245V', 'Bruno Castro Otero', '2012-09-18', 'bruno.castro@alumno.com', 'RESP049');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015049', '2023-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2015049', '2024-07-03', 1, 'ESO-GEN', 'I006'); -- IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('M49-PRI6', '2023-09-01', '2023/2024', 'EXP2015049', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('M49-ESO1', '2024-09-02', '2024/2025', 'EXP2015049', 'I006', 1, 'ESO-GEN'),
('M49-ESO2', '2025-09-01', '2025/2026', 'EXP2015049', 'I006', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'M49-PRI6', false), ('PRI6-MAT', 'M49-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'M49-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'M49-PRI6', 'Final Ordinaria', 7.00);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'M49-ESO1', false), ('ESO1-MAT', 'M49-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'M49-ESO1', 'Final Ordinaria', 7.50),
('ESO1-MAT', 'M49-ESO1', 'Final Ordinaria', 7.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'M49-ESO2', false), ('ESO2-MAT', 'M49-ESO2', false), ('ESO2-FQ', 'M49-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'M49-ESO2', '1ª Evaluación', 7.50), -- Notable
('ESO2-MAT', 'M49-ESO2', '1ª Evaluación', 7.00), -- Notable
('ESO2-FQ',  'M49-ESO2', '1ª Evaluación', 7.50); -- Notable
