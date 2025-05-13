peliculas.sql
/*act 1 */
SELECT film.title, address.address, city.city, country.country
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN store ON inventory.store_id = store.store_id
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE rental.return_date IS NULL;

/*act 2 */
SELECT film.title, category.name, language.name, film.rating, film.length
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN language ON film.language_id = language.language_id
WHERE film.length >= 60 AND film.length <= 120;

/*act 3 */
SELECT first_name,last_name, address,city, country
FROM staff s
INNER JOIN address a ON a.address_id =s.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;



/*act 4 */
SELECT film.title, MIN(rental.return_date), MAX(rental.return_date)
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title;




/*act 5 */
SELECT film.title, category.name, language.name, film.rating, film.length, 
       rental.rental_date, rental.return_date, 
       customer.first_name, customer.last_name, 
       address.address, city.city, country.country, 
       staff.first_name, staff.last_name
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN language ON film.language_id = language.language_id
INNER JOIN store ON inventory.store_id = store.store_id
INNER JOIN staff ON store.manager_staff_id = staff.staff_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id

/*ACT 6*/

SELECT COUNT(*) , rating from film 
GROUP BY rating

/*ACT 7*/
SELECT COUNT(title) as "cantidad de peliculas por categortia ",c.name 
FROM film f
INNER join film_category fc on fc.film_id = f.film_id
INNER join category c on fc.category_id = c.category_id
GROUP BY c.name

/*ACT 8*/
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS appearances
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY appearances DESC
limit 10;

/*act 9 */
SELECT 
    a.address, 
    ci.city, 
    co.country, 
    COUNT(i.inventory_id) AS total_inventory
FROM inventory i
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY a.address, ci.city, co.country
ORDER BY total_inventory DESC;

/*act 10*/
SELECT 
    CONCAT(a.address, ', ', c.city, ', ', co.country) AS local_direccion,
    COUNT(DISTINCT i.film_id) AS cantidad_peliculas_distintas
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
GROUP BY local_direccion;

/*act 11*/
SELECT
    cat.name AS categoria,
    AVG(f.rental_rate) AS costo_promedio_alquiler
FROM ategory cat
JOIN ilm_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cat.name;

--ACT 12

    

    
para mí
SELECT 
    r.rental_date AS fecha_alquiler,
    r.return_date AS fecha_devolucion,
    SUM(rental_duration * rental_rate),
    f.rental_rate AS costo_total
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ALABAMA DEVIL'
ORDER BY r.rental_date DESC;
--ACT 13
SELECT 
    f.title AS nombre_pelicula,
    f.length AS duracion,
    c.name AS categoria
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
ORDER BY 
    f.length DESC;
--ACT 14
SELECT 
    f.title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    f.title LIKE 'W%'
GROUP BY 
    f.film_id
HAVING 
    COUNT(fa.actor_id) >= 5;

--ACT 15
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_pagado
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id;

--ACT 16
SELECT 
    f.title AS nombre_pelicula,
    f.length AS duracion,
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor a ON fa.actor_id = a.actor_id
WHERE 
    f.length = (SELECT MIN(length) FROM film);

--ACT 17
SELECT 
    cu.last_name,
    a.address,
    ci.city,
    co.country,
    r.rental_id,
    p.payment_id,
    p.amount
FROM 
    customer cu
JOIN 
    address a ON cu.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
LEFT JOIN 
    rental r ON cu.customer_id = r.customer_id
LEFT JOIN 
    payment p ON cu.customer_id = p.customer_id
ORDER BY 
    p.amount ASC;

--ACT 18
INSERT INTO actor (first_name, last_name, last_update)
VALUES ('TuNombre', 'TuApellido', NOW());

--ACT 19
INSERT INTO actor (first_name, last_name, last_update)
VALUES 
('Amigo1', 'Apellido1', NOW()),
('Amigo2', 'Apellido2', NOW());

--ACT 20
UPDATE actor
SET first_name = 'Tom', last_name = 'Cruise', last_update = NOW()
WHERE actor_id = 201;

UPDATE actor
SET first_name = 'Emma', last_name = 'Watson', last_update = NOW()
WHERE actor_id = 202;

UPDATE actor
SET first_name = 'Leonardo', last_name = 'DiCaprio', last_update = NOW()
WHERE actor_id = 203;

--ACT 21
DELETE FROM actor
WHERE (first_name = 'Tom' AND last_name = 'Cruise')
   OR (first_name = 'Emma' AND last_name = 'Watson')
   OR (first_name = 'Leonardo' AND last_name = 'DiCaprio');
