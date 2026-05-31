-- CASO DE ESTUDIO 7: NOA ROMERO VÁZQUEZ (ABSENTISMO POR CARGAS FAMILIARES Y CONCILIACIÓN)
-- Archivo: alumno_7_absentismo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Raquel Romero Vázquez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP007', 'Raquel Romero Vázquez', NULL, '600070011', NULL, 'raquel.romero@email.com', NULL, 'Rúa San Andrés 45, 2º Der, CP 15003, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos por discapacidad y monoparentalidad)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP007', '2023-09-10', 14500.00, true, 'Estudios Primarios', NULL, 1, 4), -- Encuesta en 5º Primaria (Ingresos muy justos)
('RESP007', '2025-09-10', 9800.00, true, 'Estudios Primarios', NULL, 1, 4); -- Encuesta en 1º ESO (Caída de ingresos por fibromialgia grave de la madre)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016007', '44556677G', 'Noa Romero Vázquez', '2013-05-14', 'noa.romero@alumno.com', 'RESP007');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016007', '2023-06-15', 5, 'PRI-GEN', 'C006'), -- Admitida en 5º de Primaria en CEIP Cidade Vella
('EXP2016007', '2025-07-02', 1, 'ESO-GEN', 'I003'); -- Admitida en 1º de ESO en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales (Curso escolar ordinario estable hasta caída y absentismo en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Cidade Vella)
('MAT-NOA-PRI5', '2023-09-01', '2023/2024', 'EXP2016007', 'C006', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-NOA-PRI6', '2024-09-02', '2024/2025', 'EXP2016007', 'C006', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Agra do Orzán)
('MAT-NOA-ESO1', '2025-09-01', '2025/2026', 'EXP2016007', 'I003', 1, 'ESO-GEN'); -- 1º ESO (Curso actual con absentismo crítico)

-- 6. Intervención Social / Plan de Absentismo (Registrada en 1º de ESO ante alarma de absentismo del 18%)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP007', '2025-10-15', 'Absentismo - Protocolo Intervención', 'Se abre expediente por absentismo acumulado no justificado del 18%. La alumna falta reiteradamente a las primeras horas del día. La investigación familiar constata que la madre padece fibromialgia grave incapacitante, recayendo en la estudiante de 12 años el cuidado matutino y traslado de sus hermanos menores (4 y 7 años) a Educación Infantil y Primaria. Se activa apoyo domiciliario municipal y plan escolar de conciliación.', 'EXP2016007');

-- Relacionamos la intervención con las materias más afectadas por su ausencia a primera hora
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP007', 'ESO1-MAT'),
('ADAP007', 'ESO1-ING');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024 - Rendimiento medio correcto antes del empeoramiento familiar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-NOA-PRI5', false), 
('PRI5-MAT', 'MAT-NOA-PRI5', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-NOA-PRI5', 'Final Ordinaria', 6.00),
('PRI5-MAT', 'MAT-NOA-PRI5', 'Final Ordinaria', 6.50);

-- B. 6º PRIMARIA (2024/2025 - Inicio del empeoramiento y absentismo leve en la etapa final)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-NOA-PRI6', false), 
('PRI6-MAT', 'MAT-NOA-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-NOA-PRI6', 'Final Ordinaria', 5.50),
('PRI6-MAT', 'MAT-NOA-PRI6', 'Final Ordinaria', 5.00);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - Colapso a primera hora en 1ª Ev por absentismo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-NOA-ESO1', false), 
('ESO1-MAT', 'MAT-NOA-ESO1', false), -- 1ª hora, muy afectada
('ESO1-ING', 'MAT-NOA-ESO1', false), -- 1ª hora, muy afectada
('ESO1-GH',  'MAT-NOA-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-NOA-ESO1', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO1-MAT', 'MAT-NOA-ESO1', '1ª Evaluación', 3.00), -- Suspenso severo por faltas reiteradas
('ESO1-ING', 'MAT-NOA-ESO1', '1ª Evaluación', 3.50), -- Suspenso severo por faltas reiteradas
('ESO1-GH',  'MAT-NOA-ESO1', '1ª Evaluación', 5.00); -- Aprobado raspado
