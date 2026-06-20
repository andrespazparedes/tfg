-- CASO DE ESTUDIO 33: VALERIA BLANCO VEIGA (ALUMNA DE CONTROL - ÉXITO ESO Y 2º BACHILLERATO ACTIVO)
-- Archivo: alumno_33_control_valeria.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Santiago Blanco Otero y Elena Veiga Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP033', 'Santiago Blanco Otero', 'Elena Veiga Gómez', '600330011', '600330022', 'santiago.blanco.v@email.com', 'elena.veiga.c@email.com', 'Rúa Monelos 10, 5º B, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media-alta y nula brecha digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP033', '2019-09-10', 33500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3), -- Encuesta en Primaria
('RESP033', '2021-09-12', 33000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante (Nacida en 2008 para estar en edad de 2º Bachillerato)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015033', '12341234M', 'Valeria Blanco Veiga', '2008-08-30', 'valeria.blanco.v@alumno.com', 'RESP033');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015033', '2019-06-16', 6, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2015033', '2020-07-04', 1, 'ESO-GEN', 'I004'), -- IES de Monelos (ESO)
('EXP2015033', '2024-06-25', 1, 'BAC-CIEN', 'I004'); -- IES de Monelos (Bachillerato)

-- 5. Historial Longitudinal de Matrículas Anuales (Rendimiento Alto)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-VALE3-PRI6', '2019-09-01', '2019/2020', 'EXP2015033', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-VALE3-ESO1', '2020-09-02', '2020/2021', 'EXP2015033', 'I004', 1, 'ESO-GEN'),
('MAT-VALE3-ESO2', '2021-09-01', '2021/2022', 'EXP2015033', 'I004', 2, 'ESO-GEN'),
('MAT-VALE3-ESO3', '2022-09-01', '2022/2023', 'EXP2015033', 'I004', 3, 'ESO-GEN'),
('MAT-VALE3-ESO4', '2023-09-01', '2023/2024', 'EXP2015033', 'I004', 4, 'ESO-GEN'), -- Gradúa a los 16 años
-- Bachillerato (Ciencias)
('MAT-VALE3-BAC1', '2024-09-01', '2024/2025', 'EXP2015033', 'I004', 1, 'BAC-CIEN'), -- 1º Bachillerato (Aprobado con nota)
('MAT-VALE3-BAC2', '2025-09-01', '2025/2026', 'EXP2015033', 'I004', 2, 'BAC-CIEN'); -- 2º Bachillerato (Curso actual)

-- 6. Historial de Calificaciones
-- A. 1º BACHILLERATO (2024/2025 - Aprobado notable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC1-LCL', 'MAT-VALE3-BAC1', false), ('BAC1-MAT1', 'MAT-VALE3-BAC1', false), ('BAC1-FQ', 'MAT-VALE3-BAC1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC1-LCL', 'MAT-VALE3-BAC1', 'Final Ordinaria', 8.00),
('BAC1-MAT1', 'MAT-VALE3-BAC1', 'Final Ordinaria', 7.50),
('BAC1-FQ',  'MAT-VALE3-BAC1', 'Final Ordinaria', 7.50);

-- B. 2º BACHILLERATO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('BAC2-LCL', 'MAT-VALE3-BAC2', false), ('BAC2-MAT2', 'MAT-VALE3-BAC2', false), ('BAC2-HIS', 'MAT-VALE3-BAC2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('BAC2-LCL', 'MAT-VALE3-BAC2', '1ª Evaluación', 8.00), -- Notable
('BAC2-MAT2', 'MAT-VALE3-BAC2', '1ª Evaluación', 7.50), -- Notable
('BAC2-HIS',  'MAT-VALE3-BAC2', '1ª Evaluación', 8.50); -- Notable alto
