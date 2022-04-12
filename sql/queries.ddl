/*query 1 
Написать запрос, получающий список всех рейсов с городом отправления, 
городом прибытия и общим временем в пути
*/
select flight_id, 
	cityname as departure, 
	cities[array_length(cities,1)] as arrival,
	ArrivalDate-DepartureDate+1 as trip_time from busflight;







/*query 2 
Написать запрос, который по заданной дате, 
городу отправления и городу прибытия выведет список возможных рейсов, 
количество остановок и общее время между этими городами
*/


WITH myconstants (city1, city2, dep_date) as (
   values ('NYC', 'Boston', '2000-01-01'::DATE)
)
select flight_id, 
		city1 as city_from,
		city2 as city_to,
        departuredate, 
        cities,
		array_position(cities, city2)-array_position(cities, city1) as stops_count, 
        array_position(cities, city2)-array_position(cities, city1) as trip_time 
from myconstants,
	busflight 
where array_position(cities, city1) < array_position(cities, city2)
and flight_id=(
  			SELECT flight_fk from citytoflight, myconstants
            where transitdate=dep_date and city_fk=(
            select city_id from city,myconstants
            WHERE cityname=city1)
);







/*query 3
Написать запрос, которые по заданной дате, 
городу отправления и городу прибытия выведет нумерованный список промежуточных городов: 
№ остановки, 
город,
время прибытия, 
время отбытия (включая конечную и начальную точки).
*/



WITH myconstants (city1, city2, dep_date) as (
   values ('NYC', 'Chicago', '2000-01-01'::DATE)
)

select 
       UNNEST(cities[array_position(cities, city1): array_position(cities, city2)]),
       
		array_position(cities, city2)-array_position(cities, city1) as stops_count, 
        array_position(cities, city2)-array_position(cities, city1) as trip_time 
from busflight,
    myconstants
where array_position(cities, city1) < array_position(cities, city2)
and flight_id=(
  			SELECT flight_fk from citytoflight, myconstants
            where transitdate=dep_date and city_fk=(
            select city_id from city,myconstants
            WHERE cityname=city1)
);





create TABLE if NOT EXISTS temp1 as (WITH myconstants (city1, city2, dep_date) as (
   values ('NYC', 'Chicago', '2000-01-01'::DATE)
)

select transitdate from citytoflight, myconstants
WHERE flight_fk=(
  			SELECT flight_fk from citytoflight, myconstants
            where transitdate=dep_date and city_fk=(
            select city_id from city,myconstants
            WHERE cityname=city1)
)
and transitdate >= dep_date
limit (
  select array_position(cities, city2)-array_position(cities, city1)
  from busflight,myconstants
  WHERE flight_id=(
              SELECT flight_fk from citytoflight, myconstants
              where transitdate=dep_date and city_fk=(
              select city_id from city,myconstants
              WHERE cityname=city1)
  )
));

SELECT * from temp1;
