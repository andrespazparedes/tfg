-- CASO DE ESTUDIO 68: SONIA BLANCO OTERO (ALUMNA CON DISCAPACIDAD SENSORIAL VISUAL / ADAPTACIÓN DE ACCESO Y APOJO TECNOLÓGICO / NEAE)
-- Archivo: alumno_68_apoyo_sonia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Blanco Rey y Paula Otero Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP068', 'Marcos Blanco Rey', 'Paula Otero Castro', '600680011', '600680022', 'marcos.blanco.re@email.com', 'paula.otero.ca@email.com', 'Rúa Monelos 180, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP068', '2024-09-10', 22000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP068', '2025-09-11', 22500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016068', '78901257H', 'Sonia Blanco Otero', '2013-10-19', 'sonia.blanco.ot@alumno.com', 'RESP068');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016068', '2024-06-15', 6, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2016068', '2025-07-03', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SON3-PRI6', '2024-09-02', '2024/2025', 'EXP2016068', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SON3-ESO1', '2025-09-01', '2025/2026', 'EXP2016068', 'I004', 1, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Diversidad Sensorial Visual - Baja Visión (Activada en 1º de ESO para adaptación tecnológica de acceso)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP068', '2025-10-15', 'Apoyo Educativo - Diversidad Funcional Visual', 'Estudiante diagnosticada con Baja Visión severa bilateral no corregible por lentes convencionales. Presenta agudeza visual inferior al 0.1 en escala decimal. Se prescribe Adaptación de Acceso: uso de textos tipográficos ampliados (macrotipo Arial 18), software magnificador en equipos escolares y soporte táctil y auditivo para ciencias.', 'EXP2016068');

-- Relacionamos la adaptación visual con todas las asignaturas de 1º de ESO
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP068', 'ESO1-LCL'),
('ADAP068', 'ESO1-MAT'),
('ADAP068', 'ESO1-ING');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento notable con textos ampliados)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SON3-PRI6', false), ('PRI6-MAT', 'MAT-SON3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SON3-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-SON3-PRI6', 'Final Ordinaria', 7.00);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Consistencia excelente bajo el soporte activo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SON3-ESO1', false), ('ESO1-MAT', 'MAT-SON3-ESO1', false), ('ESO1-ING', 'MAT-SON3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SON3-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-MAT', 'MAT-SON3-ESO1', '1ª Evaluación', 6.50), -- Bien
('ESO1-ING', 'MAT-SON3-ESO1', '1ª Evaluación', 7.00); -- Notable
