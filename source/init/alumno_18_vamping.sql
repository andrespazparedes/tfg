-- CASO DE ESTUDIO 18: ADRIÁN VEIGA BLANCO (ADICCIÓN TECNOLÓGICA / VAMPING Y TRASTORNO DE SUEÑO)
-- Archivo: alumno_18_vamping.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (David Veiga Gómez y Lucía Blanco Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP018', 'David Veiga Gómez', 'Lucía Blanco Otero', '600180011', '600180022', 'david.veiga@email.com', 'lucia.blanco@email.com', 'Rúa Juana de Vega 25, 4º Izq, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan clase media estable con alto equipamiento digital)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP018', '2023-09-10', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP018', '2025-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015018', '99887744Q', 'Adrián Veiga Blanco', '2012-09-24', 'adrian.veiga@alumno.com', 'RESP018');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015018', '2015-06-12', 1, 'INF-GEN', 'C005'), -- Admitido en Infantil en CEIP Ramón de la Sagra
('EXP2015018', '2024-07-04', 1, 'ESO-GEN', 'I002'); -- Admitido en 1º ESO en IES Fernando Wirtz Suárez

-- 5. Historial Longitudinal de Matrículas Anuales (Historial normal y caída paulatina en ESO por vamping digital)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-ADRI-INF3', '2017-09-01', '2017/2018', 'EXP2015018', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-ADRI-PRI6', '2023-09-01', '2023/2024', 'EXP2015018', 'C005', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Fernando Wirtz Suárez)
('MAT-ADRI-ESO1', '2024-09-02', '2024/2025', 'EXP2015018', 'I002',     1, 'ESO-GEN'), -- 1º ESO (Llegadas tarde recurrentes)
('MAT-ADRI-ESO2', '2025-09-01', '2025/2026', 'EXP2015018', 'I002',     2, 'ESO-GEN'); -- 2º ESO (Curso actual, colapso)

-- 6. Adaptación Curricular / Reeducación de Hábitos (Activada a mitad de 2º ESO por adicción y trastorno del sueño)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP018', '2025-11-18', 'Apoyo Educativo - Reeducación de Hábitos', 'Se activa plan de reeducación de hábitos digitales y desintoxicación tecnológica en colaboración con la Unidad de Conductas Adictivas del SERGAS. Presenta absentismo del 18% no justificado a primera hora por "vamping" digital nocturno e insomnio. Se pauta flexibilidad horaria de exámenes.', 'EXP2015018');

-- Vinculamos la intervención con las materias troncales afectadas por el absentismo a primera hora y cansancio
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP018', 'ESO2-LCL'),
('ADAP018', 'ESO2-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Rendimiento medio correcto antes del smartphone)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ADRI-PRI6', false), 
('PRI6-MAT', 'MAT-ADRI-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ADRI-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-ADRI-PRI6', 'Final Ordinaria', 6.50);

-- B. 1º ESO (2024/2025 - Caída a la zona de aprobados justos por vamping digital nocturno)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ADRI-ESO1', false), 
('ESO1-MAT', 'MAT-ADRI-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ADRI-ESO1', 'Final Ordinaria', 5.00), -- Aprobado raspado
('ESO1-MAT', 'MAT-ADRI-ESO1', 'Final Ordinaria', 5.50); -- Aprobado muy justo

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - Colapso absoluto en 1ª Ev por insomnio crónico y fatiga en exámenes)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ADRI-ESO2', false),
('ESO2-MAT', 'MAT-ADRI-ESO2', false),
('ESO2-FQ',  'MAT-ADRI-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ADRI-ESO2', '1ª Evaluación', 3.00), -- Suspenso por fatiga y absentismo a primera hora
('ESO2-MAT', 'MAT-ADRI-ESO2', '1ª Evaluación', 3.00), -- Suspenso por nula entrega de cuadernos de ejercicios
('ESO2-FQ',  'MAT-ADRI-ESO2', '1ª Evaluación', 2.50); -- Suspenso severo en el examen escrito por bloqueo de sueño
