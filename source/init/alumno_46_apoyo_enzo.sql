-- CASO DE ESTUDIO 46: ENZO ROMERO VARELA (ALUMNO DE RIESGO ALTO / ABSENTISMO SEVERO / REPETICIÓN CRÓNICA / CONTRATO CONVIVENCIA)
-- Archivo: alumno_46_apoyo_enzo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Sergio Romero Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP046', 'Sergio Romero Gómez', NULL, '600460011', NULL, 'sergio.romero.g@email.com', NULL, 'Rúa Villa de Negreira 10, 4º Izq, CP 15010, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Hogar monoparental de baja renta y brecha digital moderada)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP046', '2022-09-10', 12500.00, true, 'Estudios Primarios', NULL, 1, 3), -- Encuesta en Primaria
('RESP046', '2025-09-12', 12000.00, true, 'Estudios Primarios', NULL, 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2011046', '78901242R', 'Enzo Romero Varela', '2011-03-15', 'enzo.romero@alumno.com', 'RESP046');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2011046', '2022-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2013046', '2023-07-04', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ENZO-PRI6',   '2022-09-01', '2022/2023', 'EXP2011046', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ENZO-ESO1',   '2023-09-01', '2023/2024', 'EXP2011046', 'I003',     1, 'ESO-GEN'),
('MAT-ENZO-ESO2-1', '2024-09-02', '2024/2025', 'EXP2011046', 'I003',     2, 'ESO-GEN'), -- 1er Intento de 2º ESO (Reprobado por absentismo)
('MAT-ENZO-ESO2-2', '2025-09-01', '2025/2026', 'EXP2011046', 'I003',     2, 'ESO-GEN'); -- Curso actual (Repetición)

-- 6. Adaptación Curricular / Plan de Convivencia y Retención (Activado en la repetición por conductas disruptivas y absentismo)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP046', '2025-10-10', 'Apoyo Educativo - Contrato Convivencia y Absentismo', 'Estudiante registra historial severo de inasistencia no justificada (absentismo >25%) y dos expedientes disciplinarios de expulsión por conductas disruptivas en el aula. Se firma Contrato de Convivencia con la familia, tutoría individualizada diaria y apoyo del orientador para reconducir la motivación académica y evitar la deserción terminal.', 'EXP2011046');

-- Relacionamos el plan de apoyo con las asignaturas del curso de repetición
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP046', 'ESO2-LCL'),
('ADAP046', 'ESO2-MAT'),
('ADAP046', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2022/2023 - Aprobado muy forzado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ENZO-PRI6', false), ('PRI6-MAT', 'MAT-ENZO-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ENZO-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-ENZO-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2023/2024 - Transición lograda en extraordinaria)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ENZO-ESO1', false), ('ESO1-MAT', 'MAT-ENZO-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ENZO-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-ENZO-ESO1', 'Final Ordinaria', 5.00); -- Aprobada en septiembre

-- C. 2º ESO - 1er INTENTO (2024/2025 - Fracaso escolar absoluto por desenganche y absentismo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2-1', false), ('ESO2-MAT', 'MAT-ENZO-ESO2-1', false), ('ESO2-FQ', 'MAT-ENZO-ESO2-1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2-1', 'Final Ordinaria', 3.00), -- Suspenso por inasistencia
('ESO2-MAT', 'MAT-ENZO-ESO2-1', 'Final Ordinaria', 2.00), -- Suspenso por inasistencia
('ESO2-FQ',  'MAT-ENZO-ESO2-1', 'Final Ordinaria', 3.50); -- Suspenso por inasistencia

-- D. 2º ESO - REPETICIÓN - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Ligera mejoría bajo el Contrato de Convivencia)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2-2', true), ('ESO2-MAT', 'MAT-ENZO-ESO2-2', true), ('ESO2-FQ', 'MAT-ENZO-ESO2-2', true);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2-2', '1ª Evaluación', 5.00), -- Logra aprobar raspado
('ESO2-MAT', 'MAT-ENZO-ESO2-2', '1ª Evaluación', 4.50), -- Sigue suspenso pero con evolución favorable
('ESO2-FQ',  'MAT-ENZO-ESO2-2', '1ª Evaluación', 5.00); -- Logra aprobar raspado
