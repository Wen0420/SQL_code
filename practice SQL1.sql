show databases;
use sakila;
describe actor;
select * from actor limit 10;

#Which actors have the first name 'Scarlett'?
select *
from actor
where first_name = 'Scarlett';

#Which last names appear more than once?
select last_name, count (last_name) as last_name_count
from actor
group by last_name
having last_name_count > 1;

#How many total rentals occured in May?
describe rental;

select count(*)
from rental
where month(rental_date)=5;

#How many staff processed rentals in May?
select count(distinct staff_id)
from rental
where month(rental_date)=5;

#How many staff processed rentals by each staff in May?
select staff_id, count(*)
from rental
where month(rental_date)=5
group by staff_id;

#Which staff processed the most rentals in May?
select staff_id
from rental
where month(rental_date)=5;

#Find the movie that has at least 3 special features (film) 
select * from film
where special_features regexp '\\,\\w+\\,';

#Find the addresses which have a 3-digit number and a 5-character street name.
select address from adress
where address regexp '^\\d{3}\\s{1}\\w{5}\\s{1}';

#Find the word before 'who' in film description select description
select description, REGEXP_SUBSTR(description, '\\s{1}\\w+(?=\\swho)');


#Which staff processed the most rentals in May?
select staff_id
from rental
where month(rental_date)=5;

#How many staff processed rentals in May?
select count(distinct staff_id)
from rental 
where month(rental_date)=5;

#Which staff processed the most rentals in May?
select staff_id, count(*) as rental_count
from rental 
where month(rental_date) = 5
group by staff_id;

#Which customer paid the most rental in August?
select staff_id
from rental
where month(rental_date)=8;

#9.A summary of rental total amount by month.
select * from rental;
select * from payment;

select month(a.rental_date) as month_t, sum(b.amount) as month_1
from rental a
left join payment b
on a.rental_id = b.rental_id
group by month(a.rental_date)
order by 1;

#Which actor has appeared in the most films?
select * from actor;
select * from film_actor;


select a.actor_id, 
concat(b.first_name, '', b.last_name) as actor_name ,
count(distinct film_id) as count_movie
from film_ actor 
join actor b
on a.actor_id = b.actor_id
group by actor_id
order by count(film_id) desc;

#11.	Is ‘Academy Dinosaur’ available for rent from Store 1?
select * from film;
select* from store;
select* from inventory;
select *
from inventory a
left join film b
on a.film_id = b.film_id
where b.title = 'Academy Dinosaur'
and a.store_id = 1;

select * 
from rental a
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
join store d
on b.store_id = d.store_id
where '2005-05-25' not between rental_date and return_date
and c.title = 'Academy Dinosaur';

select * from film natural join inventory;

#rental amount 
select amount,
case when amount between 0 and 5 then 1
when amount between 6 and 10 then 2
else 3
end as amount_band
from payment;

#
select amount, if (amount>5, 'high', 'low') as high_low
from payment;

SELECT COUNT(DISTINCT customer_id) AS cust_no, 
CASE WHEN amount > 10 THEN 'high' ELSE 'low' 
END AS amount_band 
FROM payment GROUP BY 2;

CREATE TABLE unit ( amount FLOAT, unit VARCHAR(10) ); 
-- Insert values for columns INSERT into unit (amount, unit) values (120, 'kgs'), (11, 'jars'), (23.45, 'kgs'), (120, 'bottles') ; 
SELECT * FROM unit; 
 ALTER table unit add label varchar(30); 
 
 #practice lecture 2
 #1.	Which actors have the first name 'Scarlett'?
 select *
 from actor
 where first_name = 'Scarlett';
 
 #2.	Which actors have the last name 'Johansson'
 select *
 from actor
 where last_name = 'Johansson';
 
 #3.	How many distinct actors last names are there?
 select count(distinct last_name)
 from actor;
 
 #4. Which last names appear more than once?
 select count(last_name) as last_name_count
 from actor
 group by last_name
 having count(last_name)>1;
 
 #加了一题，Which last names are not repeated?
 select last_name
 from actor
 group by Last_name
 having count(*)=1;
 
 #5.	How many total rentals occured in May?
use sakila;
select * from rental;
select count(*)
from rental
where month(rental_date) = 5;

#6.	How many staff processed rentals in May?
select * from rental;
select count(distinct staff_id)
from rental
where month(rental_date)=5;

#附加题： how many rentals processed by each staff in may?
select count(rental_id), staff_id
from rental
where month (rental_date) = 5
group by staff_id;

#7.	Which staff processed the most rentals in May?做了几笔交易用count。
select *from rental limit 10;
select staff_id, count(*) as rental_count
from rental
where month(rental_date)=5
group by staff_id;

select month(last_update) from rental;
select monthname(last_update) from rental;

#8.Which customer paid the most rental in August?
select * from payment;
select customer_id, count(amount) as amount_count
from payment
group by customer_id
order by amount_count desc;

#9.A summary of rental total amount by month.
select * from payment; 
select month(payment_date) as month, count(amount) as amount
from payment 
group by month(payment_date)
order by month(payment_date);
#我做的是total payment amount

select * from rental;

select month(a.rental_date) as month_t, sum(b.amount) as amount_1
from rental a
left join payment b
on a.rental_id = b.rental_id
group by month(rental_date)
order by month(rental_date);
#这个才是total rental amount

#10.Which actor has appeared in the most films?
select * from actor;
select * from film_actor;

select actor_id, count(distinct film_id) as count_movie
from film_actor
group by actor_id
order by 2 desc;

#现在我们想要把演员的名字显示出来。 要用到join,这里我还想把first name 和last name 合并成一列。
select a.actor_id, concat(b.first_name, ' ' ,b.last_name) as actor_name, count(distinct film_id) as count_movie
from film_actor a
join actor b
on a.actor_id = b.actor_id
group by actor_id
order by 3 desc;


#11.Is ‘Academy Dinosaur’ available for rent from Store 1?
select * from inventory;
select * from film;
#which copies are at Store 1?
select *
from inventory a
left join film b
on a.film_id = b.film_id
where b.title = 'Academy Dinosaur'
and a.store_id =1;

#这部电影在五月25日的时候是不是available的？
select distinct c.film_id, c.title, a.rental_date, a.return_date, d.store_id
from rental a
join inventory b
on a.inventory_id = b.inventory_id
join film c
on b.film_id = c.film_id
join store d
on b.store_id = d.store_id
where '2005-05-25' between a.rental_date and a.return_date
and c.title = 'Academy Dinosaur';

#没有返回结果说明这天这部电影没有被借出。所以5月25号这天是available的。

#12.Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today.

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (NOW(), 1, 1, 1);
select rental_duration from film where film_id = 1;
select rental_id from rental order by rental_id desc limit 1;
select rental_date,
       rental_date + interval
                   (select rental_duration from film where film_id = 1) day
                   as due_date
from rental
where rental_id = (select rental_id from rental order by rental_id desc limit 1);


#14.What is that average running time of all the films in the sakila DB?
select avg(length) from film;

# What is the average length of films by category?

select category.name, avg(length)
from film join film_category using (film_id) join category using (category_id)
group by category.name
order by avg(length) desc;

# Which film categories are long?

select category.name, avg(length)
from film join film_category using (film_id) join category using (category_id)
group by category.name
having avg(length) > (select avg(length) from film)
order by avg(length) desc;

#Why does this query return the empty set?

select * from film natural join inventory;

use sakila;





















