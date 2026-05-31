-- CASO DE ESTUDIO 19: DMITRY SOKOLOV (INCORPORACIÓN TARDÍA POR REFUGIO Y BARRERA IDIOMÁTICA)
-- Archivo: alumno_19_refugiado.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Olga Sokolova)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP019', 'Olga Sokolova', NULL, '600190011', NULL, 'olga.sokolova@email.com', NULL, 'Rúa Hospital 30, 2º Izq, CP 15002, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan ingresos bajos por empleo precario de inmersión y estudios universitarios de origen)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP019', '2025-09-12', 11500.00, true, 'Estudios Universitarios', NULL, 1, 2); -- Encuesta al matricularse en 1º ESO

-- 3. Expediente del Estudiante (Usa NIE extranjero por realismo de inmersión)
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2016019', 'Y99887766R', 'Dmitry Sokolov', '2013-02-12', 'dmitry.sokolov@alumno.com', 'RESP019');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2016019', '2025-09-02', 1, 'ESO-GEN', 'I006'); -- Admitido extraordinariamente en 1º ESO en IES Ramón Menéndez Pidal (Zalaeta)

-- 5. Historial Longitudinal de Matrículas Anuales (Incorporación directa en Secundaria en el curso actual)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Secundaria - ESO (IES Ramón Menéndez Pidal - Zalaeta)
('MAT-DMIT-ESO1', '2025-09-03', '2025/2026', 'EXP2016019', 'I006', 1, 'ESO-GEN'); -- 1º ESO (Curso actual, primer año en España)

-- 6. Adaptación Curricular / Apoyo Lingüístico (Plan de acogida lingüística por barrera idiomática absoluta en ESO)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP019', '2025-10-15', 'Apoyo Lingüístico - Inmersión Vehicular', 'Se activa Plan de Acogida y Apoyo Lingüístico de inmersión para estudiante refugiado de incorporación tardía con barrera idiomática absoluta (gallego/castellano escrito). Recibe 6 horas semanales de inmersión lingüística en aula de acogida y flexibilización visual de contenidos y pruebas.', 'EXP2016019');

-- Relacionamos la adaptación con las asignaturas de 1º de ESO con mayor carga teórica-verbal
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP019', 'ESO1-LCL'),
('ADAP019', 'ESO1-GH'),
('ADAP019', 'ESO1-BG');

-- 7. Historial de Calificaciones
-- A. 1º ESO - CURSO ACTUAL (2025/2026 - Extrema asimetría en 1ª Ev: colapso en letras por idioma y notable alto en ciencias numéricas)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-DMIT-ESO1', false), -- Lengua Castellana
('ESO1-GH',  'MAT-DMIT-ESO1', false), -- Geografía e Historia
('ESO1-BG',  'MAT-DMIT-ESO1', false), -- Biología y Geología
('ESO1-MAT', 'MAT-DMIT-ESO1', false); -- Matemáticas (No verbal)

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-DMIT-ESO1', '1ª Evaluación', 2.00), -- Suspenso severo por barrera idiomática total
('ESO1-GH',  'MAT-DMIT-ESO1', '1ª Evaluación', 2.50), -- Suspenso severo por imposibilidad de redactar en textos conceptuales
('ESO1-BG',  'MAT-DMIT-ESO1', '1ª Evaluación', 3.00), -- Suspenso por vocabulario técnico incomprensible
('ESO1-MAT', 'MAT-DMIT-ESO1', '1ª Evaluación', 8.00); -- Notable alto (demuestra excelentes competencias matemáticas abstractas)
