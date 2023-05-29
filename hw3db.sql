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
--9
--10
--11
select public.language.name,count(film.film_id)
from public.language
full join film on film.language_id =public.language.language_id
group by(public.language.language_id);
--12*
select customer.first_name,customer.last_name,address.address
from address
join customer on address.address_id=customer.address_id
where 
--13
--14
--15