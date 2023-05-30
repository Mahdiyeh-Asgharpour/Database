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
--*8
select film.title ,actor.first_name,actor.last_name
from actor
inner join film_actor on  actor.actor_id=film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
where film.film_id=(select film.film_id from film inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
inner join film_category on film.film_id =film_category.film_id
inner join category on  category.category_id=film_category.category_id
 where actor.first_name='Sandra' and actor.last_name='Peck'and  category.name='Action')	and 
 actor.first_name!='Sandra' and actor.last_name!='Peck'
 
--9*
select film.title ,film.length
from film
inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
where film.film_id=(select film.film_id from film inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
 where actor.first_name='Sandra' and actor.last_name='Peck')	and 
 actor.first_name='Ralph' and actor.last_name='Cruz'
--10*
select film.title ,film.length
from film
inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
where film.film_id=(select film.film_id from film inner join film_actor on  film.film_id=film_actor.film_id
inner join actor on actor.actor_id = film_actor.actor_id
 where actor.first_name!='Sandra' and actor.last_name!='Peck')	and 
 actor.first_name!='Ralph' and actor.last_name!='Cruz'and film.length>100
--11
select public.language.name,count(film.film_id)
from public.language
full join film on film.language_id =public.language.language_id
group by(public.language.language_id);
--12*
select customer.first_name as first_name,customer.last_name as last_name,
customer.first_name as first_name2,customer.last_name as last_name2
from customer
join address on address.address_id=customer.address_id
where 
--13*
select count(film.rental_rate),film.title
from film
group by film.title
order by(count(film.rental_rate)) desc
limit 1

--14

--15*
select distinct film.title
from film
join inventory on film.film_id=inventory.film_id
join store on store.store_id=inventory.store_id
where  store.store_id!=1
intersect
select distinct film.title
from film
join inventory on film.film_id=inventory.film_id
join store on store.store_id=inventory.store_id
where  store.store_id!=2
