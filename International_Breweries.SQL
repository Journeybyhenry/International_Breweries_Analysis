--Creating the table headers
CREATE TABLE international_breweries (
	sales_id INTEGER,
	sales_rep TEXT, 
	emails TEXT,
	brands TEXT,
	plant_cost INTEGER,
	unit_price INTEGER,
	QUANTITY INTEGER,
	cost REAL,
	profit REAL,
	countries CHAR(14),
	region VARCHAR(14),
	months VARCHAR(14),
	years INTEGER,
PRIMARY KEY(sales_id));
--After creating the headers, we will then inport the csv file to populate the table

-- Adding a territory column & values to the table
ALTER TABLE international_breweries
ADD COLUMN territories TEXT;

UPDATE international_breweries
SET territories =
	CASE
		WHEN countries IN ('Nigeria', 'Ghana') THEN 'Anglophone'
		WHEN countries IN ('Benin', 'Senegal', 'Togo') THEN 'Francophone'
	END;
	
--Checking how many years data was provided
SELECT DISTINCT(years)
FROM international_breweries;

SELECT DISTINCT(countries)
FROM international_breweries;

--SECTION A
--Question 1
SELECT SUM(profit) AS profit_3years
FROM international_breweries;
--The profit made in 3 years was 1.0558744e+08

--Question 2
SELECT DISTINCT(territories), SUM(profit) AS territory_profit
FROM international_breweries
GROUP BY territories
ORDER BY territory_profit DESC;
--Output shows that the Francophone countries had higher sales compared to the Anglophones

--Question 3
SELECT DISTINCT(countries), SUM(profit) AS highest_profit
FROM international_breweries
WHERE years = 2019
GROUP BY countries 
ORDER BY highest_profit DESC
LIMIT 1;
--Output shows that Ghana made the highest profit in the year 2019

--Question 4
SELECT DISTINCT(years), SUM(profit) AS highest_profit
FROM international_breweries
GROUP BY years
ORDER BY highest_profit DESC
LIMIT 1;
--Output shows that maximum profit was made in the year 2017

--Question 5
SELECT DISTINCT(months), SUM(profit) AS least_profit
FROM international_breweries
GROUP BY months
ORDER BY least_profit
LIMIT 1;
--Output shows that the least profit was generated in the month of April

--Question 6
SELECT DISTINCT(months), MIN(profit) AS min_profit
FROM international_breweries
WHERE months = 'December' AND years= 2018
GROUP BY months;
--Output shows that the minimum profit in December 2018 was 38,150

--Question 7
SELECT 
	months, SUM(profit), 
	(SUM(profit)/(SELECT SUM(profit) 
	FROM international_breweries WHERE years= 2019)) * 100
	AS percent_profit
FROM international_breweries WHERE years= 2019
GROUP BY months 
--Output shows the percentage profit for each month in the year 2019

--Question 8
SELECT 
	brands, 
	SUM(profit) AS highest_profit
FROM international_breweries
WHERE countries = 'Senegal'
GROUP BY brands
ORDER BY highest_profit DESC
LIMIT 1;
--CASTLE LITE generated the highest profit in Senegal

--SECTION B
--QUESTION 1
SELECT 
	brands, 
	SUM(quantity) quantity_consumed
FROM international_breweries
WHERE territories = 'Francophone' AND years IN (2018,2019)
GROUP BY brands
ORDER BY 2 DESC
LIMIT 3;
--Output shows the top three brands consumed in the francophone countries

--QUESTION 2
SELECT
	brands,
	SUM(quantity) quantity_consumed
FROM international_breweries
WHERE countries = 'Ghana'
GROUP BY brands
ORDER BY 2 DESC
LIMIT 2;
--Eagle lager & Castle lite are the top two choice of consumer brands in Ghana

--QUESTION 3
SELECT 
	brands, SUM(Quantity) AS beer_consumed
FROM international_breweries
WHERE countries = 'Nigeria' AND brands NOT IN ('beta malt', 'grand malt')
GROUP BY brands
ORDER BY 2;
--Output gives detail of beers consumed in the most oil rich country

--QUESTION 4
SELECT 
	brands, SUM(Quantity) AS favorite_malt
FROM international_breweries
WHERE territories = 'Anglophone' AND brands IN ('beta malt', 'grand malt')
		AND years IN ('2018', '2019')
GROUP BY brands
ORDER BY favorite_malt DESC
LIMIT 1;
--The favorite malt in Anglophone countries within 2018 & 2019 was grand malt

--QUESTION 5
SELECT 
	brands, SUM(quantity) highest_sold
FROM international_breweries
WHERE years = 2019 and countries ='Nigeria'
GROUP BY brands
ORDER BY highest_sold DESC
LIMIT 1;
--Hero sold the highest in 2019 in Nigeria

--QUESTION 6
SELECT 
	brands, SUM(quantity) favorite_brand
FROM international_breweries
WHERE region = 'southsouth' and countries ='Nigeria'
GROUP BY brands
ORDER BY favorite_brand DESC
LIMIT 1;
--Favorites brand in South_South region in Nigeria was Eagle Lager

--QUESTION 7
SELECT 
	SUM(Quantity) AS beer_consumed
FROM international_breweries
WHERE countries = 'Nigeria' AND brands NOT IN ('beta malt', 'grand malt');
--Total beer consumed in Nigeria was 129,260

--QUESTION 8
SELECT 
	region, SUM(Quantity) AS bud_consumed
FROM international_breweries
WHERE countries = 'Nigeria' AND brands = 'budweiser'
GROUP BY region
ORDER BY bud_consumed DESC;
--Level of consumption of Budweiser in the regions in Nigeria

--QUESTION 9
SELECT 
	region, SUM(Quantity) AS bud_consumed
FROM international_breweries
WHERE countries = 'Nigeria' AND brands = 'budweiser' AND years ='2019'
GROUP BY region
ORDER BY bud_consumed DESC;
--Shows the level of consumption of Budweiser in the regions in Nigeria in 2019

--SECTION C
--QUESTION 1
SELECT 
	countries, SUM(Quantity) AS beer_consumed
FROM international_breweries
WHERE brands NOT IN ('beta malt', 'grand malt')
GROUP BY countries
ORDER BY beer_consumed DESC
LIMIT 1;
--Output shows Senegal as the country with the highest consumption of beer.

--Question 2
SELECT
	sales_id, sales_rep, SUM(quantity) AS highest_sales
FROM international_breweries
WHERE countries = 'Senegal' AND brands = 'budweiser'
GROUP BY sales_id
ORDER BY 3 DESC
LIMIT 1;
--Jones is the Highest sales personnel of Budweiser in Senegal

--QUESTION 3
SELECT
	countries, SUM(profit) AS highest_profit
FROM international_breweries
WHERE months IN ('October', 'November', 'December') AND years = 2019
GROUP BY countries
ORDER BY highest_profit DESC
LIMIT 1;
--Output shows Ghana as the country with highest profit of the fourth quarter in 2019



