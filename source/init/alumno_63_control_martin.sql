-- CASO DE ESTUDIO 63: MARTÍN ROMERO BLANCO (ALUMNO DE CONTROL / RENDIMIENTO MEDIO ESTABLE)
-- Archivo: alumno_63_control_martin.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Sergio Romero Otero y Laura Blanco Rey)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP063', 'Sergio Romero Otero', 'Laura Blanco Rey', '600630011', '600630022', 'sergio.romero3@email.com', 'laura.blanco.re3@email.com', 'Rúa San Andrés 88, 3º A, CP 15003, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos estables de clase media)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP063', '2024-09-08', 25000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria
('RESP063', '2025-09-12', 25500.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016063', '78901252C', 'Martín Romero Blanco', '2013-11-14', 'martin.romero@alumno.com', 'RESP063');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016063', '2024-06-15', 6, 'PRI-GEN', 'C001'), -- CEIP Emilia Pardo Bazán
('EXP2016063', '2025-07-03', 1, 'ESO-GEN', 'I001'); -- IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria
('MAT-MAR3-PRI6', '2024-09-02', '2024/2025', 'EXP2016063', 'C001', 6, 'PRI-GEN'),
-- Educación Secundaria
('MAT-MAR3-ESO1', '2025-09-01', '2025/2026', 'EXP2016063', 'I001', 1, 'ESO-GEN'); -- Curso actual

-- 6. Historial de Calificaciones
-- A. 6º PRIMARIA (2024/2025 - Rendimiento medio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-MAR3-PRI6', false), ('PRI6-MAT', 'MAT-MAR3-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-MAR3-PRI6', 'Final Ordinaria', 6.00),
('PRI6-MAT', 'MAT-MAR3-PRI6', 'Final Ordinaria', 6.00);

-- B. 1º ESO - CURSO ACTUAL (2025/2026 - 1ª Evaluación)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-MAR3-ESO1', false), ('ESO1-MAT', 'MAT-MAR3-ESO1', false), ('ESO1-ING', 'MAT-MAR3-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-MAR3-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-MAT', 'MAT-MAR3-ESO1', '1ª Evaluación', 6.00), -- Aprobado regular
('ESO1-ING', 'MAT-MAR3-ESO1', '1ª Evaluación', 6.50); -- Aprobado regular
