-- Food_Delivery_Customer_Analysis
-- Creating the Database
CREATE DATABASE Food_Delivery;
USE Food_Delivery;

-- 1. Customers
-- 2. Restaurent
-- 3. Menu_Items
-- 4. Orders
-- 5. Delivery
CREATE TABLE IF NOT EXISTS Customer
(
    C_ID INT PRIMARY KEY AUTO_INCREMENT, 
    C_Name VARCHAR(30) NOT NULL, 
    C_Gender CHAR(10) NOT NULL,
    C_Contact CHAR(10) NOT NULL UNIQUE, 
    C_Address VARCHAR(100) NOT NULL,
    C_Sign_Up_Date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Restaurent
(
    Res_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Res_Name VARCHAR(50) NOT NULL, 
    Res_Contact CHAR(10) NOT NULL UNIQUE, 
    Res_Address VARCHAR(100), 
    Res_Cuisine VARCHAR(60), 
    Res_Rating INT CHECK (Res_Rating >= 1 AND Res_Rating <= 5)
);

CREATE TABLE IF NOT EXISTS Menu_Items
(
    Item_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Res_ID INT NOT NULL, 
    Food_Item VARCHAR(50) NOT NULL,
    Food_Price FLOAT DEFAULT 0, 
    Food_Availability BOOL, 
    FOREIGN KEY (Res_ID) REFERENCES Restaurent(Res_ID)
);

CREATE TABLE IF NOT EXISTS ORDERS
(
    Order_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    C_ID INT,
    Res_ID INT, 
    Item_ID INT,
    Quantity TINYINT UNSIGNED CHECK (Quantity >= 1), 
    Discount FLOAT DEFAULT 0, 
    Total_Price FLOAT DEFAULT 0, 
    Order_DateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID),
    FOREIGN KEY (Res_ID) REFERENCES Restaurent(Res_ID),
    FOREIGN KEY (Item_ID) REFERENCES Menu_Items(Item_ID)
);

CREATE TABLE IF NOT EXISTS DELIVERY
(
	Delivery_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    Order_ID INT UNSIGNED, 
    Item_ID INT,
    Res_ID INT, 
    C_ID INT, 
    Assigned_Executive VARCHAR(30), 
    Contact_Executive VARCHAR(10), 
    Status VARCHAR(30), -- Delivered or Not Delivered
    Del_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Order_ID) REFERENCES ORDERS(Order_ID), 
    FOREIGN KEY (Item_ID) REFERENCES Menu_Items(Item_ID),
    FOREIGN KEY (C_ID) REFERENCES Customer(C_ID),
    FOREIGN KEY (Res_ID) REFERENCES Restaurent(Res_ID)
);


-- INSERTING VALUES

INSERT INTO Customer
(C_ID, C_Name, C_Gender, C_Contact, C_Address, C_Sign_Up_Date)
VALUES
(1,'Aarav Sharma','Male','9000000001','Delhi','2025-01-05 10:30:00'),
(2,'Priya Verma','Female','9000000002','Noida','2025-01-08 12:15:00'),
(3,'Rahul Gupta','Male','9000000003','Gurugram','2025-01-12 09:20:00'),
(4,'Ananya Singh','Female','9000000004','Ghaziabad','2025-01-15 14:40:00'),
(5,'Vikram Patel','Male','9000000005','Faridabad','2025-01-19 16:10:00'),
(6,'Sneha Reddy','Female','9000000006','Delhi','2025-01-22 11:00:00'),
(7,'Arjun Mehta','Male','9000000007','Noida','2025-01-25 13:25:00'),
(8,'Kavya Nair','Female','9000000008','Greater Noida','2025-02-02 10:45:00'),
(9,'Rohan Das','Male','9000000009','Gurugram','2025-02-06 17:30:00'),
(10,'Isha Kapoor','Female','9000000010','Delhi','2025-02-10 08:50:00'),
(11,'Aditya Joshi','Male','9000000011','Jaipur','2025-02-14 12:10:00'),
(12,'Meera Iyer','Female','9000000012','Mumbai','2025-02-18 15:20:00'),
(13,'Karan Malhotra','Male','9000000013','Pune','2025-02-21 11:40:00'),
(14,'Pooja Mishra','Female','9000000014','Lucknow','2025-02-25 09:15:00'),
(15,'Nikhil Jain','Male','9000000015','Chandigarh','2025-03-01 14:00:00'),
(16,'Riya Chawla','Female','9000000016','Delhi','2025-03-04 10:20:00'),
(17,'Siddharth Rao','Male','9000000017','Bengaluru','2025-03-08 16:45:00'),
(18,'Aditi Bose','Female','9000000018','Kolkata','2025-03-11 13:10:00'),
(19,'Manish Yadav','Male','9000000019','Noida','2025-03-15 11:30:00'),
(20,'Tanya Sethi','Female','9000000020','Gurugram','2025-03-19 17:00:00'),
(21,'Deepak Kumar','Male','9000000021','Patna','2025-03-22 09:40:00'),
(22,'Simran Kaur','Female','9000000022','Amritsar','2025-03-26 12:50:00'),
(23,'Harsh Agarwal','Male','9000000023','Kanpur','2025-04-02 14:15:00'),
(24,'Nisha Thomas','Female','9000000024','Kochi','2025-04-06 10:05:00'),
(25,'Varun Bansal','Male','9000000025','Delhi','2025-04-10 16:20:00'),
(26,'Diya Shah','Female','9000000026','Ahmedabad','2025-04-14 11:10:00'),
(27,'Mohit Sinha','Male','9000000027','Ranchi','2025-04-18 13:45:00'),
(28,'Shreya Kulkarni','Female','9000000028','Pune','2025-04-22 09:30:00'),
(29,'Abhishek Roy','Male','9000000029','Kolkata','2025-04-25 15:55:00'),
(30,'Neha Arora','Female','9000000030','Jaipur','2025-04-29 12:35:00'),
(31,'Yash Thakur','Male','9000000031','Shimla','2025-05-03 10:10:00'),
(32,'Sakshi Ghosh','Female','9000000032','Bengaluru','2025-05-07 14:25:00'),
(33,'Akash Tripathi','Male','9000000033','Lucknow','2025-05-11 08:45:00'),
(34,'Muskan Ali','Female','9000000034','Hyderabad','2025-05-15 17:15:00'),
(35,'Ritesh Pandey','Male','9000000035','Varanasi','2025-05-19 11:55:00'),
(36,'Tanvi Desai','Female','9000000036','Surat','2025-05-23 13:20:00'),
(37,'Saurabh Mishra','Male','9000000037','Bhopal','2025-05-27 09:50:00'),
(38,'Pallavi Sen','Female','9000000038','Kolkata','2025-06-01 16:05:00'),
(39,'Ankit Saxena','Male','9000000039','Agra','2025-06-05 12:40:00'),
(40,'Lavanya Pillai','Female','9000000040','Chennai','2025-06-09 10:35:00'),
(41,'Gaurav Khanna','Male','9000000041','Delhi','2025-06-13 14:50:00'),
(42,'Ira Mukherjee','Female','9000000042','Kolkata','2025-06-17 11:25:00'),
(43,'Pranav Shetty','Male','9000000043','Mangaluru','2025-06-21 15:10:00'),
(44,'Manya Bhatia','Female','9000000044','Noida','2025-06-25 09:05:00'),
(45,'Devansh Sood','Male','9000000045','Chandigarh','2025-06-29 13:35:00'),
(46,'Ayesha Khan','Female','9000000046','Hyderabad','2025-07-03 10:55:00'),
(47,'Raghav Menon','Male','9000000047','Thiruvananthapuram','2025-07-07 16:30:00'),
(48,'Sanya Oberoi','Female','9000000048','Gurugram','2025-07-11 12:05:00'),
(49,'Kunal Bhardwaj','Male','9000000049','Delhi','2025-07-15 14:15:00'),
(50,'Tara Fernandes','Female','9000000050','Mumbai','2025-07-19 09:45:00');


INSERT INTO Restaurent
(Res_ID, Res_Name, Res_Contact, Res_Address, Res_Cuisine, Res_Rating)
VALUES
(1,'Spice Route','9100000001','Connaught Place, Delhi','North Indian',5),
(2,'Pizza Corner','9100000002','Sector 18, Noida','Italian',4),
(3,'Wok Express','9100000003','Cyber Hub, Gurugram','Chinese',4),
(4,'Dosa Junction','9100000004','Raj Nagar, Ghaziabad','South Indian',5),
(5,'Burger Barn','9100000005','Sector 15, Faridabad','Fast Food',3),
(6,'Curry House','9100000006','Karol Bagh, Delhi','North Indian',4),
(7,'Pasta Palace','9100000007','Sector 50, Noida','Italian',5),
(8,'Dragon Bowl','9100000008','Alpha 2, Greater Noida','Chinese',3),
(9,'Tandoori Tales','9100000009','Sohna Road, Gurugram','Mughlai',5),
(10,'Sweet Treats','9100000010','Lajpat Nagar, Delhi','Desserts',4),
(11,'Royal Biryani','9100000011','C Scheme, Jaipur','Biryani',5),
(12,'Coastal Kitchen','9100000012','Andheri West, Mumbai','Seafood',4),
(13,'Green Bowl','9100000013','Hinjewadi, Pune','Healthy Food',4),
(14,'Awadhi Zaika','9100000014','Hazratganj, Lucknow','Awadhi',5),
(15,'Punjabi Tadka','9100000015','Sector 22, Chandigarh','Punjabi',4),
(16,'Cafe Mocha','9100000016','Dwarka, Delhi','Cafe',3),
(17,'South Spice','9100000017','Indiranagar, Bengaluru','South Indian',5),
(18,'Bengal Bites','9100000018','Park Street, Kolkata','Bengali',4),
(19,'Rolls Factory','9100000019','Sector 62, Noida','Street Food',3),
(20,'Grill Nation','9100000020','Golf Course Road, Gurugram','Grill',5),
(21,'Litti Junction','9100000021','Boring Road, Patna','Bihari',4),
(22,'Amritsari Rasoi','9100000022','Lawrence Road, Amritsar','Punjabi',5),
(23,'Kanpur Kitchen','9100000023','Swaroop Nagar, Kanpur','North Indian',3),
(24,'Malabar Meals','9100000024','Fort Kochi, Kochi','Kerala',5),
(25,'Street Wok','9100000025','Saket, Delhi','Asian',4),
(26,'Gujarati Thali','9100000026','Navrangpura, Ahmedabad','Gujarati',5),
(27,'Tribal Kitchen','9100000027','Main Road, Ranchi','Indian',3),
(28,'Maharashtra Meals','9100000028','Kothrud, Pune','Maharashtrian',4),
(29,'Kolkata Kathi','9100000029','Salt Lake, Kolkata','Street Food',5),
(30,'Rajasthani Rasoi','9100000030','Malviya Nagar, Jaipur','Rajasthani',4),
(31,'Mountain Cafe','9100000031','Mall Road, Shimla','Cafe',4),
(32,'Bengaluru Bites','9100000032','Whitefield, Bengaluru','Continental',5),
(33,'Nawabi Kitchen','9100000033','Gomti Nagar, Lucknow','Mughlai',4),
(34,'Hyderabadi Handi','9100000034','Banjara Hills, Hyderabad','Hyderabadi',5),
(35,'Banaras Bhoj','9100000035','Lanka, Varanasi','North Indian',3),
(36,'Surti Swad','9100000036','Adajan, Surat','Gujarati',4),
(37,'Bhopali Zaika','9100000037','MP Nagar, Bhopal','Mughlai',4),
(38,'Bengal Curry','9100000038','Howrah, Kolkata','Bengali',3),
(39,'Agra Petha House','9100000039','Sadar Bazaar, Agra','Desserts',5),
(40,'Chennai Express','9100000040','T Nagar, Chennai','South Indian',5),
(41,'Capital Kitchen','9100000041','Rohini, Delhi','Multi-Cuisine',4),
(42,'Mishti Mahal','9100000042','New Town, Kolkata','Desserts',4),
(43,'Coastal Curry','9100000043','Kadri, Mangaluru','Seafood',5),
(44,'Noida Noodles','9100000044','Sector 76, Noida','Chinese',3),
(45,'Chandigarh Grill','9100000045','Sector 35, Chandigarh','Grill',4),
(46,'Deccan Delights','9100000046','Madhapur, Hyderabad','Andhra',5),
(47,'Kerala Kitchen','9100000047','Kowdiar, Thiruvananthapuram','Kerala',4),
(48,'Gurgaon Gourmet','9100000048','Sector 29, Gurugram','Continental',5),
(49,'Delhi Darbar','9100000049','Janakpuri, Delhi','Mughlai',4),
(50,'Mumbai Masala','9100000050','Bandra West, Mumbai','Multi-Cuisine',5);


INSERT INTO Menu_Items
(Item_ID, Res_ID, Food_Item, Food_Price, Food_Availability)
VALUES
(1,1,'Paneer Butter Masala',280.00,TRUE),
(2,2,'Margherita Pizza',250.00,TRUE),
(3,3,'Veg Hakka Noodles',180.00,TRUE),
(4,4,'Masala Dosa',120.00,TRUE),
(5,5,'Classic Chicken Burger',220.00,TRUE),
(6,6,'Dal Makhani',240.00,TRUE),
(7,7,'White Sauce Pasta',260.00,TRUE),
(8,8,'Veg Fried Rice',170.00,FALSE),
(9,9,'Chicken Tandoori',420.00,TRUE),
(10,10,'Chocolate Brownie',120.00,TRUE),
(11,11,'Chicken Biryani',320.00,TRUE),
(12,12,'Grilled Fish',450.00,TRUE),
(13,13,'Quinoa Salad',230.00,TRUE),
(14,14,'Lucknowi Galouti Kebab',350.00,TRUE),
(15,15,'Chole Bhature',160.00,TRUE),
(16,16,'Cappuccino',140.00,TRUE),
(17,17,'Idli Sambar',90.00,TRUE),
(18,18,'Fish Curry Rice',280.00,TRUE),
(19,19,'Paneer Kathi Roll',150.00,TRUE),
(20,20,'Grilled Chicken Platter',480.00,TRUE),
(21,21,'Litti Chokha',130.00,TRUE),
(22,22,'Amritsari Kulcha',140.00,TRUE),
(23,23,'Veg Thali',190.00,TRUE),
(24,24,'Kerala Fish Curry',340.00,TRUE),
(25,25,'Chicken Manchurian',260.00,TRUE),
(26,26,'Gujarati Thali',220.00,TRUE),
(27,27,'Veg Curry Rice',160.00,TRUE),
(28,28,'Misal Pav',110.00,TRUE),
(29,29,'Egg Kathi Roll',130.00,TRUE),
(30,30,'Dal Baati Churma',240.00,TRUE),
(31,31,'Grilled Sandwich',160.00,TRUE),
(32,32,'Alfredo Pasta',290.00,TRUE),
(33,33,'Mutton Seekh Kebab',390.00,TRUE),
(34,34,'Hyderabadi Chicken Biryani',350.00,TRUE),
(35,35,'Kachori Sabzi',80.00,TRUE),
(36,36,'Undhiyu',200.00,TRUE),
(37,37,'Bhopali Gosht Korma',380.00,TRUE),
(38,38,'Shorshe Maach',300.00,FALSE),
(39,39,'Petha Box',180.00,TRUE),
(40,40,'Pongal',100.00,TRUE),
(41,41,'Chicken Fried Rice',240.00,TRUE),
(42,42,'Rasgulla Box',150.00,TRUE),
(43,43,'Prawn Ghee Roast',420.00,TRUE),
(44,44,'Schezwan Noodles',190.00,TRUE),
(45,45,'BBQ Chicken Wings',320.00,TRUE),
(46,46,'Andhra Chicken Curry',330.00,TRUE),
(47,47,'Appam with Stew',210.00,TRUE),
(48,48,'Mushroom Risotto',360.00,TRUE),
(49,49,'Chicken Kebab Platter',400.00,TRUE),
(50,50,'Butter Chicken',350.00,TRUE);

INSERT INTO ORDERS
(Order_ID, C_ID, Res_ID, Item_ID, Quantity, Discount, Total_Price, Order_DateTime)
VALUES
(1,1,1,1,2,0.10,504.00,'2025-07-20 12:30:00'),
(2,2,2,2,1,0.00,250.00,'2025-07-20 13:15:00'),
(3,3,3,3,3,0.05,513.00,'2025-07-21 19:20:00'),
(4,4,4,4,2,0.00,240.00,'2025-07-22 09:10:00'),
(5,5,5,5,1,0.10,198.00,'2025-07-22 20:45:00'),
(6,6,6,6,2,0.15,408.00,'2025-07-23 13:05:00'),
(7,7,7,7,1,0.00,260.00,'2025-07-23 19:35:00'),
(8,8,8,8,2,0.10,306.00,'2025-07-24 12:20:00'),
(9,9,9,9,1,0.05,399.00,'2025-07-24 20:10:00'),
(10,10,10,10,3,0.00,360.00,'2025-07-25 16:30:00'),
(11,1,11,11,2,0.10,576.00,'2025-07-25 20:00:00'),
(12,12,12,12,1,0.00,450.00,'2025-07-26 13:40:00'),
(13,13,13,13,2,0.05,437.00,'2025-07-27 11:25:00'),
(14,14,14,14,1,0.15,297.50,'2025-07-27 19:15:00'),
(15,15,15,15,3,0.00,480.00,'2025-07-28 12:05:00'),
(16,16,16,16,2,0.10,252.00,'2025-07-28 17:30:00'),
(17,17,17,17,4,0.05,342.00,'2025-07-29 08:40:00'),
(18,18,18,18,2,0.00,560.00,'2025-07-29 20:25:00'),
(19,19,19,19,2,0.10,270.00,'2025-07-30 13:15:00'),
(20,20,20,20,1,0.15,408.00,'2025-07-30 20:40:00'),
(21,21,21,21,3,0.05,370.50,'2025-08-01 12:45:00'),
(22,22,22,22,2,0.00,280.00,'2025-08-01 19:05:00'),
(23,23,23,23,2,0.10,342.00,'2025-08-02 13:30:00'),
(24,24,24,24,1,0.05,323.00,'2025-08-02 20:15:00'),
(25,25,25,25,2,0.00,520.00,'2025-08-03 19:45:00'),
(26,26,26,26,1,0.10,198.00,'2025-08-04 12:10:00'),
(27,27,27,27,3,0.00,480.00,'2025-08-04 18:55:00'),
(28,28,28,28,4,0.05,418.00,'2025-08-05 17:20:00'),
(29,29,29,29,2,0.10,234.00,'2025-08-05 20:30:00'),
(30,30,30,30,1,0.00,240.00,'2025-08-06 13:10:00'),
(31,31,31,31,2,0.05,304.00,'2025-08-06 16:15:00'),
(32,32,32,32,1,0.10,261.00,'2025-08-07 19:25:00'),
(33,33,33,33,2,0.00,780.00,'2025-08-07 20:05:00'),
(34,34,34,34,2,0.15,595.00,'2025-08-08 13:35:00'),
(35,35,35,35,5,0.00,400.00,'2025-08-08 09:00:00'),
(36,36,36,36,2,0.05,380.00,'2025-08-09 12:50:00'),
(37,37,37,37,1,0.10,342.00,'2025-08-09 20:35:00'),
(38,38,38,38,2,0.00,600.00,'2025-08-10 19:10:00'),
(39,39,39,39,3,0.05,513.00,'2025-08-10 15:30:00'),
(40,40,40,40,4,0.00,400.00,'2025-08-11 08:25:00'),
(41,41,41,41,2,0.10,432.00,'2025-08-11 19:50:00'),
(42,42,42,42,3,0.05,427.50,'2025-08-12 16:40:00'),
(43,43,43,43,1,0.00,420.00,'2025-08-12 20:20:00'),
(44,44,44,44,2,0.10,342.00,'2025-08-13 13:05:00'),
(45,45,45,45,2,0.05,608.00,'2025-08-13 20:45:00'),
(46,46,46,46,1,0.00,330.00,'2025-08-14 19:30:00'),
(47,47,47,47,2,0.10,378.00,'2025-08-14 12:15:00'),
(48,48,48,48,1,0.05,342.00,'2025-08-15 20:10:00'),
(49,49,49,49,2,0.15,680.00,'2025-08-15 19:40:00'),
(50,50,50,50,2,0.10,630.00,'2025-08-16 13:25:00');

INSERT INTO DELIVERY
(Delivery_ID, Order_ID, Item_ID, Res_ID, C_ID,
 Assigned_Executive, Contact_Executive, Status, Del_Time)
VALUES
(1,1,1,1,1,'Amit Kumar','9200000001','Delivered','2025-07-20 13:10:00'),
(2,2,2,2,2,'Rohit Singh','9200000002','Delivered','2025-07-20 13:50:00'),
(3,3,3,3,3,'Vikas Sharma','9200000003','Delivered','2025-07-21 20:05:00'),
(4,4,4,4,4,'Sandeep Yadav','9200000004','Delivered','2025-07-22 09:55:00'),
(5,5,5,5,5,'Nitin Verma','9200000005','Delivered','2025-07-22 21:35:00'),
(6,6,6,6,6,'Deepak Rao','9200000006','Delivered','2025-07-23 13:55:00'),
(7,7,7,7,7,'Manoj Das','9200000007','Delivered','2025-07-23 20:20:00'),
(8,8,8,8,8,'Karan Mehta','9200000008','Failed','2025-07-24 13:25:00'),
(9,9,9,9,9,'Ravi Patel','9200000009','Delivered','2025-07-24 21:00:00'),
(10,10,10,10,10,'Ajay Gupta','9200000010','Delivered','2025-07-25 17:05:00'),
(11,11,11,11,1,'Amit Kumar','9200000001','Delivered','2025-07-25 20:50:00'),
(12,12,12,12,12,'Rohit Singh','9200000002','Delivered','2025-07-26 14:25:00'),
(13,13,13,13,13,'Vikas Sharma','9200000003','Delivered','2025-07-27 12:10:00'),
(14,14,14,14,14,'Sandeep Yadav','9200000004','Delivered','2025-07-27 20:10:00'),
(15,15,15,15,15,'Nitin Verma','9200000005','Delivered','2025-07-28 12:50:00'),
(16,16,16,16,16,'Deepak Rao','9200000006','Delivered','2025-07-28 18:15:00'),
(17,17,17,17,17,'Manoj Das','9200000007','Delivered','2025-07-29 09:20:00'),
(18,18,18,18,18,'Karan Mehta','9200000008','Delivered','2025-07-29 21:15:00'),
(19,19,19,19,19,'Ravi Patel','9200000009','Delivered','2025-07-30 13:55:00'),
(20,20,20,20,20,'Ajay Gupta','9200000010','Delivered','2025-07-30 21:30:00'),
(21,21,21,21,21,'Amit Kumar','9200000001','Delivered','2025-08-01 13:25:00'),
(22,22,22,22,22,'Rohit Singh','9200000002','Delivered','2025-08-01 19:55:00'),
(23,23,23,23,23,'Vikas Sharma','9200000003','Delivered','2025-08-02 14:20:00'),
(24,24,24,24,24,'Sandeep Yadav','9200000004','Delivered','2025-08-02 21:05:00'),
(25,25,25,25,25,'Nitin Verma','9200000005','Delivered','2025-08-03 20:35:00'),
(26,26,26,26,26,'Deepak Rao','9200000006','Delivered','2025-08-04 12:55:00'),
(27,27,27,27,27,'Manoj Das','9200000007','Delivered','2025-08-04 19:40:00'),
(28,28,28,28,28,'Karan Mehta','9200000008','Delivered','2025-08-05 18:05:00'),
(29,29,29,29,29,'Ravi Patel','9200000009','Delivered','2025-08-05 21:15:00'),
(30,30,30,30,30,'Ajay Gupta','9200000010','Delivered','2025-08-06 13:55:00'),
(31,31,31,31,31,'Amit Kumar','9200000001','Delivered','2025-08-06 17:00:00'),
(32,32,32,32,32,'Rohit Singh','9200000002','Delivered','2025-08-07 20:10:00'),
(33,33,33,33,33,'Vikas Sharma','9200000003','Delivered','2025-08-07 21:00:00'),
(34,34,34,34,34,'Sandeep Yadav','9200000004','Delivered','2025-08-08 14:30:00'),
(35,35,35,35,35,'Nitin Verma','9200000005','Delivered','2025-08-08 09:45:00'),
(36,36,36,36,36,'Deepak Rao','9200000006','Delivered','2025-08-09 13:40:00'),
(37,37,37,37,37,'Manoj Das','9200000007','Delivered','2025-08-09 21:20:00'),
(38,38,38,38,38,'Karan Mehta','9200000008','Failed','2025-08-10 20:00:00'),
(39,39,39,39,39,'Ravi Patel','9200000009','Delivered','2025-08-10 16:10:00'),
(40,40,40,40,40,'Ajay Gupta','9200000010','Delivered','2025-08-11 09:00:00'),
(41,41,41,41,41,'Amit Kumar','9200000001','Delivered','2025-08-11 20:30:00'),
(42,42,42,42,42,'Rohit Singh','9200000002','Delivered','2025-08-12 17:20:00'),
(43,43,43,43,43,'Vikas Sharma','9200000003','Delivered','2025-08-12 21:05:00'),
(44,44,44,44,44,'Sandeep Yadav','9200000004','Delivered','2025-08-13 13:55:00'),
(45,45,45,45,45,'Nitin Verma','9200000005','Delivered','2025-08-13 21:30:00'),
(46,46,46,46,46,'Deepak Rao','9200000006','Delivered','2025-08-14 20:15:00'),
(47,47,47,47,47,'Manoj Das','9200000007','Delivered','2025-08-14 12:55:00'),
(48,48,48,48,48,'Karan Mehta','9200000008','Delivered','2025-08-15 20:55:00'),
(49,49,49,49,49,'Ravi Patel','9200000009','In Transit','2025-08-15 20:00:00'),
(50,50,50,50,50,'Ajay Gupta','9200000010','In Transit','2025-08-16 13:40:00');



SELECT COUNT(*)
FROM Customer; 

SELECT COUNT(*)
FROM Menu_Items; 

SELECT COUNT(*)
From Restaurent; 

SELECT COUNT(*)
FROM ORDERS; 

SELECT COUNT(*)
FROM Delivery;

-- Average Order Cost: 

SELECT AVG(Total_Price) AS Average_Order_Cost FROM ORDERS;


-- Left_JOIN the tables: Customer + Orders
-- LEFT JOIN: Customer + Orders
SELECT
    Customer.C_ID,
    Customer.C_Name,
    ORDERS.Order_ID,
    ORDERS.Order_DateTime,
    Menu_Items.Food_Item, 
    Delivery.Assigned_Executive, 
    Delivery.Contact_Executive
FROM Customer
LEFT JOIN ORDERS
    ON Customer.C_ID = ORDERS.C_ID 
		JOIN Menu_Items
			ON ORDERS.Item_ID = Menu_Items.Item_ID
				JOIN Restaurent
					ON Restaurent.Res_ID = ORDERS.Res_ID
						JOIN Delivery
							ON Delivery.Order_ID = ORDERS.Order_ID; 
    
  
  
  -- Loading Dataset from CSV File:
  
  
  SET GLOBAL local_infile = 1;
  SHOW GLOBAL VARIABLES LIKE 'local_infile';
  
  LOAD DATA LOCAL INFILE 
  'C:\Users\Siddharth Rana\OneDrive\Desktop\food_delivery_customer_analysis\MySQL\food_delivery_csv_import_pack\customers.csv'
  INTO TABLE Customer FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY "r\n" IGNORE 1 ROWS
  (C_ID, C_Name, C_Gender, C_Contact, C_Address, C_Sign_Up_Date);
  
  -- Total data in Customers after new import
  SELECT COUNT(*) 
  FROM Customer;
  
  -- Total data in Restaurent after new import
  SELECT COUNT(*) 
  FROM Restaurent;
  
  -- Total data in Delivery after new import
  SELECT COUNT(*) 
  FROM Delivery;
  
  SELECT * 
  FROM Delivery;
  
  
-- Total data in MenuItems after new import
  SELECT COUNT(*) 
  FROM Menu_Items;
  
  -- Total data in Orders after new import
  SELECT COUNT(*) 
  FROM ORDERS;
  
  SELECT * 
  FROM ORDERS;
  
  
  
  
  
  











