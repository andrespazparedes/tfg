-- CASO DE ESTUDIO 56: ENZO BLANCO OTERO (ALUMNO DE RIESGO ALTO / ABSENTISMO PROLONGADO / DESENGANCHE SOCIOFAMILIAR / MEDIDAS DE RETENCIÓN)
-- Archivo: alumno_56_apoyo_enzo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Marcos Blanco Rey y Paula Otero Castro)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP056', 'Marcos Blanco Rey', 'Paula Otero Castro', '600560011', '600560022', 'marcos.blanco.r@email.com', 'paula.otero.c@email.com', 'Rúa Monelos 115, 3º D, CP 15009, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Hogar vulnerable con bajos ingresos y brecha digital moderada)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP056', '2023-09-10', 14500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4), -- Encuesta en Primaria
('RESP056', '2025-09-12', 13500.00, true, 'Estudios Primarios', 'Estudios Primarios', 1, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015056', '12345681C', 'Enzo Blanco Otero', '2012-04-18', 'enzo.blanco.o@alumno.com', 'RESP056');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015056', '2023-06-15', 6, 'PRI-GEN', 'C003'), -- CEIP Salgado Torres
('EXP2015056', '2024-07-04', 1, 'ESO-GEN', 'I004'); -- IES de Monelos

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-ENZ2-PRI6', '2023-09-01', '2023/2024', 'EXP2015056', 'C003', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-ENZ2-ESO1', '2024-09-02', '2024/2025', 'EXP2015056', 'I004', 1, 'ESO-GEN'),
('MAT-ENZ2-ESO2', '2025-09-01', '2025/2026', 'EXP2015056', 'I004', 2, 'ESO-GEN'); -- Curso actual

-- 6. Adaptación Curricular / Plan de Absentismo y Retención (Activado en 2º ESO por inasistencias sistemáticas)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP056', '2025-10-15', 'Apoyo Educativo - Absentismo y Prevención de Abandono', 'Estudiante registra un patrón de inasistencia prolongado no justificado en el segundo curso de la ESO (>20% de faltas acumuladas), condicionado por desapego familiar y desmotivación académica severa. Se activa el protocolo de prevención del abandono escolar temprano, coordinando apoyo socioeducativo continuado.', 'EXP2015056');

-- Relacionamos la adaptación con Matemáticas e instrumentales adaptadas
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP056', 'ESO2-LCL'),
('ADAP056', 'ESO2-MAT');

-- 7. Historial de Calificaciones
-- A. 6º PRIMARIA (2023/2024 - Aprobado muy justo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ENZ2-PRI6', false), ('PRI6-MAT', 'MAT-ENZ2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ENZ2-PRI6', 'Final Ordinaria', 5.00),
('PRI6-MAT', 'MAT-ENZ2-PRI6', 'Final Ordinaria', 5.00);

-- B. 1º ESO (2024/2025 - Paso forzado con suspensos recuperados)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ENZ2-ESO1', false), ('ESO1-MAT', 'MAT-ENZ2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ENZ2-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-ENZ2-ESO1', 'Final Ordinaria', 5.00);

-- C. 2º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación - Calificaciones críticas por absentismo sistemático)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ENZ2-ESO2', false), ('ESO2-MAT', 'MAT-ENZ2-ESO2', false), ('ESO2-FQ', 'MAT-ENZ2-ESO2', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ENZ2-ESO2', '1ª Evaluación', 4.00), -- Suspenso por inasistencia
('ESO2-MAT', 'MAT-ENZ2-ESO2', '1ª Evaluación', 3.50), -- Suspenso severo
('ESO2-FQ',  'MAT-ENZ2-ESO2', '1ª Evaluación', 4.00); -- Suspenso
