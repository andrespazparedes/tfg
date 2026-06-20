-- CASO DE ESTUDIO 4: MATEO BARCIA OTERO (ALUMNO DE APOYO - ÉXITO DE GRADO BÁSICO A FP GRADO MEDIO)
-- Archivo: alumno_4_gradobasico.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Rosa Otero Díaz y Javier Barcia Gil)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP004', 'Rosa Otero Díaz', 'Javier Barcia Gil', '633111222', '633222333', 'rosa.otero@email.com', 'javier.barcia@email.com', 'Rúa Labañou 12, 1º Izq, CP 15011, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos, entorno obrero vulnerable)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP004', '2019-09-12', 14000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4), -- Encuesta en Primaria
('RESP004', '2021-09-12', 13200.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacido en 2008 para estar en edad de FP Grado Medio)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016004', '11223344D', 'Mateo Barcia Otero', '2008-05-20', 'mateo.barcia@alumno.com', 'RESP004');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016004', '2019-06-15', 5, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2016004', '2021-07-04', 1, 'ESO-GEN', 'I002'), -- IES Fernando Wirtz (ESO Ordinaria)
('EXP2016004', '2023-06-20', 3, 'ESO-GB', 'I002'),  -- IES Fernando Wirtz (Derivación a FP Básica)
('EXP2016004', '2025-06-25', 1, 'FPM-SMR', 'I002'); -- IES Fernando Wirtz (Admisión FP Grado Medio)

-- 5. Historial Longitudinal de Matrículas Anuales (Rescate en Grado Básico e Incorporación a Grado Medio)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Alborada)
('MAT-MATE-PRI5',  '2019-09-01', '2019/2020', 'EXP2016004', 'C004', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-MATE-PRI6',  '2020-09-01', '2020/2021', 'EXP2016004', 'C004', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO Ordinaria (IES Fernando Wirtz)
('MAT-MATE-ESO1',  '2021-09-01', '2021/2022', 'EXP2016004', 'I002', 1, 'ESO-GEN'), -- 1º ESO (Fallo y repetición en el salto)
('MAT-MATE-ESO1R', '2022-09-01', '2022/2023', 'EXP2016004', 'I002', 1, 'ESO-GEN'), -- 1º ESO (Repetición - Aprueba raspado)
-- FP Básica (Grado Básico - IES Fernando Wirtz)
('MAT-MATE-GB1',   '2023-09-01', '2023/2024', 'EXP2016004', 'I002', 3, 'ESO-GB'),  -- 1º Grado Básico (Aprueba motivado)
('MAT-MATE-GB2',   '2024-09-02', '2024/2025', 'EXP2016004', 'I002', 4, 'ESO-GB'),  -- 2º Grado Básico (Titulación obligatoria LOMLOE)
-- FP Grado Medio SMR (IES Fernando Wirtz)
('MAT-MATE-SMR1',  '2025-09-01', '2025/2026', 'EXP2016004', 'I002', 1, 'FPM-SMR'); -- 1º Grado Medio (Curso actual)

-- 6. Adaptación Curricular (Registrada en 5º de Primaria por TDAH y dificultades de conducta)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP004', '2019-10-10', 'Apoyo Educativo / Conducta', 'El estudiante presenta sintomatología compatible con TDAH. Requiere pautas específicas de conducta, estructuración de tareas y refuerzo en áreas instrumentales.', 'EXP2016004');

INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP004', 'PRI5-MAT'),
('ADAP004', 'PRI5-LCL');

-- 7. Historial de Calificaciones
-- A. 2º GRADO BÁSICO (2024/2025 - Titulación con excelente desempeño en prácticas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOGB2-ACT', 'MAT-MATE-GB2', false), ('ESOGB2-ALS', 'MAT-MATE-GB2', false), ('ESOGB2-PRAC', 'MAT-MATE-GB2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOGB2-ACT', 'MAT-MATE-GB2', 'Final Ordinaria', 6.00),
('ESOGB2-ALS', 'MAT-MATE-GB2', 'Final Ordinaria', 5.50),
('ESOGB2-PRAC', 'MAT-MATE-GB2', 'Final Ordinaria', 8.50);

-- B. 1º FP GRADO MEDIO SMR - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('FPM-SMR-SO', 'MAT-MATE-SMR1', false), ('FPM-SMR-MON', 'MAT-MATE-SMR1', false), ('FPM-SMR-RED', 'MAT-MATE-SMR1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('FPM-SMR-SO',  'MAT-MATE-SMR1', '1ª Evaluación', 6.00), -- Aprobado
('FPM-SMR-MON', 'MAT-MATE-SMR1', '1ª Evaluación', 7.50), -- Notable
('FPM-SMR-RED', 'MAT-MATE-SMR1', '1ª Evaluación', 6.00); -- Aprobado
