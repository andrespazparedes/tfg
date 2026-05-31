-- CASO DE ESTUDIO 65: LUCÍA BLANCO GÓMEZ (ALUMNA DE CONTROL / RENDIMIENTO EXCELENTE)
-- Archivo: alumno_65_control_lucia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Adrián Blanco Varela y Paula Gómez Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP065', 'Adrián Blanco Varela', 'Paula Gómez Castro', '600650011', '600650022', 'adrian.blanco.v2@email.com', 'paula.gomez.c2@email.com', 'Rúa Orillamar 150, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-alta)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP065', '2023-09-10', 33000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP065', '2025-09-12', 33500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015065', '78901254E', 'Lucía Blanco Gómez', '2012-10-14', 'lucia.blanco@alumno.com', 'RESP065');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015065', '2023-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2015065', '2024-07-04', 1, 'ESO-GEN', 'I006'); -- IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LUCI3-PRI6', '2023-09-01', '2023/2024', 'EXP2015065', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-LUCI3-ESO1', '2024-09-02', '2024/2025', 'EXP2015065', 'I006', 1, 'ESO-GEN'),
('MAT-LUCI3-ESO2', '2025-09-01', '2025/2026', 'EXP2015065', 'I006', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Excelente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LUCI3-PRI6', false), ('PRI6-MAT', 'MAT-LUCI3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LUCI3-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'MAT-LUCI3-PRI6', 'Final Ordinaria', 9.00);

-- B. 1º ESO (2024/2025 - Excelente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-LUCI3-ESO1', false), ('ESO1-MAT', 'MAT-LUCI3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-LUCI3-ESO1', 'Final Ordinaria', 9.00),
('ESO1-MAT', 'MAT-LUCI3-ESO1', 'Final Ordinaria', 9.25);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-LUCI3-ESO2', false), ('ESO2-MAT', 'MAT-LUCI3-ESO2', false), ('ESO2-FQ', 'MAT-LUCI3-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-LUCI3-ESO2', '1ª Evaluación', 9.00), -- Sobresaliente
('ESO2-MAT', 'MAT-LUCI3-ESO2', '1ª Evaluación', 9.50), -- Sobresaliente
('ESO2-FQ',  'MAT-LUCI3-ESO2', '1ª Evaluación', 9.00); -- Sobresaliente
