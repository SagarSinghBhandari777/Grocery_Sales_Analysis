create database if not exists groceries_sales;    -- Create DataBase --

use groceries_sales;  -- Use DataBase --

set sql_safe_updates=0;   -- Remove Safe Update Mode --

create table grocery_sales (               -- Create grocery_sales table and import grocery sales csv file in it. --
Item_Fat_Content varchar(50),
Item_Identifier varchar(50),
Item_Type varchar(50),
Outlet_Establishment_Year int,
Outlet_Identifier varchar(50),
Outlet_Location_Type varchar(50),
Outlet_Size varchar(50),
Outlet_Type varchar(50),
Item_Visibility float,
Item_Weight float,
Total_Sales float,
Rating float);

select * from grocery_sales;                            -- Show tables --

select count(*) from grocery_sales;                     --- Check rows --

describe grocery_sales;                              -- Check table information --

select distinct Item_Fat_Content from grocery_sales;     -- Check Unique Elements --

update grocery_sales set Item_Fat_Content=            -- Data Cleaning --
case Item_Fat_Content
when "LF" then "Low Fat"
when "reg" then "Regular"
end 
where Item_Fat_Content in ("LF","reg");

select distinct Item_Fat_Content from grocery_sales;    -- Check it is clean or not

select * from grocery_sales;

select cast(sum(Total_Sales)/100000 as decimal(10,2)) as Total_Sales_lakh    -- Total Sales -- 
from grocery_sales;

select round(avg(Total_Sales)) AS Avg_Sales                                 -- Average sales --
FROM grocery_sales;

select count(*) as No_of_orders                                               -- No of items --                                  
from grocery_sales; 

select cast(avg(Rating) as decimal(10,2))                                      -- Avg Rating --
 as Avg_Rating from grocery_sales;             


select Item_Fat_Content,                                                   -- Total Sales By Fat Content --
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales
from grocery_sales
group by Item_Fat_Content ; 

Select Item_Type,                  
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales                     -- Total Sales by item Type --
from grocery_sales
group by Item_Type 
order by Total_Sales Desc;

SELECT                                                           -- . Fat Content by Outlet for Total Sales --
Outlet_Location_Type,

SUM(CASE WHEN Item_Fat_Content = 'Low Fat' 
         THEN Total_Sales ELSE 0 END) AS Low_Fat,

SUM(CASE WHEN Item_Fat_Content = 'Regular' 
         THEN Total_Sales ELSE 0 END) AS Regular

FROM grocery_sales
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

select Outlet_Establishment_Year, cast(sum(Total_Sales) as decimal(10,2)) AS Total_Sales         -- Total Sales by Outlet Establishment --
from grocery_sales
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year;

select Outlet_Size,                                                                              -- Percentage of Sales by Outlet Size --
cast(sum(Total_Sales) as decimal(10,2)) AS Total_Sales,
cast((sum(Total_Sales) * 100.0 / sum(sum(Total_Sales)) over()) as decimal(10,2)) AS Sales_Percentage
from grocery_sales
group by Outlet_Size
order by Total_Sales desc;

select Outlet_Location_Type,                                                                      -- Sales by Outlet Location --
cast(sum(Total_Sales) as decimal(10,2)) AS Total_Sales
from grocery_sales
group by Outlet_Location_Type
order by Total_Sales desc;

select Outlet_Type,                                                                                -- All Metrics by Outlet Type --
cast(sum(Total_Sales) as decimal(10,2)) as Total_Sales,
cast(avg(Total_Sales) as decimal(10,0)) as Avg_Sales,
count(*) as No_Of_Items,
CAST(avg(Rating) as decimal(10,2)) as Avg_Rating,
CAST(avg(Item_Visibility) as decimal(10,2)) as Item_Visibility
from grocery_sales
group by Outlet_Type
order by Total_Sales desc;
