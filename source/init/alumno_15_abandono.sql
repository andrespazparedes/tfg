-- CASO DE ESTUDIO 15: RUBÉN PINTOS BLANCO (ABANDONO ESCOLAR TEMPRANO - FRACASO TERMINAL)
-- Archivo: alumno_15_abandono.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Santiago Pintos Varela e Isabel Blanco Veiga)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP015', 'Santiago Pintos Varela', 'Isabel Blanco Veiga', '600150011', NULL, 'santiago.pintos@email.com', NULL, 'Rúa Vila de Negreira 42, Bajo, CP 15010, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan pobreza severa y nula conectividad/equipamiento digital en el hogar)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP015', '2018-09-10', 11000.00, false, 'Estudios Primarios', 'Estudios Primarios', 0, 3), -- Encuesta en 4º Primaria (Primer Intento)
('RESP015', '2025-09-12', 10500.00, false, 'Estudios Primarios', 'Estudios Primarios', 0, 3); -- Encuesta en 2º ESO (Segundo Intento / Actual)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2010015', '22334455L', 'Rubén Pintos Blanco', '2009-10-14', 'ruben.pintos@alumno.com', 'RESP015');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2010015', '2018-06-15', 4, 'PRI-GEN', 'C001'), -- Admitido en 4º Primaria en CEIP Emilia Pardo Bazán
('EXP2010015', '2022-07-02', 1, 'ESO-GEN', 'I003'); -- Admitido en 1º ESO en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales (Doble repetición y colapso por desfase de edad)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Emilia Pardo Bazán)
('MAT-RUBE-PRI4-1', '2018-09-03', '2018/2019', 'EXP2010015', 'C001', 4, 'PRI-GEN'), -- 4º Primaria (1er Intento - Repite)
('MAT-RUBE-PRI4-2', '2019-09-02', '2019/2020', 'EXP2010015', 'C001', 4, 'PRI-GEN'), -- 4º Primaria (Repetición)
('MAT-RUBE-PRI6',   '2021-09-01', '2021/2022', 'EXP2010015', 'C001', 6, 'PRI-GEN'), -- 6º Primaria (Cierre de etapa)
-- Educación Secundaria - ESO (IES Agra do Orzán)
('MAT-RUBE-ESO1-1', '2022-09-01', '2022/2023', 'EXP2010015', 'I003',     1, 'ESO-GEN'), -- 1º ESO (1er Intento - Repite)
('MAT-RUBE-ESO1-2', '2023-09-01', '2023/2024', 'EXP2010015', 'I003',     1, 'ESO-GEN'), -- 1º ESO (Repetición - Pasa con Matemáticas pendiente)
('MAT-RUBE-ESO2-1', '2024-09-02', '2024/2025', 'EXP2010015', 'I003',     2, 'ESO-GEN'), -- 2º ESO (1er Intento - Repite)
('MAT-RUBE-ESO2-2', '2025-09-01', '2025/2026', 'EXP2010015', 'I003',     2, 'ESO-GEN'); -- 2º ESO (Repetición - Curso actual / Abandono)

-- 6. Adaptación Curricular / Intervención de Absentismo (Protocolo de absentismo terminal con fracaso y baja del sistema)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP015', '2025-10-18', 'Absentismo - Comisión Intervención Terminal', 'Se abre expediente por absentismo escolar crónico no justificado (35%). El alumno de 16 años cumplidos muestra desafección absoluta del sistema educativo por desfase de edad y repeticiones. Se tramita la baja voluntaria formal del sistema al cumplir la edad legal de salida.', 'EXP2010015');

-- Vinculamos la intervención con las materias instrumentales donde acumula el fracaso
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP015', 'ESO2-MAT'),
('ADAP015', 'ESO2-LCL');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2021/2022 - Aprobado muy justo raspado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-RUBE-PRI6', false), 
('PRI6-MAT', 'MAT-RUBE-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-RUBE-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-RUBE-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO - Repetición (2023/2024 - Pasa con Matemáticas pendiente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-RUBE-ESO1-2', false), 
('ESO1-MAT', 'MAT-RUBE-ESO1-2', true); -- Arrastra matemáticas

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-RUBE-ESO1-2', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-RUBE-ESO1-2', 'Final Ordinaria', 4.00); -- Sigue suspensa en junio

-- C. 2º ESO - 1er Intento (2024/2025 - Fracaso total y repetición)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-RUBE-ESO2-1', false), 
('ESO2-MAT', 'MAT-RUBE-ESO2-1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-RUBE-ESO2-1', 'Final Ordinaria', 3.50),
('ESO2-MAT', 'MAT-RUBE-ESO2-1', 'Final Ordinaria', 3.00);

-- D. 2º ESO - CURSO ACTUAL (2025/2026 - Colapso terminal por inasistencia y abandono definitivo en 1ª Ev)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-RUBE-ESO2-2', false),
('ESO2-MAT', 'MAT-RUBE-ESO2-2', false),
('ESO2-FQ',  'MAT-RUBE-ESO2-2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-RUBE-ESO2-2', '1ª Evaluación', 2.00), -- Suspenso por nula asistencia
('ESO2-MAT', 'MAT-RUBE-ESO2-2', '1ª Evaluación', 1.50), -- Suspenso por nula asistencia
('ESO2-FQ',  'MAT-RUBE-ESO2-2', '1ª Evaluación', 2.00); -- Suspenso por nula asistencia
