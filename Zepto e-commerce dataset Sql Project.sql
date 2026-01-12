Drop table if exists Zepto;

Create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountpercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outofstock BOOLEAN,
quantity INTEGER
);

SELECT * FROM zepto;

-- Count of Rows--
SELECT COUNT(*) FROM zepto;

-- Select 10 Rows from Table--
SELECT * FROM zepto
LIMIT(10);

--Null values--
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightingms IS NULL
OR
outofStock IS NULL
OR
quantity IS NULL;

--Product Categories Available--
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--Product In Stock and Out of Stock--
SELECT outOfStock,COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

-- Product Names Present Multiple Times--
SELECT name,COUNT(sku_id) AS "NUMBER OF SKU"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

--Data Cleaning--

-- Any Product Price = 0--
SELECT * FROM zepto
WHERE mrp = 0;

--Delete the Row Where Price = 0--
DELETE FROM zepto
WHERE mrp=0;

--Converted Price from Paise To Rupees--
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp,discountedSellingPrice FROM zepto;

--Data Analysis--

-- Q1. Find the top 10 best-value products based on the discount percentage--
SELECT DISTINCT name,mrp,discountPercent AS " MAX DISCOUNTED PRICE PRODUCT"
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock--
SELECT DISTINCT name,mrp AS " OUT OF STOCK PRODUCT"
FROM zepto
WHERE outOfStock=TRUE AND mrp>300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category--
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.--
SELECT mrp,discountPercent
FROM zepto
WHERE mrp>500 AND discountPercent<10
ORDER  BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.--
SELECT category,
ROUND(AVG(discountPercent),2) AS average_discount
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.--
SELECT name,weightInGms,discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS Price_per_gms
FROM zepto
WHERE weightInGms>100
ORDER BY Price_per_gms;

--Q7.Group the products into categories like Low, Medium, Bulk.--
SELECT name,weightInGms,
CASE WHEN weightInGms <1000 THEN 'Low'
     WHEN weightInGms <5000 THEN 'Medium'
	 ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category --
SELECT category,
SUM(weightInGms * availableQuantity) AS Total_weight
FROM zepto
GROUP BY category
ORDER BY Total_weight;


	 
















