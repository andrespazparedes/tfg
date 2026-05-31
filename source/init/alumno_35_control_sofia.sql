-- CASO DE ESTUDIO 35: SOFÍA SEOANE OTERO (ALUMNA DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_35_control_sofia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Seoane Fraga y Laura Otero Díaz)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP035', 'Carlos Seoane Fraga', 'Laura Otero Díaz', '600350011', '600350022', 'carlos.seoane.o@email.com', 'laura.otero.d@email.com', 'Rúa Alfredo Vicenti 18, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-baja y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP035', '2023-09-10', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP035', '2025-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015035', '12341234P', 'Sofía Seoane Otero', '2012-07-22', 'sofia.seoane@alumno.com', 'RESP035');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015035', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015035', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SOFI2-PRI6', '2023-09-01', '2023/2024', 'EXP2015035', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SOFI2-ESO1', '2024-09-02', '2024/2025', 'EXP2015035', 'I002',     1, 'ESO-GEN'),
('MAT-SOFI2-ESO2', '2025-09-01', '2025/2026', 'EXP2015035', 'I002',     2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SOFI2-PRI6', false), ('PRI6-MAT', 'MAT-SOFI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SOFI2-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-SOFI2-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SOFI2-ESO1', false), ('ESO1-MAT', 'MAT-SOFI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SOFI2-ESO1', 'Final Ordinaria', 6.50),
('ESO1-MAT', 'MAT-SOFI2-ESO1', 'Final Ordinaria', 6.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-SOFI2-ESO2', false), ('ESO2-MAT', 'MAT-SOFI2-ESO2', false), ('ESO2-FQ', 'MAT-SOFI2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-SOFI2-ESO2', '1ª Evaluación', 6.50), -- Bien
('ESO2-MAT', 'MAT-SOFI2-ESO2', '1ª Evaluación', 6.00), -- Bien
('ESO2-FQ',  'MAT-SOFI2-ESO2', '1ª Evaluación', 6.00); -- Bien
