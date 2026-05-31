-- CASO DE ESTUDIO 11: VALERIA CASTRO VEIGA (ENFERMEDAD CRÓNICA Y ATENCIÓN DOMICILIARIA)
-- Archivo: alumno_11_salud.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Javier Castro Varela y Elena Veiga Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP011', 'Javier Castro Varela', 'Elena Veiga Gómez', '600110011', '600110022', 'javier.castro@email.com', 'elena.veiga@email.com', 'Rúa Monelos 44, 4º Der, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan estabilidad en ingresos familiares y equipamiento informático para teledocencia)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP011', '2022-09-10', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en 5º Primaria (Momento del diagnóstico clínico)
('RESP011', '2025-09-12', 24500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en 2º ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015011', '88990011K', 'Valeria Castro Veiga', '2012-08-30', 'valeria.castro@alumno.com', 'RESP011');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015011', '2022-06-16', 5, 'PRI-GEN', 'C003'), -- Admitida en 5º de Primaria en CEIP Salgado Torres
('EXP2015011', '2024-07-04', 1, 'ESO-GEN', 'I004'); -- Admitida en 1º ESO en IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales (Rendimiento estable condicionado por absentismo clínico justificado)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Salgado Torres)
('MAT-VALE-PRI5', '2022-09-02', '2022/2023', 'EXP2015011', 'C003', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-VALE-PRI6', '2023-09-01', '2023/2024', 'EXP2015011', 'C003', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES de Monelos)
('MAT-VALE-ESO1', '2024-09-02', '2024/2025', 'EXP2015011', 'I004', 1, 'ESO-GEN'), -- 1º ESO (Hospitalizaciones y SAED)
('MAT-VALE-ESO2', '2025-09-01', '2025/2026', 'EXP2015011', 'I004', 2, 'ESO-GEN'); -- 2º ESO (Curso actual, estabilidad)

-- 6. Adaptación Curricular / Atención Domiciliaria (Activada en 1º de ESO por absentismo médico prolongado del 22%)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP011', '2024-11-15', 'Apoyo Médico - Atención Domiciliaria', 'Se activa el protocolo de Atención Educativa Domiciliaria y Hospitalaria (SAED) de la Xunta de Galicia por absentismo médico prolongado (22%) justificado por ingresos recurrentes debidos a Diabetes Mellitus Tipo 1 inestable y crisis asmáticas severas. El profesorado imparte docencia telemática y presencial en domicilio durante sus convalecencias.', 'EXP2015011');

-- Vinculamos la intervención con las materias troncales instrumentales adaptadas para seguimiento telemático
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP011', 'ESO1-LCL'),
('ADAP011', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2022/2023 - Rendimiento notable ordinario antes del diagnóstico de diabetes)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-VALE-PRI5', false), 
('PRI5-MAT', 'MAT-VALE-PRI5', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-VALE-PRI5', 'Final Ordinaria', 6.50),
('PRI5-MAT', 'MAT-VALE-PRI5', 'Final Ordinaria', 7.00);

-- B. 6º PRIMARIA (2023/2024 - Descenso a aprobados regulares debido al impacto clínico de los ingresos iniciales)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-VALE-PRI6', false), 
('PRI6-MAT', 'MAT-VALE-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-VALE-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-VALE-PRI6', 'Final Ordinaria', 6.00);

-- C. 1º ESO (2024/2025 - Resiliencia académica notable: supera el curso a pesar de 22% de absentismo gracias al apoyo domiciliario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-VALE-ESO1', false), 
('ESO1-MAT', 'MAT-VALE-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-VALE-ESO1', 'Final Ordinaria', 6.50),
('ESO1-MAT', 'MAT-VALE-ESO1', 'Final Ordinaria', 6.00);

-- D. 2º ESO - CURSO ACTUAL (2025/2026 - Excelente estabilidad clínica e integración académica)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-VALE-ESO2', false),
('ESO2-MAT', 'MAT-VALE-ESO2', false),
('ESO2-FQ',  'MAT-VALE-ESO2', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-VALE-ESO2', '1ª Evaluación', 6.50), -- Aprobado holgado
('ESO2-MAT', 'MAT-VALE-ESO2', '1ª Evaluación', 6.00), -- Aprobado holgado
('ESO2-FQ',  'MAT-VALE-ESO2', '1ª Evaluación', 6.00); -- Aprobado holgado
