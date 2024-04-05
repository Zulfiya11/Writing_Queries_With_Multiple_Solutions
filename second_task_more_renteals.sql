SELECT 
    film.film_id,
    film.title,
    COUNT(rental.rental_id) AS rental_count,
    film.rating AS expected_age
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    film.film_id, film.title, film.rating
ORDER BY 
    rental_count DESC
LIMIT 5;
