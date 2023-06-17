-- Create the stored procedure for inserting into t_ProductInventory, t_ProductSales, and t_Order
ALTER PROCEDURE InsertProductData
  @ProductID NVARCHAR(20),
  @ProductName NVARCHAR(50),
  @ProductCategory NVARCHAR(50),
  @CurrentUnitLeft INT,
  @ProductQuantity INT,
  @ProductUnitPrice FLOAT,
  @ProductUnitSold INT,
  @ProductTotalValue FLOAT,
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

END;

EXEC InsertProductData
  @ProductID = 'PD123',
  @ProductName = 'Product 1',
  @ProductCategory = 'Category A',
  @CurrentUnitLeft = 10,
  @ProductQuantity = 5,
  @ProductUnitPrice = 10.99,
  @ProductUnitSold = 5,
  @ProductTotalValue = 54.95,
  @ProductNameOrder = 'Product 1';

  SELECT * FROM t_ProductSales
