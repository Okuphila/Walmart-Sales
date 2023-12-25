
SELECT
	 Time,
     (CASE
		 WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
         WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
         ELSE "Evening"
	END
	) AS Time_Of_Date
FROM `walmartsalesdata.csv`;

ALTER TABLE `walmartsalesdata.csv` ADD COLUMN Time_Of_Day VARCHAR(20);

UPDATE `walmartsalesdata.csv`
SET Time_Of_Day = (
	CASE
		 WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
         WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
         ELSE "Evening"
	END
);

#----Day Name
SELECT
	 date,
     dayname(date)
FROM `walmartsalesdata.csv`;

ALTER TABLE `walmartsalesdata.csv` ADD COLUMN Day_Name VARCHAR(10);
UPDATE `walmartsalesdata.csv`
SET Day_Name = dayname(date);

#---MONTH NAME
SELECT
	 Date,
     MONTHNAME(Date)
FROM `walmartsalesdata.csv`;
     


#----------------------------------------------------------Generic Questions------------------------------------------------------------------------
#------How many unique cities does the data have?
SELECT DISTINCT City
FROM `walmartsalesdata.csv`;

#------In which city is each branch?
SELECT DISTINCT City, Branch
FROM `walmartsalesdata.csv`;

#--------------------------------------------------------PRODUCT------------------------------------------------------------------------------------
#-------How many unique product lines does the data have?
SELECT COUNT(DISTINCT Product_line)
FROM `walmartsalesdata.csv`;

#--------What is the most common payment method?
SELECT Payment,
	   COUNT(Payment) AS cnt
FROM `walmartsalesdata.csv`
GROUP BY payment
ORDER BY cnt DESC; 

#-------What is the most selling product line?
SELECT Product_line,
	   COUNT(Product_line) AS cnt
FROM `walmartsalesdata.csv`
GROUP BY Product_line
ORDER BY cnt DESC;

#-------What is the total revenue by month?
SELECT 
	 date,
     SUM(Total) AS total_revenue	 
FROM `walmartsalesdata.csv`
GROUP BY Date
ORDER BY total_revenue DESC;

#------What month had the largest Cost Of Goods Sold?
SELECT
	 month_name AS month,
     SUM(cogs) AS cogs
FROM `walmartsalesdata.csv`
GROUP BY month_name
ORDER BY cogs DESC;

#-----What product line had the largest revenue?
SELECT
	 Product_line,
     SUM(Total) AS total_revenue
FROM `walmartsalesdata.csv`
GROUP BY Product_line
ORDER BY total_revenue DESC;

#----What is the city with the largest revenue?
SELECT
	 City, Branch,
     SUM(Total) AS total_revenue
FROM `walmartsalesdata.csv`
GROUP BY City, Branch
ORDER BY total_revenue DESC;

#------What product line had the largest VAT?
SELECT 
	 Product_line,
     AVG(Tax) AS avg_vat
FROM `walmartsalesdata.csv`
GROUP BY Product_line
ORDER BY avg_tax DESC;

#-----Which branch sold more products than average product sold?
SELECT 
	 Branch,
     SUM(Quantity) AS qty
FROM `walmartsalesdata.csv`
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM `walmartsalesdata.csv`);

#------What is the most common product line by gender?
SELECT
	 Product_line, Gender,
     COUNT(Gender) AS total_cnt
FROM `walmartsalesdata.csv`
GROUP BY Product_line, Gender
ORDER BY total_cnt DESC;

#-----What is the average rating of each product line?
SELECT 
	 Product_line,
	 ROUND(AVG(Rating), 2) AS avg_rating
FROM `walmartsalesdata.csv`
GROUP BY Product_line
ORDER BY avg_rating DESC;



#------------------------------------------------------------SALES----------------------------------------------------------------------------
#---Number of sales made in each time of the day per weekday
SELECT
	 Time_Of_Day,
     COUNT(*) AS Total_Sales
FROM `walmartsalesdata.csv`
GROUP BY Time_Of_Day
ORDER BY Total_Sales DESC;

#---Which of the customer types brings the most revenue?
SELECT 
	 Customer_Type,
     SUM(Total) AS Total_Revenue
FROM `walmartsalesdata.csv`
GROUP BY Customer_Type
ORDER BY Total_Revenue DESC;

#----Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
	 City, Branch,
     AVG(Tax 5%) AS Tax_Percentage
FROM `walmartsalesdata.csv`
GROUP BY City, Branch
ORDER BY Tax_Percentage DESC;

#----Which customer type pays the most in VAT?
SELECT 
	 Customer_Type,
     AVG(Tax5%) AS avg_tax
FROM `walmartsalesdata.csv`
GROUP BY Customer_Type
ORDER BY avg_tax DESC;

#----------------------------------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------CUSTOMERS------------------------------------------------------------------
#----How many unique customer types does the data have?
SELECT 
	 DISTINCT Customer_Type
FROM `walmartsalesdata.csv`;
     
#----How many unique payment methods does the data have?
SELECT DISTINCT Payment
 FROM `walmartsalesdata.csv`;
 
#----What is the most common customer type?
SELECT
	 Customer_Type,
	 COUNT(Customer_Type) AS Common_Customer
FROM `walmartsalesdata.csv`
GROUP BY Customer_Type
ORDER BY Common_Customer DESC;


#-----Which customer type buys the most?
SELECT 
	 Customer_Type,
     COUNT(*) AS Total_Items_Bought
FROM `walmartsalesdata.csv`
GROUP BY Customer_Type;


#----What is the gender of most of the customers?
SELECT 
	 Gender,
     COUNT(*) AS Gender_cnt 
FROM `walmartsalesdata.csv`
GROUP BY Gender
ORDER BY Gender_cnt DESC;



#---What is the gender distribution per branch?
SELECT 
	 Gender, Branch,
     COUNT(*) AS Gender_cnt 
FROM `walmartsalesdata.csv`
GROUP BY Gender, Branch
ORDER BY Gender_cnt DESC;

#-----Which time of the day do customers give most ratings?
SELECT
	 Time_Of_Day,
     AVG(Rating) AS avg_rating
FROM `walmartsalesdata.csv`
GROUP BY Time_Of_Day
ORDER BY avg_rating DESC;

#-----Which time of the day do customers give most ratings per branch?
SELECT
	 Time_Of_Day,
     AVG(Rating) AS avg_rating
FROM `walmartsalesdata.csv`
WHERE Branch = "A"
GROUP BY Time_Of_Day
ORDER BY avg_rating DESC;


