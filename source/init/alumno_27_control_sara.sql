-- CASO DE ESTUDIO 27: SARA VEIGA MÉNDEZ (ALUMNA DE CONTROL / RENDIMIENTO NOTABLE)
-- Archivo: alumno_27_control_sara.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Gabriel Veiga Gómez y Carmen Méndez Souto)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP027', 'Gabriel Veiga Gómez', 'Carmen Méndez Souto', '600270011', '600270022', 'gabriel.veiga@email.com', 'carmen.mendez@email.com', 'Rúa Alfredo Vicenti 12, 3º Izq, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP027', '2023-09-10', 31500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP027', '2025-09-12', 31000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015027', '12341234G', 'Sara Veiga Méndez', '2012-10-18', 'sara.veiga@alumno.com', 'RESP027');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015027', '2023-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2015027', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SARA27-PRI6', '2023-09-01', '2023/2024', 'EXP2015027', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SARA27-ESO1', '2024-09-02', '2024/2025', 'EXP2015027', 'I001', 1, 'ESO-GEN'),
('MAT-SARA27-ESO2', '2025-09-01', '2025/2026', 'EXP2015027', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SARA27-PRI6', false), ('PRI6-MAT', 'MAT-SARA27-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SARA27-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-SARA27-PRI6', 'Final Ordinaria', 7.50);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SARA27-ESO1', false), ('ESO1-MAT', 'MAT-SARA27-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SARA27-ESO1', 'Final Ordinaria', 7.50),
('ESO1-MAT', 'MAT-SARA27-ESO1', 'Final Ordinaria', 7.50);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-SARA27-ESO2', false), ('ESO2-MAT', 'MAT-SARA27-ESO2', false), ('ESO2-FQ', 'MAT-SARA27-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-SARA27-ESO2', '1ª Evaluación', 8.00), -- Notable alto
('ESO2-MAT', 'MAT-SARA27-ESO2', '1ª Evaluación', 7.50), -- Notable
('ESO2-FQ',  'MAT-SARA27-ESO2', '1ª Evaluación', 7.50); -- Notable
