/* 1. List each country name where the population is larger than that of 'Russia'. */
select name from world
where population > (select population from world where name='Russia')


/* 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

select name from world
where continent='europe'
and  gdp/population > (select gdp/population from world where name='united kingdom')


/* 3. Neighbours of Argentina and Australia */

select name, continent from world
where continent in (
select continent from world
where name in ('argentina', 'australia')
) 
order by name


/* 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population. */

select name, population from world
where population > (select population from world where name='canada') 
and population < (select population from world where name = 'poland')


/* 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. */

select name, concat(round(population/(select population from world where name='germany')*100), '%') from
world
where continent='europe'


/* 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] */
/* (Some countries may have NULL gdp values) */

select name from world
where gdp > all(select gdp from world where continent='europe' and gdp is not null)


/* 7. Find the largest country (by area) in each continent, show the continent, the name and the area: */

select x.continent, x.name, x.area from world as x
left join (select max(area) as maxarea, continent from world group by continent) as y
on x.continent = y.continent
where x.area = maxarea


/* 8. List each continent and the name of the country that comes first alphabetically. */

select continent, min(name) as minname from world
group by continent
order by continent


/* 9. Find the continents where all countries have a population <= 25000000. */
/* Then find the names of the countries associated with these continents. */
/* Show name, continent and population. */

select name, continent, population from world where 
continent in
(select continent from 
(
select continent, max(population) as pop from world
group by continent
) as t1
where pop <= 25000000
)


/* 10. Some countries have populations more than three times that of any of their */
/* neighbours (in the same continent). Give the countries and continents. */
  
select x.name, x.continent from world as x
where x.population / 3 > all(
select y.population from world as y
where x.continent = y.continent
and x.name != y.name
)
