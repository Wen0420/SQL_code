#1. List the top five genres in gross revenue in descending order. 
select * from category;
use sakila;
SELECT c.name as "Genre", SUM(p.amount)
FROM category c 
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#2.In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
-- view是将底层的table 进行一个连接
CREATE VIEW top_five_revenue_generating_genres AS 
	SELECT c.name as "Genre", SUM(p.amount)
	FROM category c 
	INNER JOIN film_category fc ON c.category_id = fc.category_id
	INNER JOIN film f ON fc.film_id = f.film_id
	INNER JOIN inventory i ON f.film_id = i.film_id
	INNER JOIN rental r ON i.inventory_id = r.inventory_id
	INNER JOIN payment p ON r.rental_id = p.rental_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;  
    
 #3. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
 #更改！更新
    
    UPDATE actor 
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' 
AND last_name = 'WILLIAMS';

#4. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
UPDATE actor 
SET first_name = (
		CASE WHEN first_name = 'HARPO' 
		THEN 'GROUCHO' 
		ELSE 'MUCHO GROUCHO'
        END
	)
 WHERE actor_id = 172;
 
 #5.Use subqueries to display all actors who appear in the film Alone Trip.
 
 SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN
	(SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (SELECT film_id FROM  film WHERE title = 'Alone Trip')
    );
    
    #法二
    select a.first_name, a.last_name
    from actor a 
    join film_actor b on a.actor_id = b.actor_id
    join film c on b.film_id = c.film_id
    where title = 'Alone Trip';
    
    #6. Write a query to display how much business, in dollars, each store brought in.
  
  SELECT SUM(p.amount), s.store_id
FROM payment p 
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN staff s ON r.staff_id = s.staff_id
INNER JOIN store st ON s.store_id = st.store_id
GROUP BY s.store_id;

#7. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT c.first_name, c.last_name, c.email
FROM customer c INNER JOIN address a ON c.address_id = a.address_id
	INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

#8. Which film categories are long?

select category.name, avg(length)
from film join film_category using (film_id) join category using (category_id)
group by category.name
having avg(length) > (select avg(length) from film)
order by avg(length) desc;

#老师做的
set @avg_length = (select avg(length) from film);
select @avg_length;
select category.name, avg(length)
from film 
join film_category using (film_id) 
join category using (category_id)
group by category.name
having avg(length) > @avg_length
order by avg(length) desc;



