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
  @ProductID = '',
  @SupplierID = 'S112',
  @BrandID = 'B002';

  select * from t_ProductRegister


