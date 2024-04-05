SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    MAX(f.release_year) AS last_movie_year,
    (CURRENT_DATE - MAX(f.release_year)) AS years_since_last_movie
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
GROUP BY 
    a.actor_id, a.first_name, a.last_name
ORDER BY 
    years_since_last_movie DESC;
