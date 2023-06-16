CREATE TABLE t_ProductInventory (
  InventoryID INT IDENTITY(1,1) NOT NULL,
  ProductID NVARCHAR(20) NOT NULL,
  ProductName NVARCHAR(50) NOT NULL,
  ProductCategory NVARCHAR(50) NOT NULL,
  CurrentUnitLeft INT NOT NULL,
  PRIMARY KEY (InventoryID)
);

CREATE TABLE t_ProductSales (
  SalesID INT IDENTITY(1,1) NOT NULL,
  InventoryID INT NOT NULL,
  ProductID NVARCHAR(20) NULL,
  ProductName NVARCHAR(50) NOT NULL,
  ProductCategory NVARCHAR(50) NOT NULL,
  ProductQuantity INT NOT NULL,
  ProductUnitPrice FLOAT NOT NULL,
  ProductUnitSold INT NOT NULL,
  ProductTotalValue FLOAT NOT NULL,
  PRIMARY KEY (SalesID),
  FOREIGN KEY (InventoryID) REFERENCES t_ProductInventory(InventoryID)
);

CREATE TABLE t_ProductRegister (
  ProductID NVARCHAR(20) NOT NULL,
  ProductName NVARCHAR(50) NOT NULL,
  ProductCategory NVARCHAR(50) NOT NULL,
  ProductQuantity INT NOT NULL,
  ProductUnitPrice FLOAT NOT NULL,
  SupplierID NVARCHAR(20) NOT NULL,
  BrandID NVARCHAR(20) NOT NULL,
  PRIMARY KEY (ProductID),
  --FOREIGN KEY (ProductID) REFERENCES t_ProductInventory(ProductID)
);

CREATE TABLE t_Supplier (
  SupplierID NVARCHAR(20) NOT NULL,
  SupplierName NVARCHAR(50) NOT NULL,
  SupplierContact NVARCHAR(20) NOT NULL,
  SupplierTitle NVARCHAR(20) NOT NULL,
  SupplierAddress NVARCHAR(20) NOT NULL,
  SupplierCity NVARCHAR(20) NOT NULL,
  SupplierCountry NVARCHAR(20) NOT NULL,
  SupplierPhone NVARCHAR(20) NOT NULL,
  SupplierEmail NVARCHAR(20) NOT NULL,
  SupplierWebsite NVARCHAR(20) NOT NULL,
  SupplierCreated NVARCHAR(20) NOT NULL,
  SupplierUpdated NVARCHAR(20) NOT NULL,
  PRIMARY KEY (SupplierID),
  --FOREIGN KEY (SupplierID) REFERENCES t_ProductRegister(SupplierID)
);

CREATE TABLE t_Brand (
  BrandID NVARCHAR(20) NOT NULL,
  BrandName NVARCHAR(50) NOT NULL,
  BrandWebsite NVARCHAR(20) NOT NULL,
  BrandCreated NVARCHAR(20) NOT NULL,
  BrandUpdated NVARCHAR(20) NOT NULL,
  PRIMARY KEY (BrandID),
  --FOREIGN KEY (BrandID) REFERENCES t_ProductRegister(BrandID)
);

CREATE TABLE t_Order (
  OrderID INT IDENTITY(1,1) NOT NULL,
  ProductID NVARCHAR(20) NOT NULL,
  OrderDate NVARCHAR(20) NOT NULL,
  OrderStatus NVARCHAR(20) NOT NULL,
  ProductName NVARCHAR(50) NOT NULL,
  PRIMARY KEY (OrderID),
  --FOREIGN KEY (ProductID) REFERENCES t_ProductRegister(ProductID)
);

CREATE TABLE t_Receive (
  ReceiveID INT IDENTITY(1,1) NOT NULL,
  OrderID INT NOT NULL,
  OrderDate NVARCHAR(20) NOT NULL,
  OrderStatus NVARCHAR(20) NOT NULL,
  OrderQuantity INT NOT NULL,
  ReceivedStatus NVARCHAR(50) NOT NULL,
  PRIMARY KEY (ReceiveID),
  FOREIGN KEY (OrderID) REFERENCES t_Order(OrderID)
);


Select *from t_ProductInventory;
Select *from  t_ProductSales;
Select *from  t_ProductRegister;
Select *from t_Supplier;
Select *from  t_Brand;
Select *from  t_Order;
Select *from  t_Receive;


DROP TABLE IF EXISTS t_ProductInventory;
DROP TABLE IF EXISTS t_ProductSales;
DROP TABLE IF EXISTS t_ProductRegister;
DROP TABLE IF EXISTS t_Supplier;
DROP TABLE IF EXISTS t_Brand;
DROP TABLE IF EXISTS t_Order;
DROP TABLE IF EXISTS t_Receive;

-- Drop the foreign key constraint
ALTER TABLE t_ProductSales
DROP CONSTRAINT FK__t_ProductRegiste__367C1819;


SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('t_ProductSales') AND referenced_object_id = OBJECT_ID('t_ProductRegister');

ALTER TABLE t_ProductSales
DROP CONSTRAINT <name>;

