-- Create the stored procedure for inserting into t_ProductInventory, t_ProductSales, and t_Order
CREATE PROCEDURE InsertProductData
  @ProductID NVARCHAR(20),
  @ProductName NVARCHAR(50),
  @ProductCategory NVARCHAR(50),
  @CurrentUnitLeft INT,
  @ProductQuantity INT,
  @ProductUnitPrice FLOAT,
  @ProductUnitSold INT,
  @ProductTotalValue FLOAT,
  @OrderDate NVARCHAR(20),
  @OrderStatus NVARCHAR(20),
  @ProductNameOrder NVARCHAR(50)
AS
BEGIN
  SET NOCOUNT ON;

  -- Insert into t_ProductInventory
  INSERT INTO t_ProductInventory (ProductID, ProductName, ProductCategory, CurrentUnitLeft)
  VALUES (@ProductID, @ProductName, @ProductCategory, @CurrentUnitLeft);

  -- Insert into t_ProductSales
  DECLARE @InventoryID INT;
  SET @InventoryID = SCOPE_IDENTITY();

  INSERT INTO t_ProductSales (InventoryID, ProductID, ProductName, ProductCategory, ProductQuantity, ProductUnitPrice, ProductUnitSold, ProductTotalValue)
  VALUES (@InventoryID, @ProductID, @ProductName, @ProductCategory, @ProductQuantity, @ProductUnitPrice, @ProductUnitSold, @ProductTotalValue);

  -- Insert into t_Order
  INSERT INTO t_Order (ProductID, OrderDate, OrderStatus, ProductName)
  VALUES (@ProductID, @OrderDate, @OrderStatus, @ProductNameOrder);
END;

EXEC InsertProductData
  @ProductID = 'P123',
  @ProductName = 'Product 1',
  @ProductCategory = 'Category A',
  @CurrentUnitLeft = 10,
  @ProductQuantity = 5,
  @ProductUnitPrice = 10.99,
  @ProductUnitSold = 5,
  @ProductTotalValue = 54.95,
  @OrderDate = '2023-06-16',
  @OrderStatus = 'Pending',
  @ProductNameOrder = 'Product 1';
