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
--*4  16 tas byad 17 ta bshe
select category.name,count(film.film_id)
from category
inner join film_category on  category.category_id=film_category.category_id
inner join film on film.film_id =film_category.film_id
group by(category.category_id);
--*5 kar nmikone
select category.name,count(film.film_id)
from category
inner join film_category on  category.category_id=film_category.category_id
inner join film on film.film_id =film_category.film_id
where count(film.film_id)>=1
group by(category.category_id);