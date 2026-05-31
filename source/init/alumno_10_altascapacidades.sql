-- CASO DE ESTUDIO 10: ENZO VARELA CASTRO (ALTAS CAPACIDADES CON SUBRENDIMIENTO POR DESMOTIVACIÓN)
-- Archivo: alumno_10_altascapacidades.sql
-- Ubicación: source/init/ (se ejecutará automáticamente en orden alfabético)

-- 1. Responsables Legales (Carlos Varela Méndez y Marta Castro Teijeiro)
-- NOTA: Se evitan terminantemente nombres o apellidos de privacidad restringida (Andrés, Paz, Paredes)
INSERT INTO RESPONSABLE_LEGAL (cod_responsable, nombre_1, nombre_2, telefono_1, telefono_2, email_1, email_2, direccion, monoparental) VALUES
('RESP010', 'Carlos Varela Méndez', 'Marta Castro Teijeiro', '600100011', '600100022', 'carlos.varela@email.com', 'marta.castro@email.com', 'Rúa Alfredo Vicenti 18, 5º A, CP 15004, A Coruña', false);

-- 2. Encuestas Socioeconómicas Históricas (Reflejan perfil socioeconómico alto y equipación tecnológica excelente)
INSERT INTO ENCUESTA (cod_responsable, fecha, ingresos, internet, nivel_estudios_1, nivel_estudios_2, num_ordenadores, num_integrantes) VALUES
('RESP010', '2021-09-10', 39000.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3), -- Encuesta en Primaria (coincidiendo con diagnóstico AACC)
('RESP010', '2025-09-12', 38500.00, true, 'Estudios Universitarios', 'Estudios Universitarios', 3, 3); -- Encuesta en ESO

-- 3. Expediente del Estudiante
INSERT INTO ESTUDIANTE (num_expediente, dni, nombre, fecha_nacimiento, email, cod_responsable) VALUES
('EXP2015010', '77889900J', 'Enzo Varela Castro', '2012-07-22', 'enzo.varela@alumno.com', 'RESP010');

-- 4. Admisiones Oficiales en los Centros de A Coruña
INSERT INTO ADMISION (num_expediente, fecha, num_curso, cod_especialidad, cod_centro) VALUES
('EXP2015010', '2021-06-18', 4, 'PRI-GEN', 'C002'), -- Admitido en 4º de Primaria en CEIP María Pita
('EXP2015010', '2024-07-03', 1, 'ESO-GEN', 'I001'); -- Admitido en 1º ESO en IES Eusebio da Guarda

-- 5. Historial Longitudinal de Matrículas Anuales (Trayectoria académica de AACC con descalabro motivacional en ESO)
INSERT INTO MATRICULA (cod_matricula, fecha, curso_academico, num_expediente, cod_centro, num_curso, cod_especialidad) VALUES
-- Educación Primaria (CEIP María Pita)
('MAT-ENZO-PRI4', '2021-09-01', '2021/2022', 'EXP2015010', 'C002', 4, 'PRI-GEN'), -- 4º Primaria
('MAT-ENZO-PRI5', '2022-09-02', '2022/2023', 'EXP2015010', 'C002', 5, 'PRI-GEN'), -- 5º Primaria
('MAT-ENZO-PRI6', '2023-09-01', '2023/2024', 'EXP2015010', 'C002', 6, 'PRI-GEN'), -- 6º Primaria
-- Educación Secundaria - ESO (IES Eusebio da Guarda)
('MAT-ENZO-ESO1', '2024-09-02', '2024/2025', 'EXP2015010', 'I001', 1, 'ESO-GEN'), -- 1º ESO
('MAT-ENZO-ESO2', '2025-09-01', '2025/2026', 'EXP2015010', 'I001', 2, 'ESO-GEN'); -- 2º ESO (Curso actual, subrendimiento)

-- 6. Adaptación Curricular / Enriquecimiento Curricular (Activada a finales de la 1ª Ev de 2º ESO ante la caída alarmante)
INSERT INTO ADAPTACION_CURRICULAR (cod_adaptacion, fecha, tipo, informe, num_expediente) VALUES
('ADAP010', '2025-11-20', 'Altas Capacidades - Enriquecimiento Curricular', 'Estudiante diagnosticado con Altas Capacidades Intelectuales. Presenta desafección y aburrimiento crónico en clase ordinaria debido a tareas repetitivas, reflejado en falta de entregas académicas en 2º ESO. Se activa plan de enriquecimiento avanzado, sustituyendo deberes ordinarios por proyectos de investigación y aprendizaje basado en proyectos en áreas instrumentales.', 'EXP2015010');

-- Relacionamos el plan de enriquecimiento con las asignaturas instrumentales donde Enzo flaquea en actitud
INSERT INTO ADAPTACION_ASIGNATURA (cod_adaptacion, cod_asignatura) VALUES
('ADAP010', 'ESO2-MAT'),
('ADAP010', 'ESO2-LCL');

-- 7. Historial de Calificaciones
-- A. 4º PRIMARIA (2021/2022 - Rendimiento excelente coincidiendo con diagnóstico de Altas Capacidades)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI4-LCL', 'MAT-ENZO-PRI4', false), 
('PRI4-MAT', 'MAT-ENZO-PRI4', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI4-LCL', 'MAT-ENZO-PRI4', 'Final Ordinaria', 9.00),
('PRI4-MAT', 'MAT-ENZO-PRI4', 'Final Ordinaria', 9.50);

-- B. 6º PRIMARIA (2023/2024 - Mantiene notas sobresalientes con plan de enriquecimiento activo)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('PRI6-LCL', 'MAT-ENZO-PRI6', false), 
('PRI6-MAT', 'MAT-ENZO-PRI6', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('PRI6-LCL', 'MAT-ENZO-PRI6', 'Final Ordinaria', 8.50),
('PRI6-MAT', 'MAT-ENZO-PRI6', 'Final Ordinaria', 9.00);

-- C. 1º ESO (2024/2025 - Caída a notable regular por falta de activación del plan de enriquecimiento en ESO)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO1-LCL', 'MAT-ENZO-ESO1', false), 
('ESO1-MAT', 'MAT-ENZO-ESO1', false);

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO1-LCL', 'MAT-ENZO-ESO1', 'Final Ordinaria', 7.00), -- Descenso por actitud/entrega
('ESO1-MAT', 'MAT-ENZO-ESO1', 'Final Ordinaria', 7.50); -- Descenso por actitud/entrega

-- D. 2º ESO - CURSO ACTUAL (2025/2026 - Paradoja: suspende instrumentales por no entregar deberes y arrasa en tecnología)
INSERT INTO ASIGNATURA_MATRICULA (cod_asignatura, cod_matricula, suspenso_curso_anterior) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2', false), -- Humanidades
('ESO2-MAT', 'MAT-ENZO-ESO2', false), -- Ciencias instrumentales
('ESO2-TEC', 'MAT-ENZO-ESO2', false); -- Tecnología/Digitalización

INSERT INTO LINEA_EXPEDIENTE (cod_asignatura, cod_matricula, evaluacion, nota) VALUES
('ESO2-LCL', 'MAT-ENZO-ESO2', '1ª Evaluación', 4.50), -- Suspenso por entrega cero de cuadernos semanales obligatorios
('ESO2-MAT', 'MAT-ENZO-ESO2', '1ª Evaluación', 4.00), -- Suspenso por entrega cero de tareas repetitivas, a pesar de sacar un 9.00 en los exámenes teóricos
('ESO2-TEC', 'MAT-ENZO-ESO2', '1ª Evaluación', 9.50); -- Sobresaliente al permitírsele liderar un proyecto libre de programación/robótica
