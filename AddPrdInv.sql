ALTER PROCEDURE InsertProductData
  @ProductID NVARCHAR(20),
  @ProductName NVARCHAR(50),
  @ProductCategory NVARCHAR(50),
  @CurrentUnitLeft INT,
  @ProductQuantity INT,
  @ProductUnitPrice FLOAT,
  @ProductUnitSold INT
AS
BEGIN
  SET NOCOUNT ON;

  -- Check if @ProductID already exists in t_ProductInventory
  IF EXISTS (SELECT 1 FROM t_ProductInventory WHERE ProductID = @ProductID)
  BEGIN
    -- Handle the case when @ProductID already exists in t_ProductInventory
    RAISERROR('The specified ProductID already exists in the Product Inventory.', 16, 1);
    RETURN;
  END

  -- Check if @ProductID exists in t_ProductRegister
  IF NOT EXISTS (SELECT 1 FROM t_ProductRegister WHERE ProductID = @ProductID)
  BEGIN
    -- Handle the case when @ProductID does not exist in t_ProductRegister
    RAISERROR('The specified ProductID does not exist.', 16, 1);
    RETURN;
  END

  -- Calculate @ProductTotalValue
  DECLARE @ProductTotalValue FLOAT;
  SET @ProductTotalValue = @ProductUnitPrice * @ProductUnitSold;

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
  @ProductID = 'P001',
  @ProductName = 'Samsung A54',
  @ProductCategory = 'Smartphone',
  @CurrentUnitLeft = 100,
  @ProductQuantity = 1000,
  @ProductUnitPrice = 1599,
  @ProductUnitSold = 23

  SELECT * FROM t_ProductInventory
