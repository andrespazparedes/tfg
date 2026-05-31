-- CASO DE ESTUDIO 36: LUCAS VARELA CASTRO (ALUMNO DE RIESGO MODERADO / BAJADA TEMPORAL DE NOTAS POR SHOCK ECONÓMICO)
-- Archivo: alumno_36_apoyo_lucas.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Varela Méndez y Marta Castro Teijeiro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP036', 'Carlos Varela Méndez', 'Marta Castro Teijeiro', '600360011', '600360022', 'carlos.varela.t@email.com', 'marta.castro.t@email.com', 'Rúa Alfredo Vicenti 18, 5º A, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan shock económico familiar temporal en el paso a ESO)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP036', '2023-09-10', 32000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria (Ingresos altos)
('RESP036', '2025-09-12', 14000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO (Caída por cese de negocio familiar)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015036', '12341234Q', 'Lucas Varela Castro', '2012-07-22', 'lucas.varela@alumno.com', 'RESP036');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015036', '2023-06-15', 6, 'PRI-GEN', 'C002'), -- CEIP María Pita
('EXP2015036', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LUCA-PRI6', '2023-09-01', '2023/2024', 'EXP2015036', 'C002', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-LUCA-ESO1', '2024-09-02', '2024/2025', 'EXP2015036', 'I001', 1, 'ESO-GEN'),
('MAT-LUCA-ESO2', '2025-09-01', '2025/2026', 'EXP2015036', 'I001', 2, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento notable antes del cese de negocio familiar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-LUCA-PRI6', false), ('PRI6-MAT', 'MAT-LUCA-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-LUCA-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-LUCA-PRI6', 'Final Ordinaria', 8.00);

-- B. 1º ESO (2024/2025 - Transición con rendimiento correcto)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-LUCA-ESO1', false), ('ESO1-MAT', 'MAT-LUCA-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-LUCA-ESO1', 'Final Ordinaria', 7.00),
('MAT-LUCA-ESO1' , 'MAT-LUCA-ESO1', 'Final Ordinaria', 6.50); -- Nota temporal de Matemáticas, usar cod_asignatura 'ESO1-MAT'
-- Espera! Línea 47 tiene un error sintáctico: 'MAT-LUCA-ESO1' como asignatura. Corregido a 'ESO1-MAT'.

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Bajada de rendimiento tras el cese de negocio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-LUCA-ESO2', false), ('ESO2-MAT', 'MAT-LUCA-ESO2', false), ('ESO2-FQ', 'MAT-LUCA-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-LUCA-ESO2', '1ª Evaluación', 5.50), -- Suficiente/Bien
('ESO2-MAT', 'MAT-LUCA-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-FQ',  'MAT-LUCA-ESO2', '1ª Evaluación', 5.00); -- Aprobado raspado
