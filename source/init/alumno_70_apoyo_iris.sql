-- CASO DE ESTUDIO 70: IRIS ROMERO CASTRO (ALUMNA DE RIESGO ALTO / ACOSO ESCOLAR / CIBERBULLYING / CAÍDA SEVERA DE CALIFICACIONES / PLAN DE PROTECCIÓN)
-- Archivo: alumno_70_apoyo_iris.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Romero Otero y Laura Castro Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP070', 'Marcos Romero Otero', 'Laura Castro Gómez', '600700011', '600700022', 'marcos.romero.o2@email.com', 'laura.castro.go@email.com', 'Rúa Juan Flórez 122, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP070', '2023-09-10', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP070', '2025-09-12', 25500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015070', '78901259L', 'Iris Romero Castro', '2012-10-09', 'iris.romero.c@alumno.com', 'RESP070');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015070', '2023-06-15', 6, 'PRI-GEN', 'C005'), -- CEIP Ramón de la Sagra
('EXP2015070', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-IRI3-PRI6', '2023-09-01', '2023/2024', 'EXP2015070', 'C005', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-IRI3-ESO1', '2024-09-02', '2024/2025', 'EXP2015070', 'I002',     1, 'ESO-GEN'),
('MAT-IRI3-ESO2', '2025-09-01', '2025/2026', 'EXP2015070', 'I002',     2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Protocolo de Acoso Escolar (Activado en 2º ESO tras denuncia por ciberacoso fuera del centro)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP070', '2025-10-15', 'Apoyo Educativo - Protocolo Ciberacoso y Ansiedad', 'Estudiante víctima de acoso escolar continuado en redes sociales (ciberbullying) por compañeros externos al grupo de clase. Presenta sintomatología ansioso-depresiva severa con fobia escolar reactiva, aislamiento y caída libre de notas. Se activa protocolo oficial de protección, tutorización diaria de acogida y derivación al equipo de salud mental.', 'EXP2015070');

-- Relacionamos la adaptación con todas las materias de 2º ESO afectadas
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP070', 'ESO2-LCL'),
('ADAP070', 'ESO2-MAT'),
('ADAP070', 'ESO2-FQ');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento notable ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-IRI3-PRI6', false), ('PRI6-MAT', 'MAT-IRI3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-IRI3-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-IRI3-PRI6', 'Final Ordinaria', 7.00);

-- B. 1º ESO (2024/2025 - Rendimiento notable estable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-IRI3-ESO1', false), ('ESO1-MAT', 'MAT-IRI3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-IRI3-ESO1', 'Final Ordinaria', 7.50),
('ESO1-MAT', 'MAT-IRI3-ESO1', 'Final Ordinaria', 7.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Caída libre por cuadro severo de ansiedad reactiva)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-IRI3-ESO2', false), ('ESO2-MAT', 'MAT-IRI3-ESO2', false), ('ESO2-FQ', 'MAT-IRI3-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-IRI3-ESO2', '1ª Evaluación', 4.50), -- Suspenso por bloqueo ansioso
('ESO2-MAT', 'MAT-IRI3-ESO2', '1ª Evaluación', 3.50), -- Suspenso severo
('ESO2-FQ',  'MAT-IRI3-ESO2', '1ª Evaluación', 4.00); -- Suspenso
