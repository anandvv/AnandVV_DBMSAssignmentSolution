create database TravelOnTheGo;

use TravelOnTheGo;

CREATE TABLE passenger(
	passenger_name varchar(50),
    category varchar(20),
    gender varchar(1),
    boarding_city varchar(50),
    destination_city varchar(50),
    distance int,
    bus_type varchar(20)
);

CREATE TABLE price(
	bus_type varchar(20),
    distance int,
    price int
);

INSERT INTO passenger values('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT INTO passenger values('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT INTO passenger values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT INTO passenger values('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT INTO passenger values('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');
INSERT INTO passenger values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
INSERT INTO passenger values('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');
INSERT INTO passenger values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
INSERT INTO passenger values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO price values('Sleeper', 350, 770);
INSERT INTO price values('Sleeper', 500, 1100);
INSERT INTO price values('Sleeper', 600, 1320);
INSERT INTO price values('Sleeper', 700, 1540);
INSERT INTO price values('Sleeper', 1000, 2200);
INSERT INTO price values('Sleeper', 1200, 2640);
INSERT INTO price values('Sleeper', 1500, 2700);
INSERT INTO price values('Sitting', 500, 620);
INSERT INTO price values('Sitting', 600, 744);
INSERT INTO price values('Sitting', 700, 868);
INSERT INTO price values('Sitting', 1000, 1240);
INSERT INTO price values('Sitting', 1200, 1488);
INSERT INTO price values('Sitting', 1500, 1860);

/*How many females and how many male passengers travelled for a minimum distance of 600 KMs? */
select count(passenger_name) as NoOfTravelers, gender from passenger
where distance >=600
group by gender;

/* Find the minimum ticket price for Sleeper Bus */
select min(price) as MinTicketPriceForSleeperBus from price where bus_type='Sleeper';

/*Select passenger names whose names start with character 'S' */
select passenger_name from passenger where passenger_name like 'S%';

/*Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */
select PA.passenger_name as 'Passenger Name', PA.boarding_city as 'Boarding City', PA.destination_city as 'Destination City', PA.bus_type as Bus_Type, PR.price as Price
from passenger PA
inner join price PR
on PA.bus_type = PR.bus_type AND PA.distance = PR.distance;
 
/*What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s */
select PA.passenger_name as 'Passenger Name', PR.price as Price
from passenger PA 
inner join price PR
on PA.bus_type = PR.bus_type AND PA.distance = PR.distance
where PA.bus_type = 'Sitting' and PA.distance = 1000;

/*What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji? */

select PR.bus_type, PR.price
from price PR
inner join (select distance from passenger
where (boarding_city = 'Panaji' and destination_city = 'Bengaluru') OR (boarding_city = 'Bengaluru' and destination_city = 'Panaji')
limit 1) IT
on PR.distance = IT.distance;

/*List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */
select distinct distance from passenger order by distance desc;

/*Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables */
select 
	passenger_name as 'Passenger Name', 
	distance/(select SUM(distance) as total_distance from passenger)*100 as '% Distance Traveled'
from passenger;

/*
Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
select distance, price,
	case 
		when price > 1000 then 'Expensive'
		when price > 500 and price < 1000 then 'Average Cost'
		else 'Cheap'
	end as Price_Category
from price;
