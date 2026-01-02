CREATE DATABASE retail_db;
USE retail_db;
-- DROP TABLE 	RETAIL_RAW; 
CREATE TABLE retail_raw (
    Customer_ID VARCHAR(50),
    Product_ID VARCHAR(50),
    Order_ID VARCHAR(50),
    Customer_Age VARCHAR(10),
    Gender VARCHAR(20),
    Product_Name VARCHAR(255),
    MRP VARCHAR(50),
    Discount_Price VARCHAR(50),
    Category VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50),
    Subscription VARCHAR(255),
    Bill_Number VARCHAR(50),
    Time_Spent_on_Website VARCHAR(20),
    Rating VARCHAR(20),
    Marketing_Advertisement VARCHAR(50),
    Ship_Mode VARCHAR(50),
    Order_Status VARCHAR(50),
    Order_Date VARCHAR(30),
    Delivery_Date VARCHAR(30),
    Cancellation_Date VARCHAR(30),
    Payment_Method VARCHAR(50),
    Pin_Code VARCHAR(30),
    Total_Order_Value VARCHAR(50),
    Payment_Status VARCHAR(50),
    No_of_Clicks VARCHAR(30),
    Year VARCHAR(30),
    Month VARCHAR(30),
    Shipping_Charges VARCHAR(50)
);
SELECT 
    count(*)
FROM
    retail_raw;



