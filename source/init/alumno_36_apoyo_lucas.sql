-- CASO DE ESTUDIO 36: LUCAS VARELA CASTRO (ALUMNO DE RIESGO - ABANDONO ESCOLAR TEMPRANO EN FP GRADO MEDIO)
-- Archivo: alumno_36_apoyo_lucas.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Varela Méndez y Marta Castro Teijeiro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP036', 'Carlos Varela Méndez', 'Marta Castro Teijeiro', '600360011', '600360022', 'carlos.varela.t@email.com', 'marta.castro.t@email.com', 'Rúa Alfredo Vicenti 18, 5º A, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan shock económico familiar en el paso a ESO y brecha digital severa)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP036', '2019-09-10', 32000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP036', '2021-09-12', 14000.00, false, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO (caída brusca y pérdida de internet)

-- 3. Expediente del Estudiante (Nacido en 2008 para estar en edad de FP Grado Medio)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015036', '12341234Q', 'Lucas Varela Castro', '2008-07-12', 'lucas.varela@alumno.com', 'RESP036');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015036', '2019-06-15', 6, 'PRI-GEN', 'C002'), -- CEIP María Pita
('EXP2015036', '2020-07-03', 1, 'ESO-GEN', 'I001'), -- IES Eusebio da Guarda (ESO Ordinaria)
('EXP2015036', '2023-06-20', 3, 'ESO-DIV', 'I003'), -- IES Agra do Orzán (Derivación a Diversificación por fracaso)
('EXP2015036', '2025-06-25', 1, 'FPM-SMR', 'I003'); -- IES Agra do Orzán (Admisión FP Grado Medio SMR)

-- 5. Historial Longitudinal de Matrículas Anuales (Fallo en ordinaria, rescate en Diversificación y deserción en FP)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-LUCA-PRI6', '2019-09-01', '2019/2020', 'EXP2015036', 'C002', 6, 'PRI-GEN'),
-- Educación Secundaria Ordinaria
('MAT-LUCA-ESO1', '2020-09-02', '2020/2021', 'EXP2015036', 'I001', 1, 'ESO-GEN'),
('MAT-LUCA-ESO2', '2021-09-01', '2021/2022', 'EXP2015036', 'I001', 2, 'ESO-GEN'), -- Repite 2º ESO por shock económico y absentismo
('MAT-LUCA-ESO2R','2022-09-01', '2022/2023', 'EXP2015036', 'I001', 2, 'ESO-GEN'),
-- ESO Diversificación Curricular (IES Agra do Orzán)
('MAT-LUCA-ESOD3','2023-09-01', '2023/2024', 'EXP2015036', 'I003', 3, 'ESO-DIV'),
('MAT-LUCA-ESOD4','2024-09-02', '2024/2025', 'EXP2015036', 'I003', 4, 'ESO-DIV'), -- Gradúa a los 17 años
-- FP Grado Medio SMR (IES Agra do Orzán - Abandono y Deserción)
('MAT-LUCA-SMR1', '2025-09-01', '2025/2026', 'EXP2015036', 'I003', 1, 'FPM-SMR'); -- 1º Grado Medio (Curso actual / Abandono)

-- 6. Historial de Calificaciones
-- A. 4º ESO DIVERSIFICACIÓN (2024/2025 - Graduación con rendimiento aceptable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOD4-ACT', 'MAT-LUCA-ESOD4', false), ('ESOD4-ALS', 'MAT-LUCA-ESOD4', false), ('ESOD4-ING', 'MAT-LUCA-ESOD4', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOD4-ACT', 'MAT-LUCA-ESOD4', 'Final Ordinaria', 6.00),
('ESOD4-ALS', 'MAT-LUCA-ESOD4', 'Final Ordinaria', 6.50),
('ESOD4-ING', 'MAT-LUCA-ESOD4', 'Final Ordinaria', 5.50);

-- B. 1º FP GRADO MEDIO SMR - CURSO ACTUAL (2025/2026 - Desmotivación y baja por inasistencia el 20/11/2025)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('FPM-SMR-SO', 'MAT-LUCA-SMR1', false), ('FPM-SMR-MON', 'MAT-LUCA-SMR1', false), ('FPM-SMR-RED', 'MAT-LUCA-SMR1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('FPM-SMR-SO',  'MAT-LUCA-SMR1', '1ª Evaluación', 2.00), -- Suspenso por absentismo
('FPM-SMR-MON', 'MAT-LUCA-SMR1', '1ª Evaluación', 2.50), -- Suspenso
('FPM-SMR-RED', 'MAT-LUCA-SMR1', '1ª Evaluación', 1.00); -- Suspenso
