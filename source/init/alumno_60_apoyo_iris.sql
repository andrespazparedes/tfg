-- CASO DE ESTUDIO 60: IRIS BLANCO GÓMEZ (ALUMNA DE RIESGO ALTO / ADICCIÓN AL JUEGO EN LÍNEA / LUDOPATÍA DIGITAL / PLAN DE RECONEXIÓN ESCOLAR)
-- Archivo: alumno_60_apoyo_iris.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Blanco Otero y Laura Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP060', 'Marcos Blanco Otero', 'Laura Gómez Rey', '600600011', '600600022', 'marcos.blanco.o@email.com', 'laura.gomez.rey@email.com', 'Rúa Juan Flórez 102, N/A, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP060', '2023-09-10', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP060', '2025-09-12', 25500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015060', '12345685G', 'Iris Blanco Gómez', '2012-10-09', 'iris.blanco.g@alumno.com', 'RESP060');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015060', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015060', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-IRI2-PRI6', '2023-09-01', '2023/2024', 'EXP2015060', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-IRI2-ESO1', '2024-09-02', '2024/2025', 'EXP2015060', 'I002',     1, 'ESO-GEN'),
('MAT-IRI2-ESO2', '2025-09-01', '2025/2026', 'EXP2015060', 'I002',     2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Plan de Intervención por Ludopatía Digital (Activado en 2º ESO ante sospechas de adicción severa a apuestas en línea y videojuegos)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP060', '2025-10-15', 'Apoyo - Ludopatía y Adicción Tecnológica', 'Estudiante presenta un cuadro clínico severo de adicción a las tecnologías y juego en línea con apuestas simuladas. Esto ha provocado trastornos de sueño (*vamping* severo), irritabilidad y absentismo selectivo no justificado en las primeras horas. Se activa un plan de intervención psicopedagógica y control digital en el aula.', 'EXP2015060');

-- Relacionamos la adaptación con todas las asignaturas troncales instrumentales
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP060', 'ESO2-LCL'),
('ADAP060', 'ESO2-MAT'),
('ADAP060', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento notable ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-IRI2-PRI6', false), ('PRI6-MAT', 'MAT-IRI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-IRI2-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-IRI2-PRI6', 'Final Ordinaria', 7.00);

-- B. 1º ESO (2024/2025 - Ligera bajada pero aprobado)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-IRI2-ESO1', false), ('ESO1-MAT', 'MAT-IRI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-IRI2-ESO1', 'Final Ordinaria', 6.50),
('ESO1-MAT', 'MAT-IRI2-ESO1', 'Final Ordinaria', 6.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Caída libre del rendimiento escolar)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-IRI2-ESO2', false), ('ESO2-MAT', 'MAT-IRI2-ESO2', false), ('ESO2-FQ', 'MAT-IRI2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-IRI2-ESO2', '1ª Evaluación', 4.00), -- Suspenso por desatención y fatiga
('ESO2-MAT', 'MAT-IRI2-ESO2', '1ª Evaluación', 3.00), -- Suspenso severo
('ESO2-FQ',  'MAT-IRI2-ESO2', '1ª Evaluación', 3.50); -- Suspenso
