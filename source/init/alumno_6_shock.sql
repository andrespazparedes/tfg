-- CASO DE ESTUDIO 6: IAGO BLANCO VEIGA (SHOCK SOCIOFAMILIAR - CAÍDA ABRUPTA EN ESO)
-- Archivo: alumno_6_shock.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsable Legal (Elena Veiga Blanco y Santiago Blanco Otero)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP006', 'Elena Veiga Blanco', 'Santiago Blanco Otero', '600060011', '600060022', 'elena.veiga@email.com', 'santiago.blanco@email.com', 'Rúa Galicia 16, 6º Izq, CP 15008, A Coruña', true);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan caída drástica de ingresos y monoparentalidad sobrevenida)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP006', '2015-09-10', 32000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 1, 4), -- Encuesta en Infantil (Estable)
('RESP006', '2021-09-10', 31000.00, true, 'Estudios Secundarios', 'Estudios Secundarios', 2, 4), -- Encuesta en Primaria (Estable)
('RESP006', '2025-09-10', 12500.00, true, 'Estudios Secundarios', NULL, 1, 3); -- Encuesta en ESO (Desempleo y divorcio, monoparental)

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015006', '33445566F', 'Iago Blanco Veiga', '2012-09-18', 'iago.blanco@alumno.com', 'RESP006');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015006', '2015-06-12', 1, 'INF-GEN', 'C005'), -- Admitido en Infantil en CEIP Ramón de la Sagra
('EXP2015006', '2024-07-05', 1, 'ESO-GEN', 'I001'); -- Admitido en ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Historial brillante y descalabro al entrar en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Infantil (CEIP Ramón de la Sagra)
('MAT-IAGO-INF3', '2017-09-01', '2017/2018', 'EXP2015006', 'C005', 3, 'INF-GEN'), -- 3º Infantil
-- Educación Primaria (CEIP Ramón de la Sagra)
('MAT-IAGO-PRI1', '2018-09-03', '2018/2019', 'EXP2015006', 'C005', 1, 'PRI-GEN'), -- 1º Primaria
('MAT-IAGO-PRI6', '2023-09-01', '2023/2024', 'EXP2015006', 'C005', 6, 'PRI-GEN'), -- 6º Primaria (Fin de Primaria Excelente)
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-IAGO-ESO1', '2024-09-02', '2024/2025', 'EXP2015006', 'I001', 1, 'ESO-GEN'), -- 1º ESO (Momento del shock / Divorcio)
('MAT-IAGO-ESO2', '2025-09-01', '2025/2026', 'EXP2015006', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual con arrastres)

-- 6. Historial de Calificaciones
-- A. 3º INFANTIL (2017/2018 - Rendimiento excelente)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('INF3-CRE', 'MAT-IAGO-INF3', false), ('INF3-DES', 'MAT-IAGO-INF3', false), ('INF3-COM', 'MAT-IAGO-INF3', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('INF3-CRE', 'MAT-IAGO-INF3', 'Final Ordinaria', 9.00),
('INF3-DES', 'MAT-IAGO-INF3', 'Final Ordinaria', 9.50),
('INF3-COM', 'MAT-IAGO-INF3', 'Final Ordinaria', 9.00);

-- B. 1º PRIMARIA (2018/2019)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI1-LCL', 'MAT-IAGO-PRI1', false), ('PRI1-MAT', 'MAT-IAGO-PRI1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI1-LCL', 'MAT-IAGO-PRI1', 'Final Ordinaria', 9.00),
('PRI1-MAT', 'MAT-IAGO-PRI1', 'Final Ordinaria', 9.50);

-- C. 6º PRIMARIA (2023/2024 - Cierra la etapa con un rendimiento brillante de sobresalientes)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-IAGO-PRI6', false), ('PRI6-MAT', 'MAT-IAGO-PRI6', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-IAGO-PRI6', 'Final Ordinaria', 9.00),
('PRI6-MAT', 'MAT-IAGO-PRI6', 'Final Ordinaria', 9.50);

-- D. 1º ESO (2024/2025 - Momento del shock: caída de notas y dos suspensos finales en junio)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-IAGO-ESO1', false), ('ESO1-MAT', 'MAT-IAGO-ESO1', false), ('ESO1-ING', 'MAT-IAGO-ESO1', false), ('ESO1-GH', 'MAT-IAGO-ESO1', false);
INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-IAGO-ESO1', 'Final Ordinaria', 6.00),
('ESO1-GH',  'MAT-IAGO-ESO1', 'Final Ordinaria', 5.00),
('ESO1-MAT', 'MAT-IAGO-ESO1', 'Final Ordinaria', 4.00), -- Suspenso en Matemáticas
('ESO1-ING', 'MAT-IAGO-ESO1', 'Final Ordinaria', 4.50); -- Suspenso en Inglés

-- E. 2º ESO - CURSO ACTUAL (2025/2026 - Arrastra las pendientes y suspende las nuevas de 2º en 1ª Ev.)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-IAGO-ESO2', false), 
('ESO2-MAT', 'MAT-IAGO-ESO2', false), 
('ESO2-FQ',  'MAT-IAGO-ESO2', false), 
('ESO1-MAT', 'MAT-IAGO-ESO2', true),  -- Arrastra Matemáticas de 1º (Pendiente)
('ESO1-ING', 'MAT-IAGO-ESO2', true);  -- Arrastra Inglés de 1º (Pendiente)

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-IAGO-ESO2', '1ª Evaluación', 5.00),
('ESO2-MAT', 'MAT-IAGO-ESO2', '1ª Evaluación', 3.50), -- Suspenso en matemáticas de 2º
('ESO2-FQ',  'MAT-IAGO-ESO2', '1ª Evaluación', 3.00), -- Suspenso en Física y Química
('ESO1-MAT', 'MAT-IAGO-ESO2', '1ª Evaluación', 3.00), -- Sigue sin superar la pendiente de 1º
('ESO1-ING', 'MAT-IAGO-ESO2', '1ª Evaluación', 4.00); -- Sigue sin superar la pendiente de 1º
