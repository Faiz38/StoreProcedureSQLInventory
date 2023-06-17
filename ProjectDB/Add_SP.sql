CREATE PROCEDURE sp_RegisterProduct
  @ProductID NVARCHAR(20),
  @ProductName NVARCHAR(50),
  @ProductCategory NVARCHAR(50),
  @ProductQuantity INT,
  @ProductUnitPrice FLOAT,
  @SupplierID NVARCHAR(20),
  @BrandID NVARCHAR(20)
AS
BEGIN
  INSERT INTO t_ProductRegister (ProductID, ProductName, ProductCategory, ProductQuantity, ProductUnitPrice, SupplierID, BrandID)
  VALUES (@ProductID, @ProductName, @ProductCategory, @ProductQuantity, @ProductUnitPrice, @SupplierID, @BrandID);
END;

EXEC sp_RegisterProduct
  @ProductID = 'PD123',
  @ProductName = 'New Product',
  @ProductCategory = 'Category',
  @ProductQuantity = 100,
  @ProductUnitPrice = 9.99,
  @SupplierID = 'S123',
  @BrandID = 'B123';

  select * from t_ProductRegister


