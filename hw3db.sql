--1
select actor.first_name,actor.last_name,film.title
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id;
--2
select actor.first_name,actor.last_name,film.title
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
where actor.first_name='Rock' and actor.last_name='Dukakis' ;
--3
select actor.first_name,actor.last_name,count(film.film_id)
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
group by(actor.first_name ,actor.last_name );
--4 
select category.name,count(film.film_id)
from category
full join film_category on  category.category_id=film_category.category_id
full join film on film.film_id =film_category.film_id
group by(category.category_id);
--5
select category.name,count(film.film_id)
from category
 join film_category on  category.category_id=film_category.category_id
 join film on film.film_id =film_category.film_id
group by(category.category_id);
--6
select actor.actor_id,actor.first_name,actor.last_name,category.name,count(film.film_id)
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
inner join film_category on film.film_id =film_category.film_id
inner join category on  category.category_id=film_category.category_id
group by(actor.actor_id,category.name)
order by(actor.actor_id,category.name)
--7
select actor.actor_id,actor.first_name,actor.last_name
from actor
where actor.actor_id not in(select actor.actor_id
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
inner join film_category on film.film_id =film_category.film_id
inner join category on  category.category_id=film_category.category_id
where film.length>90 and category.name='Sci-Fi' and film.rating = 'PG-13'
) order by(actor.actor_id)
--8
with fi(value) as (select film_id from film_actor join actor on actor.actor_id = film_actor.actor_id
				   where actor.first_name = 'Sandra' and actor.last_name='Peck' )
select film.title ,actor.first_name,actor.last_name
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
inner join film_category on film.film_id =film_category.film_id
inner join category on  category.category_id=film_category.category_id
where  film.film_id  in(select film.film_id from film join film_category on film.film_id = film_category.film_id 
												 join category on category.category_id = film_category.category_id 
												 join fi on fi.value = film.film_id) and   category.name = 'Action'
and actor.first_name != 'Sandra' and actor.last_name!='Peck' 
 
 
--9
with fi(value) as (select film_id from film_actor join actor on actor.actor_id = film_actor.actor_id 
 where actor.first_name = 'Sandra' and actor.last_name='Peck' )
select distinct film.title ,film.length
from film
inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
where  film.film_id in(select film.film_id from film
 inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id 
  join fi on fi.value = film.film_id 
 where actor.first_name = 'Ralph' and actor.last_name='Cruz' )

--10
select distinct film.title ,film.length
from film
where film_id not in(
select  film.film_id
from film
inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
where actor.first_name= 'Ralph' and actor.last_name='Cruz')and film_id not in(select  film.film_id
from film
	inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
where actor.first_name = 'Sandra' and actor.last_name='Peck' )and film.length>100
 
--11
select public.language.name,count(film.film_id)q
from public.language
full join film on film.language_id =public.language.language_id
group by(public.language.language_id);
--12
select distinct customer1.first_name as first_name,customer1.last_name as last_name,
customer2.first_name as first_name_2,customer2.last_name as last_name_2
from customer as customer1,customer as customer2
where   customer1.address_id=customer2.address_id and customer1.customer_id!=customer2.customer_id
--13
SELECT COUNT(film.film_id), film.title 
FROM film 
JOIN inventory ON film.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
GROUP BY film.title 
ORDER BY COUNT(film.film_id) 
LIMIT 1 

--14
SELECT film.title 
FROM film 
JOIN inventory ON film.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
GROUP BY film.title 
HAVING COUNT(film.film_id) = ( 
    SELECT COUNT(film.film_id) 
    FROM film 
    JOIN inventory ON film.film_id = inventory.film_id 
    JOIN rental ON inventory.inventory_id = rental.inventory_id 
    GROUP BY film.title 
    ORDER BY COUNT(film.film_id) DESC 
    LIMIT 1 OFFSET 2 
)
--15
select distinct film.title
from film
where film_id not in(select film.film_id
					from film
					join inventory on film.film_id=inventory.film_id
join store on store.store_id=inventory.store_id
where  store.store_id=1
intersect
select film.film_id
from film
join inventory on film.film_id=inventory.film_id
join store on store.store_id=inventory.store_id
where  store.store_id=2
)
--1e
SELECT title, replacement_cost, rating,  
 (SELECT MIN(replacement_cost)  
     FROM film  
     WHERE film.rating = fi.rating) AS first_value 
FROM film AS fi 
ORDER BY fi.rating, fi.replacement_cost 
 --1e
SELECT title, replacement_cost, rating, 
       MIN(replacement_cost) OVER (PARTITION BY rating) AS first_value 
FROM film 
ORDER BY rating, replacement_cost 
--2e
SELECT title, rental_rate, rating, 
       RANK() OVER (PARTITION BY rating ORDER BY rental_rate DESC) AS rental_rank 
FROM film 
ORDER BY rating, rental_rate DESC
--2e