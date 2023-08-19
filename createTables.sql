CREATE Table Booking(
Booking_ID varchar(10),
No_of_Tickets int NOT NULL,
Total_Cost int NOT NULL,                                           
Card_Number varchar(19),
Name_on_card varchar(21),
User_ID varchar(5),
Show_ID varchar(10),
Foreign Key (User_ID) REFERENCES Web_User (Web_User_ID),
Foreign Key (Show_ID) REFERENCES Show(Show_ID),
Primary Key(Booking_ID));

CREATE Table Ticket(
Ticket_ID varchar(20),
Booking_ID varchar(10),
Class varchar(3) NOT NULL,
Price int NOT NULL,
Primary Key(Ticket_ID),
Foreign Key(Booking_ID) REFERENCES Booking(Booking_ID));