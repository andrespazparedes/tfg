-- CASO DE ESTUDIO 17: CARLA ROMERO VEIGA (INESTABILIDAD HABITACIONAL Y CRISIS DE VIVIENDA)
-- Archivo: alumno_17_desahucio.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Manuel Romero Vázquez y Elena Veiga Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP017', 'Manuel Romero Vázquez', 'Elena Veiga Gómez', '600170011', '600170022', 'manuel.romero@email.com', 'elena.veiga@email.com', 'Rúa Orillamar 12, 1º Der, CP 15001, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos muy bajos e inestabilidad extrema tras desahucio)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP017', '2023-09-10', 12500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 3), -- Encuesta en 5º Primaria (CEIP Cidade Vella)
('RESP017', '2025-11-20', 12000.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 3); -- Encuesta tras desahucio y realojo (1º ESO)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016017', '99887755P', 'Carla Romero Veiga', '2013-06-18', 'carla.romero@alumno.com', 'RESP017');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016017', '2023-06-15', 5, 'PRI-GEN', 'C006'), -- Admitida en 5º de Primaria en CEIP Cidade Vella
('EXP2016017', '2025-11-15', 1, 'ESO-GEN', 'I003'); -- Admitida de forma extraordinaria a mitad de curso tras desahucio en IES Agra do Orzán

-- 5. Historial Longitudinal de Matrículas Anuales (Historial normal y colapso habitacional con matrícula extraordinaria en Secundaria)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP Cidade Vella)
('MAT-CARL-PRI5', '2023-09-01', '2023/2024', 'EXP2016017', 'C006', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-CARL-PRI6', '2024-09-02', '2024/2025', 'EXP2016017', 'C006', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Agra do Orzán - Admisión Extraordinaria por Desahucio)
('MAT-CARL-ESO1', '2025-11-16', '2025/2026', 'EXP2016017', 'I003',     1, 'ESO-GEN'); -- 1º ESO (Curso actual, matriculada a mitad de primer trimestre)

-- 6. Adaptación Curricular / Plan de Apoyo Habitacional (Activada de urgencia al matricularse en el nuevo centro)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP017', '2025-11-22', 'Apoyo Social - Inestabilidad Habitacional', 'Se activa plan de apoyo de emergencia social e interinstitucional por desahucio de vivienda familiar y realojo en hostal municipal de Agra do Orzán. Se registra absentismo del 20% por problemas de transporte, solucionado con bono bus social del Concello y flexibilización de rúbricas escolares.', 'EXP2016017');

-- Vinculamos el apoyo social de emergencia con las materias más afectadas por el absentismo inicial
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP017', 'ESO1-LCL'),
('ADAP017', 'ESO1-MAT');

-- 7. Historial de Calificaciones
-- A. 5º PRIMARIA (2023/2024 - Rendimiento regular correcto ordinario)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI5-LCL', 'MAT-CARL-PRI5', false), 
('PRI5-MAT', 'MAT-CARL-PRI5', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI5-LCL', 'MAT-CARL-PRI5', 'Final Ordinaria', 5.50),
('PRI5-MAT', 'MAT-CARL-PRI5', 'Final Ordinaria', 6.00);

-- B. 6º PRIMARIA (2024/2025 - Cierre de Primaria regular estable antes del colapso habitacional)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-CARL-PRI6', false), 
('PRI6-MAT', 'MAT-CARL-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-CARL-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-CARL-PRI6', 'Final Ordinaria', 5.50);

-- C. 1º ESO - CURSO ACTUAL (2025/2026 - Colapso en 1ª Ev en el nuevo centro debido al absentismo y estrés post-desahucio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-CARL-ESO1', false), 
('ESO1-MAT', 'MAT-CARL-ESO1', false),
('ESO1-GH',  'MAT-CARL-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-CARL-ESO1', '1ª Evaluación', 3.50), -- Suspenso por absentismo del 20%
('ESO1-MAT', 'MAT-CARL-ESO1', '1ª Evaluación', 3.50), -- Suspenso por absentismo del 20%
('ESO1-GH',  'MAT-CARL-ESO1', '1ª Evaluación', 5.00); -- Aprobado raspado (gracias a flexibilidad en entrega de tareas)
