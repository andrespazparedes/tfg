-- CASO DE ESTUDIO 42: SARA ROMERO CASTRO (ALUMNA DE RIESGO ALTO / ETNIA GITANA / RECUPERACIÓN EXITOSA EN GRADO BÁSICO)
-- Archivo: alumno_42_apoyo_sara.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Juan Romero Blanco y María Castro Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP042', 'Juan Romero Blanco', 'María Castro Gómez', '600420011', '600420022', 'juan.romero@email.com', 'maria.castro.g@email.com', 'Rúa Agra do Orzán 50, CP 15010, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Hogar vulnerable con bajos ingresos)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP042', '2023-09-10', 11500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 5), -- Encuesta en Primaria
('RESP042', '2025-09-12', 12000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 5); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2014042', '78901238M', 'Sara Romero Castro', '2011-09-12', 'sara.romero@alumno.com', 'RESP042');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2014042', '2023-06-15', 6, 'PRI-GEN', 'C004'), -- CEIP Alborada
('EXP2014042', '2024-07-04', 1, 'ESO-GEN', 'I003'), -- IES Agra do Orzán (Admisión general)
('EXP2014042', '2025-07-03', 3, 'ESO-GB',  'I003'); -- Redirección a FP Básica

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SARA-PRI6', '2023-09-01', '2023/2024', 'EXP2014042', 'C004', 6, 'PRI-GEN'),
-- Educación Secundaria (Intento Ordinario)
('MAT-SARA-ESO1', '2024-09-02', '2024/2025', 'EXP2014042', 'I003', 1, 'ESO-GEN'),
-- Redirección a Grado Básico de FP (Equivalente a 3º ESO)
('MAT-SARA-GB1',  '2025-09-01', '2025/2026', 'EXP2014042', 'I003', 3, 'ESO-GB'); -- Curso actual

-- 6. Adaptación Curricular / Plan Gitano - FPB (Plan de Mediación y Derivación Temprana)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP042', '2024-10-15', 'Plan de Integración Social y Apoyo Curricular', 'Estudiante de etnia gitana con desfase escolar instrumental acumulado y absentismo recurrente en la transición. Se incorpora al programa de mediación y se propone su derivación al Ciclo Formativo de Grado Básico (FP Básica) por su marcada aptitud manipulativa y práctica, para potenciar el éxito y evitar el abandono temprano.', 'EXP2014042');

-- Vinculamos la adaptación con las asignaturas del Grado Básico
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP042', 'ESOGB1-ACT'),
('ADAP042', 'ESOGB1-PRAC');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Aprobados al límite)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6', false), ('PRI6-MAT', 'MAT-SARA-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SARA-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-SARA-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2024/2025 - Rendimiento crítico ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SARA-ESO1', false), ('ESO1-MAT', 'MAT-SARA-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SARA-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-SARA-ESO1', 'Final Ordinaria', 4.50); -- Aprobada en convocatoria extraordinaria a final de curso

-- C. 3º ESO - 1º GRADO BÁSICO (2025/2026 - Excelente recuperación en perfil práctico)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESOGB1-ACT', 'MAT-SARA-GB1', false), ('ESOGB1-ALS', 'MAT-SARA-GB1', false), ('ESOGB1-PRAC', 'MAT-SARA-GB1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESOGB1-ACT',  'MAT-SARA-GB1', '1ª Evaluación', 6.00), -- Ciencias Aplicadas
('ESOGB1-ALS',  'MAT-SARA-GB1', '1ª Evaluación', 6.50), -- Comunicación y Sociales
('ESOGB1-PRAC', 'MAT-SARA-GB1', '1ª Evaluación', 7.50); -- Taller Práctico (¡Notable éxito!)
