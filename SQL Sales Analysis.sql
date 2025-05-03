CREATE DATABASE IF NOT EXISTS bike_sales_db;
USE bike_sales_db;

select * from bike_sales_india;

-- KPI's 

-- 1. How many bikes are listed in total in the resale dataset?
SELECT 
    COUNT(*) AS Total_Bikes_Sold
FROM
    bike_sales_india;

-- 2. What is the average resale price of all bikes listed in the dataset?
SELECT 
    ROUND(AVG(`Resale_Price (INR)`), 0) AS Avg_Resale
FROM
    bike_sales_india;

-- 3. What is the average price depreciation from the original price to the resale price?
SELECT 
    ROUND(AVG(`Price (INR)`) - AVG(`Resale_Price (INR)`),0) AS Avg_Depreciation
FROM
    bike_sales_india;

-- 4. What is Resale Value Retention (%)?
SELECT 
    ROUND(AVG(`Price (INR)`) / AVG(`Resale_Price (INR)`) * 100,0) AS Retention_Percent
FROM
    bike_sales_india;

-- 5. Which fuel type is most commonly used in the listed bikes?
SELECT 
    `Fuel_Type`, COUNT(*) AS Count
FROM
    bike_sales_india
GROUP BY `Fuel_Type`
ORDER BY Count DESC
LIMIT 1;

-- 2Q. Top Performing Brands by Sales

SELECT 
    Brand, COUNT(*) AS Total_Sold
FROM
    bike_sales_india
GROUP BY Brand
ORDER BY Total_Sold DESC
LIMIT 5;


-- 3Q. How many bikes are listed with and without insurance in the resale market

SELECT 
    Insurance_Status, COUNT(*) AS Count
FROM
    bike_sales_india
GROUP BY Insurance_Status
ORDER BY Count DESC;


-- 4Q. Which 5 bike models offer the highest average mileage in the resale market

SELECT 
    Brand, Model, ROUND(AVG(`Mileage (km/l)`), 1) AS Avg_Mileage
FROM
    bike_sales_india
GROUP BY Brand , Model
ORDER BY Avg_Mileage DESC
LIMIT 5;


-- 5Q. Find Top 5 States with Highest Avg Resale

SELECT State, ROUND(AVG(`Resale_Price (INR)`), 0) AS Avg_Resale
FROM bike_sales_india
GROUP BY State
ORDER BY Avg_Resale DESC
LIMIT 5;


-- 6Q. What is the average depreciation of bike value over different manufacturing years

SELECT 
    `Year_of_Manufacture`,
    ROUND(AVG(`Price (INR)`), 2) AS Avg_Original,
    ROUND(AVG(`Resale_Price (INR)`), 2) AS Avg_Resale,
    ROUND((AVG(`Price (INR)`) - AVG(`Resale_Price (INR)`)),2) AS Avg_Depreciation
FROM
    bike_sales_india
GROUP BY `Year_of_Manufacture`
ORDER BY `Year_of_Manufacture`;


-- 7Q. Find Owner Type vs Resale Value

SELECT 
    Owner_Type,
    ROUND(AVG(`Resale_Price (INR)`), 2) AS Avg_Resale
FROM
    bike_sales_india
GROUP BY Owner_Type
ORDER BY Avg_Resale DESC;


-- 8Q. Find Engine Capacity Bands vs Mileage

SELECT 
    CASE
        WHEN `Engine_Capacity (cc)` <= 125 THEN 'Low (<=125cc)'
        WHEN `Engine_Capacity (cc)` <= 250 THEN 'Medium (126–250cc)'
        WHEN Engine_Capacity (cc) <= 500 THEN 'High (251–500cc)'
        ELSE 'Premium (>500cc)'
    END AS Engine_Band,
    ROUND(AVG(Mileage (km/l)), 2) AS Avg_Mileage
FROM
    bike_sales_india
GROUP BY Engine_Band
ORDER BY Avg_Mileage DESC;


-- 9Q. Which manufacturing years have the highest number of bike listings in the sale market

SELECT 
    `Year_of_Manufacture`, COUNT(*) AS Listings
FROM
    bike_sales_india
GROUP BY `Year_of_Manufacture`
ORDER BY Listings DESC;


-- 10Q. Most Popular Brand per State

WITH RankedBrands AS (
    SELECT 
        State,
        Brand,
        COUNT(*) AS Brand_Count,
        ROW_NUMBER() OVER (PARTITION BY State ORDER BY COUNT(*) DESC) AS rn
    FROM bike_sales_india
    GROUP BY State, Brand
)
SELECT State,Brand, Brand_Count
FROM RankedBrands
WHERE rn <= 3
ORDER BY State, Brand_Count DESC;

-- 11Q. Find City Tier vs Resale Price & Volume

SELECT 
    City_Tier,
    COUNT(*) AS Total_Listings,
    ROUND(AVG(`Resale_Price (INR)`), 0) AS Avg_Resale
FROM
    bike_sales_india
GROUP BY City_Tier;

-- 12Q. Find the Listings Over Time by Registration Year

SELECT 
    Registration_Year, COUNT(*) AS Listings
FROM
    bike_sales_india
GROUP BY Registration_Year
ORDER BY Registration_Year DESC;

-- 13Q. Find Top 5 States having Most Registrations

SELECT 
    state, COUNT(`Registration_Year`) AS Count
FROM
    bike_sales_india
GROUP BY state
ORDER BY count DESC;


-- 14Q. Find Total Bikes Count by Fuel Type

SELECT 
    fuel_type, COUNT(Model) AS Total_Count
FROM
    bike_sales_india
GROUP BY fuel_type;

