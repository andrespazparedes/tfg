-- CASO DE ESTUDIO 4: MATEO BARCIA OTERO (ALUMNO EN GRADO BÁSICO / FP BÁSICA)
-- Archivo: alumno_4_gradobasico.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Rosa Otero Díaz y Javier Barcia Gil)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP004', 'Rosa Otero Díaz', 'Javier Barcia Gil', '633111222', '633222333', 'rosa.otero@email.com', 'javier.barcia@email.com', 'Rúa Labañou 12, 1º Izq, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos, entorno obrero vulnerable)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP004', '2021-09-12', 14000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4), -- Encuesta en Primaria (1 ordenador compartido)
('RESP004', '2025-09-12', 13200.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4); -- Encuesta en ESO (caída de ingresos)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016004', '11223344D', 'Mateo Barcia Otero', '2012-05-20', 'mateo.barcia@alumno.com', 'RESP004');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016004', '2021-06-15', 5, 'PRI-GEN', 'C004'), -- Admitido en 5º de Primaria en CEIP Alborada
('EXP2016004', '2023-07-04', 1, 'ESO-GEN', 'I002'); -- Admitido en 1º de ESO en IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales (Absentismo, repetición de 1º ESO, arrastre en 2º y paso a Grado Básico)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Alborada)
('MAT-MATE-PRI5',  '2021-09-01', '2021/2022', 'EXP2016004', 'C004', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-MATE-PRI6',  '2022-09-01', '2022/2023', 'EXP2016004', 'C004', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Fernando Wirtz Suárez)
('MAT-MATE-ESO1',  '2023-09-01', '2023/2024', 'EXP2016004', 'I002',     1, 'ESO-GEN'), -- 1º ESO (1er intento - Fracaso/Repite)
('MAT-MATE-ESO2',  '2024-09-01', '2024/2025', 'EXP2016004', 'I002',     2, 'ESO-GEN'), -- 2º ESO (Fracaso severo, redirigido a Grado Básico)
('MAT-MATE-ESOGB1', '2025-09-01', '2025/2026', 'EXP2016004', 'I002', 3, 'ESO-GB'); -- 1º Grado Básico (Equivalente a 3º ESO - Curso Actual)

-- 6. Adaptación Curricular (Registrada en 5º de Primaria por TDAH y dificultades de conducta)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP004', '2021-10-10', 'Apoyo Educativo / Conducta', 'El estudiante presenta sintomatología compatible con TDAH. Requiere pautas específicas de conducta, estructuración de tareas y refuerzo en áreas instrumentales.', 'EXP2016004');

INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP004', 'PRI5-MAT'),
('ADAP004', 'PRI5-LCL');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2021/2022 - Aprobado muy justo con adaptación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-MATE-PRI5', false), ('PRI5-MAT', 'MAT-MATE-PRI5', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-MATE-PRI5', 'Final Ordinaria', 5.00),
('PRI5-MAT', 'MAT-MATE-PRI5', 'Final Ordinaria', 5.00);

-- B. 6º PRIMARIA (2022/2023 - Aprobado raspado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MATE-PRI6', false), ('PRI6-MAT', 'MAT-MATE-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MATE-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-MATE-PRI6', 'Final Ordinaria', 5.00);

-- C. 1º ESO (2023/2024 - Fracaso escolar severo en la vía ordinaria)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MATE-ESO1', false), ('ESO1-MAT', 'MAT-MATE-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MATE-ESO1', 'Final Ordinaria', 4.00), -- Suspenso
('ESO1-MAT', 'MAT-MATE-ESO1', 'Final Ordinaria', 3.00); -- Suspenso

-- D. 2º ESO (2024/2025 - Continúa el fracaso masivo en ordinaria, deriva a Grado Básico)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-MATE-ESO2', false), ('ESO2-MAT', 'MAT-MATE-ESO2', false), ('ESO2-FQ', 'MAT-MATE-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-MATE-ESO2', 'Final Ordinaria', 4.00), -- Suspenso
('ESO2-MAT', 'MAT-MATE-ESO2', 'Final Ordinaria', 3.00), -- Suspenso
('ESO2-FQ',  'MAT-MATE-ESO2', 'Final Ordinaria', 3.50); -- Suspenso

-- E. 1º GRADO BÁSICO - CURSO ACTUAL (2025/2026 - Excelente adaptación al enfoque práctico)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOGB1-ACT', 'MAT-MATE-ESOGB1', false), ('ESOGB1-ALS', 'MAT-MATE-ESOGB1', false), ('ESOGB1-PRAC', 'MAT-MATE-ESOGB1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOGB1-ACT', 'MAT-MATE-ESOGB1', '1ª Evaluación', 5.50), -- Aprobado en Ciencias Aplicadas
('ESOGB1-ALS', 'MAT-MATE-ESOGB1', '1ª Evaluación', 6.00), -- Aprobado en Comunicación/Sociales
('ESOGB1-PRAC', 'MAT-MATE-ESOGB1', '1ª Evaluación', 8.00); -- Notable alto en el Taller Práctico Profesional
