-- CASO DE ESTUDIO 48: SONIA BLANCO REY (ALUMNA DE RIESGO MODERADO / TRASLADO INTERESTATAL / DESFASE CURRICULAR EN CIENCIAS)
-- Archivo: alumno_48_apoyo_sonia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Blanco Castro y Paula Rey Romero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP048', 'Sergio Blanco Castro', 'Paula Rey Romero', '600480011', '600480022', 'sergio.blanco.r@email.com', 'paula.rey.r@email.com', 'Rúa Monelos 102, 1º Izq, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos ajustados tras mudanza interprovincial)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP048', '2023-09-10', 20500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP048', '2025-09-11', 21000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015048', '78901244T', 'Sonia Blanco Rey', '2012-11-19', 'sonia.blanco@alumno.com', 'RESP048');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015048', '2023-06-15', 6, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2015048', '2024-07-04', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SONI-PRI6', '2023-09-01', '2023/2024', 'EXP2015048', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SONI-ESO1', '2024-09-02', '2024/2025', 'EXP2015048', 'I004', 1, 'ESO-GEN'),
('MAT-SONI-ESO2', '2025-09-01', '2025/2026', 'EXP2015048', 'I004', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Plan de Acogida e Inserción (Activada en 2º ESO por desfase curricular en áreas de ciencias)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP048', '2025-10-15', 'Apoyo Educativo - Integración Curricular', 'Estudiante incorporada tardíamente a la comunidad autónoma. Presenta desfase de contenidos en el área de ciencias (Física y Química) debido a diferencias curriculares en los decretos de origen. Se prescribe plan de apoyo personalizado y tutorización académica semanal para la nivelación de conceptos.', 'EXP2015048');

-- Relacionamos la adaptación con la asignatura afectada por el desfase curricular
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP048', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento medio correcto antes del traslado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SONI-PRI6', false), ('PRI6-MAT', 'MAT-SONI-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SONI-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-SONI-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025 - Adaptación transitoria al centro)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SONI-ESO1', false), ('ESO1-MAT', 'MAT-SONI-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SONI-ESO1', 'Final Ordinaria', 5.50),
('ESO1-MAT', 'MAT-SONI-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Afectada por desfase en FQ)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-SONI-ESO2', false), ('ESO2-MAT', 'MAT-SONI-ESO2', false), ('ESO2-FQ', 'MAT-SONI-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-SONI-ESO2', '1ª Evaluación', 5.50), -- Aprobado raspado
('ESO2-MAT', 'MAT-SONI-ESO2', '1ª Evaluación', 5.00), -- Aprobado raspado
('ESO2-FQ',  'MAT-SONI-ESO2', '1ª Evaluación', 4.00); -- Suspenso por desfase curricular de origen
