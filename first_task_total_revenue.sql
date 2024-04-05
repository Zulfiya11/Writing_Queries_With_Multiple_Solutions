SELECT s.store_id, 
       st.first_name || ' ' || st.last_name AS staff_name, 
       SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE EXTRACT(YEAR FROM p.payment_date) = 2017
GROUP BY s.store_id, st.first_name, st.last_name
HAVING SUM(p.amount) = (
    SELECT MAX(total_revenue) 
    FROM (
        SELECT s.store_id, 
               st.first_name || ' ' || st.last_name AS staff_name, 
               SUM(p.amount) AS total_revenue
        FROM store s
        JOIN staff st ON s.store_id = st.store_id
        JOIN payment p ON st.staff_id = p.staff_id
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        WHERE EXTRACT(YEAR FROM p.payment_date) = 2017
        GROUP BY s.store_id, st.first_name, st.last_name
    ) AS subquery
    WHERE subquery.store_id = s.store_id
)
ORDER BY s.store_id;
