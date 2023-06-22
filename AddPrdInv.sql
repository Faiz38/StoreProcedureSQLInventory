ALTER PROCEDURE InsertProductData
  @ProductID NVARCHAR(20),
  @ProductName NVARCHAR(50),
  @ProductCategory NVARCHAR(50),
  @CurrentUnitLeft INT,
  @ProductQuantity INT,
  @ProductUnitPrice FLOAT,
  @ProductUnitSold INT,
  @ProductTotalValue FLOAT OUTPUT
AS
BEGIN
  SET NOCOUNT ON;

  -- Insert into t_ProductInventory
  INSERT INTO t_ProductInventory (ProductID, ProductName, ProductCategory, CurrentUnitLeft)
  VALUES (@ProductID, @ProductName, @ProductCategory, @CurrentUnitLeft);

  -- Calculate ProductTotalValue
  SET @ProductTotalValue = @ProductUnitPrice * @ProductUnitSold;

  -- Insert into t_ProductSales
  DECLARE @InventoryID INT;
  SET @InventoryID = SCOPE_IDENTITY();

  INSERT INTO t_ProductSales (InventoryID, ProductID, ProductName, ProductCategory, ProductQuantity, ProductUnitPrice, ProductUnitSold, ProductTotalValue)
  VALUES (@InventoryID, @ProductID, @ProductName, @ProductCategory, @ProductQuantity, @ProductUnitPrice, @ProductUnitSold, @ProductTotalValue);

END;


EXEC InsertProductData
  @ProductID = 'PD124',
  @ProductName = 'Samsung',
  @ProductCategory = 'Smartphone',
  @CurrentUnitLeft = 45,
  @ProductQuantity = 100,
  @ProductUnitPrice = 999,
  @ProductUnitSold = 100,
  @ProductTotalValue = 54.95;

  SELECT * FROM t_ProductSales
