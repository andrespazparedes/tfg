-- CASO DE ESTUDIO 44: GABRIELA VEIGA GÓMEZ (ALUMNA CON DISCALCULIA / APOYO EN MATEMÁTICAS / NEAE)
-- Archivo: alumno_44_apoyo_gabriela.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Fernando Veiga Castro y Laura Gómez Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP044', 'Fernando Veiga Castro', 'Laura Gómez Otero', '600440011', '600440022', 'fernando.veiga@email.com', 'laura.gomez.o@email.com', 'Rúa Monelos 40, N/A, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP044', '2023-09-10', 22500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP044', '2025-09-11', 23000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015044', '78901240P', 'Gabriela Veiga Gómez', '2012-10-18', 'gabriela.veiga@alumno.com', 'RESP044');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015044', '2023-06-15', 6, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2015044', '2024-07-04', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-GABY-PRI6', '2023-09-01', '2023/2024', 'EXP2015044', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-GABY-ESO1', '2024-09-02', '2024/2025', 'EXP2015044', 'I004', 1, 'ESO-GEN'),
('MAT-GABY-ESO2', '2025-09-01', '2025/2026', 'EXP2015044', 'I004', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Discalculia (Activada en 6º Primaria por graves dificultades lógicas)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP044', '2023-11-10', 'Apoyo Educativo - Discalculia Metodológica', 'Estudiante diagnosticada con Discalculia (dificultad específica del aprendizaje del cálculo aritmético). Muestra rendimiento lingüístico excelente pero bloqueo con operaciones abstractas y fórmulas. Se prescribe adaptación metodológica: uso de ábaco/tablas de soporte, simplificación de problemas numéricos y segmentación evaluativa.', 'EXP2015044');

-- Relacionamos la adaptación con Matemáticas y Física y Química
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP044', 'ESO1-MAT'),
('ADAP044', 'ESO2-MAT'),
('ADAP044', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Excelente en Lengua, muy baja en Matemáticas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-GABY-PRI6', false), ('PRI6-MAT', 'MAT-GABY-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-GABY-PRI6', 'Final Ordinaria', 8.50), -- Notable brillante
('PRI6-MAT', 'MAT-GABY-PRI6', 'Final Ordinaria', 5.00); -- Aprobado muy justo por adaptación activa

-- B. 1º ESO (2024/2025 - Transición aprobada con apoyos)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-GABY-ESO1', false), ('ESO1-MAT', 'MAT-GABY-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-GABY-ESO1', 'Final Ordinaria', 8.00), -- Notable
('ESO1-MAT', 'MAT-GABY-ESO1', 'Final Ordinaria', 5.50); -- Aprobado raspado

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-GABY-ESO2', false), ('ESO2-MAT', 'MAT-GABY-ESO2', false), ('ESO2-FQ', 'MAT-GABY-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-GABY-ESO2', '1ª Evaluación', 8.00), -- Notable alto
('ESO2-MAT', 'MAT-GABY-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado con el soporte
('ESO2-FQ',  'MAT-GABY-ESO2', '1ª Evaluación', 5.00); -- Aprobado raspado por componente matemático
