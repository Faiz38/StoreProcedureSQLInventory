ALTER PROCEDURE sp_RegisterProduct
  @ProductID NVARCHAR(20),
  @SupplierID NVARCHAR(20),
  @BrandID NVARCHAR(20)
AS
BEGIN
  INSERT INTO t_ProductRegister (ProductID, SupplierID, BrandID)
  VALUES (@ProductID, @SupplierID, @BrandID);
END;

EXEC sp_RegisterProduct
  @ProductID = 'PD124',
  @SupplierID = 'S124',
  @BrandID = 'B124';

  select * from t_ProductRegister


