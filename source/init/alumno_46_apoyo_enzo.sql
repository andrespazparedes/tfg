-- CASO DE ESTUDIO 46: ENZO ROMERO VARELA (ALUMNO DE RIESGO ALTO - ABANDONO ESCOLAR TEMPRANO HISTÓRICO EN ESO)
-- Archivo: alumno_46_apoyo_enzo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Sergio Romero Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP046', 'Sergio Romero Gómez', NULL, '600460011', NULL, 'sergio.romero.g@email.com', NULL, 'Rúa Villa de Negreira 10, 4º Izq, CP 15010, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Hogar monoparental de muy baja renta, brecha digital severa y desahucio)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP046', '2019-09-10', 12500.00, false, 'Estudios Primarios', NULL, 0, 3), -- Encuesta en Primaria
('RESP046', '2021-09-12', 11000.00, false, 'Estudios Primarios', NULL, 0, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacido en 2008, abandono histórico a los 16 años)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2011046', '78901242R', 'Enzo Romero Varela', '2008-03-15', 'enzo.romero@alumno.com', 'RESP046');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2011046', '2019-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2011046', '2020-07-04', 1, 'ESO-GEN', 'I003'); -- IES Agra do Orzán (Admisión ordinaria)

-- 5. Historial Longitudinal de Matrículas Anuales (Doble repetición y colapso por desahucio familiar)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('M46-PRI6',   '2019-09-01', '2019/2020', 'EXP2011046', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria (ESO)
('M46-ESO1',   '2020-09-01', '2020/2021', 'EXP2011046', 'I003', 1, 'ESO-GEN'),
('M46-ESO2-1', '2021-09-02', '2021/2022', 'EXP2011046', 'I003', 2, 'ESO-GEN'), -- 1er Intento de 2º ESO (Repite por inasistencia)
('M46-ESO2-2', '2022-09-01', '2022/2023', 'EXP2011046', 'I003', 2, 'ESO-GEN'), -- Repetición de 2º ESO (Aprueba raspado)
('M46-ESO3',   '2023-09-01', '2023/2024', 'EXP2011046', 'I003', 3, 'ESO-GEN'), -- 3º ESO (Fracaso severo e inasistencia del 40%)
('M46-ESO3R',  '2024-09-01', '2024/2025', 'EXP2011046', 'I003', 3, 'ESO-GEN'); -- Repetición 3º ESO (Baja por abandono al cumplir 16 años)
-- Nota: En 2025/2026 NO hay matrícula por deserción terminal del sistema educativo.

-- 6. Adaptación Curricular / Plan de Absentismo Crítico (Baja por abandono escolar al cumplir la edad obligatoria)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP046', '2024-11-10', 'Apoyo Educativo - Protocolo Absentismo Crónico', 'Estudiante registra absentismo no justificado superior al 38% agravado por la pérdida de la vivienda familiar. Tras cumplir los 16 años de edad legal el 15/03/2024, el alumno abandona definitivamente el centro y se tramita la baja formal del sistema educativo por incomparecencia.', 'EXP2011046');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2019/2020 - Aprobado al límite)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'M46-PRI6', false), ('PRI6-MAT', 'M46-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'M46-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'M46-PRI6', 'Final Ordinaria', 5.00);

-- B. 2º ESO - REPETICIÓN (2022/2023 - Pasa raspado en Extraordinaria)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'M46-ESO2-2', true), ('ESO2-MAT', 'M46-ESO2-2', true);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'M46-ESO2-2', 'Final Ordinaria', 5.00),
('ESO2-MAT', 'M46-ESO2-2', 'Final Ordinaria', 5.00);

-- C. 3º ESO - REPETICIÓN (2024/2025 - Causa baja definitiva a mitad de curso)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO3-LCL', 'M46-ESO3R', false), ('ESO3-MAT', 'M46-ESO3R', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO3-LCL', 'M46-ESO3R', '1ª Evaluación', 3.00), -- Abandono de hecho
('ESO3-MAT', 'M46-ESO3R', '1ª Evaluación', 2.00); -- Abandono de hecho
