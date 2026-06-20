-- CASO DE ESTUDIO 69: BRUNO IGLESIAS GÓMEZ (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_69_control_bruno.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Pedro Iglesias Varela y María Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP069', 'Pedro Iglesias Varela', 'María Gómez Rey', '600690011', '600690022', 'pedro.iglesias.v@email.com', 'maria.gomez.rey3@email.com', 'Rúa Orillamar 122, N/A, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP069', '2024-09-09', 27000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP069', '2025-09-12', 27500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016069', '78901258K', 'Bruno Iglesias Gómez', '2013-09-18', 'bruno.iglesias.g@alumno.com', 'RESP069');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016069', '2024-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2016069', '2025-07-03', 1, 'ESO-GEN', 'I006'); -- IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-BRUN3-PRI6', '2024-09-02', '2024/2025', 'EXP2016069', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-BRUN3-ESO1', '2025-09-01', '2025/2026', 'EXP2016069', 'I006', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento medio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-BRUN3-PRI6', false), ('PRI6-MAT', 'MAT-BRUN3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-BRUN3-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-BRUN3-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-BRUN3-ESO1', false), ('ESO1-MAT', 'MAT-BRUN3-ESO1', false), ('ESO1-ING', 'MAT-BRUN3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-BRUN3-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-MAT', 'MAT-BRUN3-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-ING', 'MAT-BRUN3-ESO1', '1ª Evaluación', 6.25); -- Aprobado regular
