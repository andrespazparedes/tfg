-- CASO DE ESTUDIO 57: MATEO ROMERO CASTRO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO-ALTO)
-- Archivo: alumno_57_control_mateo.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Romero Otero y Ana Castro Gómez)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP057', 'Sergio Romero Otero', 'Ana Castro Gómez', '600570011', '600570022', 'sergio.romero.o@email.com', 'ana.castro.g@email.com', 'Rúa San Andrés 14, 2º B, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP057', '2024-09-08', 28000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3), -- Encuesta en Primaria
('RESP057', '2025-09-12', 28500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016057', '12345682D', 'Mateo Romero Castro', '2013-05-18', 'mateo.romero.c@alumno.com', 'RESP057');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016057', '2024-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016057', '2025-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MAT2-PRI6', '2024-09-02', '2024/2025', 'EXP2016057', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MAT2-ESO1', '2025-09-01', '2025/2026', 'EXP2016057', 'I001', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento notable)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MAT2-PRI6', false), ('PRI6-MAT', 'MAT-MAT2-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MAT2-PRI6', 'Final Ordinaria', 7.50),
('PRI6-MAT', 'MAT-MAT2-PRI6', 'Final Ordinaria', 7.50);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MAT2-ESO1', false), ('ESO1-MAT', 'MAT-MAT2-ESO1', false), ('ESO1-ING', 'MAT-MAT2-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MAT2-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-MAT', 'MAT-MAT2-ESO1', '1ª Evaluación', 7.00), -- Notable
('ESO1-ING', 'MAT-MAT2-ESO1', '1ª Evaluación', 7.50); -- Notable alto
