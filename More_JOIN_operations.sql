-- 1.List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962
 
-- 2. Give year of 'Citizen Kane'.

select yr from movie
where title='Citizen Kane'


-- 3.List all of the Star Trek movies, include the id, title and yr
-- (all of these movies include the words Star Trek in the title). Order results by year.

select id, title, yr from movie
where title like '%Star Trek%'
order by yr


-- 4. What id number does the actor 'Glenn Close' have?

select id from actor
where name='glenn close'


-- 5. What is the id of the film 'Casablanca'

select id from movie
where title='casablanca'


-- 6. Obtain the cast list for 'Casablanca'.

select name from casting join actor on (actorid=id)
where movieid = 11768


-- 7. Obtain the cast list for the film 'Alien'

select name from (casting join actor on (actorid=actor.id)) join movie on (movieid=movie.id)
where title='alien'


-- 8. List the films in which 'Harrison Ford' has appeared

select distinct title from (movie join casting on (movie.id=movieid)) join actor on (actorid=actor.id)
where name='Harrison Ford'


-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
-- [Note: the ord field of casting gives the position of the actor.
-- If ord=1 then this actor is in the starring role]

select distinct title from (movie join casting on (movie.id=movieid)) join actor on (actorid=actor.id)
where name='Harrison Ford' and ord!= 1


-- 10. List the films together with the leading star for all 1962 films.

select distinct title, name from (movie join casting on (movie.id=movieid)) join actor on (actorid=actor.id)
where ord=1 and yr=1962


-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies
-- he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2


-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

select title, name from casting
join movie on (movieid=movie.id)
join actor on (actorid=actor.id)
where  movieid in (
select distinct(movieid) from casting join actor on (actorid=id)
where name='Julie Andrews')
and ord=1


-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

select distinct name from actor join casting on (id=actorid)
where ord=1
group by name
having count(*) >=30
order by name


-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

select title, count(distinct actorid) from movie join casting on (id=movieid)
where yr=1978
group by title
order by  count(distinct actorid) desc, title


-- 15. List all the people who have worked with 'Art Garfunkel'.

select distinct name from casting join actor on (actorid = id)
where movieid  in (
select distinct movieid from casting join actor on (actorid=id)
where name='Art Garfunkel'
)
and name !='Art Garfunkel'
order by name
