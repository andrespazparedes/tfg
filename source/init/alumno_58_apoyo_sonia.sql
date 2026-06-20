-- CASO DE ESTUDIO 58: SONIA VEIGA GÓMEZ (ALUMNA DE RIESGO MODERADO / MUTISMO SELECTIVO / FOBIA ESCOLAR / APOYO EN SALUD MENTAL / NEAE)
-- Archivo: alumno_58_apoyo_sonia.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Fernando Veiga Castro y María Gómez Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP058', 'Fernando Veiga Castro', 'María Gómez Rey', '600580011', '600580022', 'fernando.veiga.c@email.com', 'maria.gomez.rey2@email.com', 'Rúa Hospital 12, N/A, CP 15002, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP058', '2024-09-10', 23000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3), -- Encuesta en Primaria
('RESP058', '2025-09-11', 23500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016058', '12345683E', 'Sonia Veiga Gómez', '2013-10-19', 'sonia.veiga.g@alumno.com', 'RESP058');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016058', '2024-06-15', 6, 'PRI-GEN', 'C006'), -- CEIP Cidade Vella
('EXP2016058', '2025-07-03', 1, 'ESO-GEN', 'I006'); -- IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-SONI2-PRI6', '2024-09-02', '2024/2025', 'EXP2016058', 'C006', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-SONI2-ESO1', '2025-09-01', '2025/2026', 'EXP2016058', 'I006', 1, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / NEAE por Mutismo Selectivo (Activada en 1º de ESO por extrema timidez inhibidora con fobia social y escolar)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP058', '2025-10-15', 'Apoyo Educativo - Mutismo Selectivo y Ansiedad', 'Estudiante diagnosticada con Mutismo Selectivo y fobia escolar de base. Se inhibe de interactuar oralmente en el entorno del aula, limitándose a la comunicación gestual u escrita. Se activa Adaptación Metodológica de Acceso: evaluaciones orales sustituidas por cuestionarios escritos o grabaciones individuales controladas en formato audio/vídeo.', 'EXP2016058');

-- Relacionamos la adaptación con Lengua Castellana e Inglés
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP058', 'ESO1-LCL'),
('ADAP058', 'ESO1-ING');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Excelente rendimiento escrito)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-SONI2-PRI6', false), ('PRI6-MAT', 'MAT-SONI2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-SONI2-PRI6', 'Final Ordinaria', 8.00),
('PRI6-MAT', 'MAT-SONI2-PRI6', 'Final Ordinaria', 7.50);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Estabilidad bajo adaptación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-SONI2-ESO1', false), ('ESO1-MAT', 'MAT-SONI2-ESO1', false), ('ESO1-ING', 'MAT-SONI2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-SONI2-ESO1', '1ª Evaluación', 7.50), -- Notable
('ESO1-MAT', 'MAT-SONI2-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-ING', 'MAT-SONI2-ESO1', '1ª Evaluación', 7.00); -- Notable (¡Aprobado oral sustituido por grabaciones!)
