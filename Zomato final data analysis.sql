Create Database Zomato;
use zomato;
Drop table zomatodata;
CREATE TABLE `zomatodata` (`RestaurantID` int DEFAULT NULL,`RestaurantName` text,`CountryCode` int DEFAULT NULL,`City` text,`Address` text,
`Locality` text,`LocalityVerbose` text,`Longitude` double DEFAULT NULL,`Latitude` double DEFAULT NULL,`Cuisines` text,`Currency` text,`Has_Table_booking` text,
`Has_Online_delivery` text,`Is_delivering_now` text,`Switch_to_order_menu` text,`Price_range` int DEFAULT NULL,`Votes` int DEFAULT NULL,`Average_Cost_for_two` int DEFAULT NULL,
`Average rating` text,`Rating` int DEFAULT NULL,`Rating Range` text,`Datekey` text,`Countryname` text,`USD Rate` double DEFAULT NULL,
`USD (Cost)` double DEFAULT NULL,`Indian Rupees (Cost)` double DEFAULT NULL,`Year` int DEFAULT NULL,`Month Number` int DEFAULT NULL,`Month Name` text,
`Quarter` text,`Year-Month` text,`Weekday No` int DEFAULT NULL,`Weekday Name` text,`Financial Month` text,`Financial Quarter` text);

select @@secure_file_priv;

load data infile 'zomatodata.csv' into table zomatodata
fields terminated by ","
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

##kpi's

#create view Total_Cuisines as
SELECT COUNT(distinct Cuisines) as Total_Cuisines 
from zomatodata;

#CREATE VIEW Total_Currencys AS
SELECT COUNT(distinct Currency) as Total_Currencys 
from zomatodata;

#CREATE VIEW Total_Cities AS
SELECT COUNT(distinct city ) as Total_Cities
from zomatodata;

#CREATE VIEW Total_Votes AS
SELECT sum(votes) as Total_Votes
from zomatodata;

#CREATE VIEW Total_Countries AS
SELECT count(distinct Countryname) as Total_Countries
from zomatodata;

#CREATE VIEW Total_Restaurants AS
SELECT count( RestaurantName) as Total_Restaurants
from zomatodata;

#CREATE VIEW Total_Localities AS
SELECT count(distinct Locality) as Total_Localities
from zomatodata;

#CREATE VIEW Country_Names AS
SELECT distinct Countryname as Country_Names
from zomatodata;

#CREATE VIEW Average_rating AS
select round(avg(rating),2) AVG_rating 
from zomatodata;

#CREATE VIEW Online_Delivery_Avaliable AS
select Has_Online_delivery,concat(round(count(Has_Online_delivery)/100,1),"%")Percentage
from zomatodata
group by Has_Online_delivery;

#CREATE VIEW Table_Booking_avaliable AS
select Has_Table_booking,concat(round(count(Has_Table_booking)/100,1),"%")Percentage
from zomatodata
group by Has_Table_booking;

#CREATE VIEW Restaurant_distribution_By_Average_Ratings AS
select case when Rating<=2 then '0-2' when Rating<=3 then '2-3' when Rating<=4 then '3-4' when Rating<=5 then '4-5' end 
Rating_Range,count(restaurantid)No_Of_Restaurants
from zomatodata
group by Rating_range
order by Rating_range;

#CREATE VIEW Restaurant_Distribution_By_Average_Cost AS
select case when Average_Cost_for_two<=100 then '0-100' 
when Average_Cost_for_two<=500 then '100-500'  
when Average_Cost_for_two<=1000 then '500-1000' 
when Average_Cost_for_two>1000 then '>1000' 
end "Avg_Cost_For2",count(restaurantid)
from zomatodata
group by Avg_Cost_For2
order by Avg_Cost_For2;

#CREATE VIEW Number_of_Restaurant_By_Price_Range AS
select price_range,count(restaurantid)
from zomatodata
group by price_range;


#CREATE VIEW Top_10_Restaurant_Distribution_by_Cuisine_Type AS
select cuisines,count(restaurantname)
from zomatodata
group by cuisines
order by count(restaurantname) Desc
limit 10;

select * from average_rating;
select * from country_names;
select * from number_of_restaurant_by_price_range;
select * from online_delivery_avaliable;
select * from restaurant_distribution_by_average_cost;
select * from restaurant_distribution_by_average_ratings;
select * from table_booking_avaliable;
select * from top_10_restaurant_distribution_by_cuisine_type;
select * from total_cities;
select * from total_countries;
select * from total_cuisines;
select * from total_currencys;
select * from total_localities;
select * from total_restaurants;
select * from total_votes;

