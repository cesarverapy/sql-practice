-- Consulta 1: Selección de las columnas DisplayName, Location y Reputation de los usuarios con mayor reputación
-- Explicación: Esta consulta recupera los primeros 200 usuarios basados en la reputación y los ordena en orden descendente de su reputación.
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

-- Consulta 2: Selección del título de las publicaciones junto con el DisplayName de los usuarios que las publicaron
-- Explicación: Esta consulta une las tablas Posts y Users para obtener el título de las publicaciones junto con el nombre del usuario que las publicó.
SELECT p.Title, u.DisplayName
FROM Posts p
JOIN Users u ON p.OwnerUserId = u.Id;

-- Consulta 3: Calcular el puntaje promedio de las publicaciones por cada usuario
-- Explicación: Esta consulta calcula el puntaje promedio de las publicaciones para cada usuario y agrupa los resultados por el nombre del usuario.
SELECT u.DisplayName, AVG(p.Score) AS AverageScore
FROM Posts p
JOIN Users u ON p.OwnerUserId = u.Id
GROUP BY u.DisplayName;

-- Consulta 4: Encontrar usuarios que han hecho más de 100 comentarios
-- Explicación: Esta consulta encuentra a los usuarios que han hecho más de 100 comentarios utilizando una subconsulta que cuenta los comentarios para cada usuario.
SELECT u.DisplayName
FROM Users u
WHERE (SELECT COUNT(*) FROM Comments c WHERE c.UserId = u.Id) > 100;

-- Consulta 5: Actualizar la columna Location a "Desconocido" para valores vacíos
-- Explicación: Esta consulta actualiza la columna Location a 'Desconocido' donde es NULL o está vacía.
UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';

-- Consulta 6: Eliminar comentarios hechos por usuarios con menos de 100 de reputación
-- Explicación: Esta consulta elimina los comentarios hechos por usuarios con una reputación menor a 100.
DELETE FROM Comments
WHERE UserId IN (SELECT Id FROM Users WHERE Reputation < 100);

-- Consulta 7: Mostrar el número total de publicaciones, comentarios y medallas por cada usuario
-- Explicación: Esta consulta muestra el número total de publicaciones, comentarios y medallas por cada usuario utilizando subconsultas para contar cada tipo.
SELECT u.DisplayName, 
       (SELECT COUNT(*) FROM Posts p WHERE p.OwnerUserId = u.Id) AS TotalPosts,
       (SELECT COUNT(*) FROM Comments c WHERE c.UserId = u.Id) AS TotalComments,
       (SELECT COUNT(*) FROM Badges b WHERE b.UserId = u.Id) AS TotalBadges
FROM Users u;

-- Consulta 8: Mostrar las 10 publicaciones más populares basadas en el puntaje
-- Explicación: Esta consulta selecciona las 10 publicaciones más populares basadas en el puntaje y las ordena en orden descendente de su puntaje.
SELECT TOP 10 Title, Score
FROM Posts
ORDER BY Score DESC;

-- Consulta 9: Mostrar los 5 comentarios más recientes
-- Explicación: Esta consulta selecciona los 5 comentarios más recientes basados en su fecha de creación y los ordena en orden descendente de su fecha de creación.
SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;
