-- CASO DE ESTUDIO 43: MARTÍN SEOANE BLANCO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_43_control_martin.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Seoane Castro e Irene Blanco Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP043', 'Marcos Seoane Castro', 'Irene Blanco Rey', '600430011', '600430022', 'marcos.seoane@email.com', 'irene.blanco@email.com', 'Rúa Orillamar 12, 1º B, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP043', '2023-09-09', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP043', '2025-09-12', 25500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015043', '78901239N', 'Martín Seoane Blanco', '2012-12-14', 'martin43.seoane@alumno.com', 'RESP043');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015043', '2023-06-15', 6, 'PRI-GEN', 'C002'), -- CEIP María Pita
('EXP2015043', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MART-PRI6', '2023-09-01', '2023/2024', 'EXP2015043', 'C002', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MART-ESO1', '2024-09-02', '2024/2025', 'EXP2015043', 'I001', 1, 'ESO-GEN'),
('MAT-MART-ESO2', '2025-09-01', '2025/2026', 'EXP2015043', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MART-PRI6', false), ('PRI6-MAT', 'MAT-MART-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MART-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-MART-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MART-ESO1', false), ('ESO1-MAT', 'MAT-MART-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MART-ESO1', 'Final Ordinaria', 6.00),
('ESO1-MAT', 'MAT-MART-ESO1', 'Final Ordinaria', 6.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MART-ESO2', false), ('ESO2-MAT', 'MAT-MART-ESO2', false), ('ESO2-FQ', 'MAT-MART-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MART-ESO2', '1ª Evaluación', 6.00), -- Bien
('ESO2-MAT', 'MAT-MART-ESO2', '1ª Evaluación', 6.25), -- Bien
('ESO2-FQ',  'MAT-MART-ESO2', '1ª Evaluación', 6.00); -- Bien
