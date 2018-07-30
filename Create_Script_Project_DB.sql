CREATE TABLE tables(
  tableID int NOT NULL,
  tableLocation varchar(10),
  noOfSeats int NOT NULL,
  typeOfTable varchar(15),
  isReserved char(1),
  reservationID int NOT NULL,
  PRIMARY KEY(tableID),
  FOREIGN KEY (reservationID) REFERENCES reservation(reservationID)
);

CREATE TABLE customer(
  customerID int NOT NULL,
  firstName varchar(20) NOT NULL,
  lastName varchar(20),
  occasion varchar(20),
  restaurantID int NOT NULL,
  PRIMARY KEY(customerID),
  FOREIGN KEY (restaurantID) REFERENCES restaurant(restaurantID)
);

CREATE TABLE customerEmail(
  customerID int NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY(email, customerID),
  FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

CREATE TABLE customerPhone(
  customerID int NOT NULL,
  phoneNumber varchar(13) NOT NULL,
  PRIMARY KEY(customerID, phoneNumber),
  FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

CREATE TABLE employee(
  employeeID int NOT NULL,
  firstName varchar(15) NOT NULL,
  lastName varchar(15) NOT NULL,
  gender char(10),
  restaurantID int NOT NULL,
  tableID int NOT NULL,
  PRIMARY KEY(employeeID),
  FOREIGN KEY (restaurantID) REFERENCES restuarant(restaurantID),
  FOREIGN KEY (tableID) REFERENCES tables(tableID)
);


CREATE TABLE employeeInfo(
  employeeID int NOT NULL,
  role varchar(50) NOT NULL,
  PRIMARY KEY(employeeID, role),
  FOREIGN KEY (employeeID) REFERENCES employee(employeeID)
);

CREATE TABLE reservation(
  reservationID int NOT NULL,
  startingTime TIME DEFAULT NULL,
  endingTime TIME DEFAULT NULL,
  numberOfGuests int NOT NULL,
  reservationDate DATE DEFAULT NULL,
  customerID int NOT NULL,
  PRIMARY KEY(reservationID),
  FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

CREATE TABLE restaurant(
  restaurantID int NOT NULL,
  restaurantName varchar(50),
  hours varchar(15),
  location varchar(50),
  phoneNumber varchar(13),
  foodMenuId int NOT NULL,
  beverageMenuId int NOT NULL,
  PRIMARY KEY(restaurantID),
  FOREIGN KEY (foodMenuId) REFERENCES restaurantFoodMenu(foodMenuId),
  FOREIGN KEY (beverageMenuId) REFERENCES restaurantBeverageMenu(beverageMenuId)
);

CREATE TABLE restuarantInfo(
  restaurantID int NOT NULL,
  cuisine varchar(20),
  PRIMARY KEY(restaurantID, cuisine),
  FOREIGN KEY (restaurantID) REFERENCES restaurant(restaurantID)
);

CREATE TABLE restaurantFoodMenu(
  foodMenuId int NOT NULL,
  menuType varchar(60),
  PRIMARY KEY(foodMenuId)
);

CREATE TABLE restaurantBeverageMenu(
  beverageMenuId int NOT NULL,
  menuType varchar(60),
  PRIMARY KEY(beverageMenuId)
);


CREATE TABLE foodMenu(
  foodName varchar(50),
  price FLOAT NOT NULL,
  foodMenuId int NOT NULl,
  PRIMARY KEY (foodName),
  FOREIGN KEY (foodMenuId) REFERENCES restaurantFoodMenu(foodMenuId)
);

CREATE TABLE foodInfo(
  foodName varchar(30) NOT NULL,
  ingredients varchar(255),
  PRIMARY KEY (foodName, ingredients),
  FOREIGN KEY (foodName) REFERENCES foodMenu(foodName)
);


CREATE TABLE beverageMenu(
  beverageName varchar(30) NOT NULL,
  price FLOAT NOT NULL,
  beverageMenuId int NOT NULL,
  PRIMARY KEY (beverageName),
  FOREIGN KEY (beverageMenuId) REFERENCES restaurantBeverageMenu(beverageMenuId)
);


CREATE TABLE bill(
  billNum int NOT NULL,
  amount FLOAT NOT NULL,
  tip FLOAT,
  billDate DATE,
  billTime varchar(15),
  restaurantID int NOT NULL,
  customerID int NOT NULL,
  PRIMARY KEY(billNum),
  FOREIGN KEY (restaurantID) REFERENCES restaurant(restaurantID),
  FOREIGN KEY (customerID) REFERENCES customer(customerID)
);

CREATE TABLE customerBill(
  customerID int NOT NULL,
  billNum int NOT NULL,
  PRIMARY KEY(customerID, billNum),
  FOREIGN KEY (customerID) REFERENCES customer(customerID),
  FOREIGN KEY (billNum) REFERENCES bill(billNum)
);




































