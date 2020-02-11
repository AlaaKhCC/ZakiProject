create database Zaki;

/* */
/* User table **/
create table UserOfSystem(
userID varchar(9) not null,
name nvarchar (20)     NOT NULL,
surName nvarchar(20)    NOT NULL,
email  varchar(50) ,
passwordUser varchar(25),
primary key (userID)   
);

/* Customer that inherit from User */
create table Customer(
customerID varchar(9) not null,
FOREIGN KEY (customerID) REFERENCES  UserOfSystem(userID),
primary key (customerID)
);
/* Supplier that inherit from User */
create table Supplier(
supplierID varchar(9) not null,
FOREIGN KEY (supplierID) REFERENCES  UserOfSystem(userID),
primary key (supplierID)
);
/*****/



/**** Product Table this is a weak table it based on Supplier */
create table Product(
productID varchar(10) not null,
supplierID varchar(9) not null,
priceOfPiece float not null,
category nvarchar(15),
FOREIGN KEY (supplierID) REFERENCES Supplier (supplierID),
unique (productID)
);



/***/
/* orders **/
create table Orders(
orderID  int  not null,
customerID varchar(9) not null,
orderDate date not null,
requiredDate date not null,
primary key (orderID) 
);

/****/
create table OrderDetails(
orderID int not null,
prodID varchar(10),
supID varchar(9) not null,
unitPrice float not null,
quantity int not null,
discount float not null,

FOREIGN KEY (orderID) REFERENCES Orders(orderID),
primary key(orderID, prodID),
FOREIGN KEY (prodID) REFERENCES Product(productID)
);

