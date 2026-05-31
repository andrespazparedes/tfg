-- CASO DE ESTUDIO 62: HUGO BLANCO GÓMEZ (ALUMNO CON TRASTORNO NEGATIVISTA DESAFIANTE / INTERVENCIONES CONDUCTUALES / RIESGO ALTO)
-- Archivo: alumno_62_apoyo_hugo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Blanco Otero y Laura Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP062', 'Marcos Blanco Otero', 'Laura Gómez Rey', '600620011', '600620022', 'marcos.blanco.ot@email.com', 'laura.gomez.re2@email.com', 'Rúa Villa de Negreira 44, 2º B, CP 15010, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Hogar de bajos recursos y estrés sociofamiliar)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP062', '2023-09-10', 13000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4), -- Encuesta en Primaria
('RESP062', '2025-09-12', 12500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015062', '78901251B', 'Hugo Blanco Gómez', '2012-07-22', 'hugo.blanco.g@alumno.com', 'RESP062');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015062', '2023-06-15', 6, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2015062', '2024-07-04', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-HUGO2-PRI6', '2023-09-01', '2023/2024', 'EXP2015062', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-HUGO2-ESO1', '2024-09-02', '2024/2025', 'EXP2015062', 'I003', 1, 'ESO-GEN'),
('MAT-HUGO2-ESO2', '2025-09-01', '2025/2026', 'EXP2015062', 'I003', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Trastorno de Conducta - TND (Activada en 1º ESO por extremada conflictividad en el aula)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP062', '2024-10-15', 'Apoyo Educativo - Trastorno Negativista Desafiante (TND)', 'Estudiante diagnosticado con Trastorno Negativista Desafiante (TND). Presenta baja tolerancia a la frustración, respuestas oposicionistas sistemáticas ante la autoridad y constantes amonestaciones de aula. Se prescribe Adaptación de Conducta: contrato diario de puntos, segmentación de tareas y mediación activa con el orientador.', 'EXP2015062');

-- Relacionamos la adaptación conductual con Matemáticas y Lengua Castellana
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP062', 'ESO2-LCL'),
('ADAP062', 'ESO2-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-HUGO2-PRI6', false), ('PRI6-MAT', 'MAT-HUGO2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-HUGO2-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-HUGO2-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2024/2025 - Gran inestabilidad con múltiples partes y notas bajas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-HUGO2-ESO1', false), ('ESO1-MAT', 'MAT-HUGO2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-HUGO2-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-HUGO2-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Aprobado muy justo por la mínima)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-HUGO2-ESO2', false), ('ESO2-MAT', 'MAT-HUGO2-ESO2', false), ('ESO2-FQ', 'MAT-HUGO2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-HUGO2-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-MAT', 'MAT-HUGO2-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-FQ',  'MAT-HUGO2-ESO2', '1ª Evaluación', 5.00); -- Aprobado raspado
