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
  @ProductID = 'P001',
  @SupplierID = 'S001',
  @BrandID = 'B001';
  EXEC sp_RegisterProduct
  @ProductID = 'P002',
  @SupplierID = 'S002',
  @BrandID = 'B001';
  EXEC sp_RegisterProduct
  @ProductID = 'P003',
  @SupplierID = 'S003',
  @BrandID = 'B003';

  select * from t_ProductRegister


