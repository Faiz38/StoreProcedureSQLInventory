ALTER PROCEDURE sp_SearchRecords
  @ProductID NVARCHAR(20) = '',
  @SalesID INT = 0
AS
BEGIN
  SELECT
    pi.ProductID,
    pi.ProductName,
    pi.ProductCategory,
	pi.CurrentUnitLeft,

    -- Select the desired columns from t_ProductInventory excluding ProductCategory

    ps.InventoryID,
	ps.ProductName,
    ps.ProductQuantity,
    ps.ProductUnitPrice,
    pi.CurrentUnitLeft,
	ps.SalesID,
	ps.ProductUnitSold,
	ps.ProductTotalValue,
    -- Select the desired columns from t_ProductSales

    b.BrandID,
    s.SupplierID
  FROM t_ProductInventory pi
  LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
  LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
  LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
  LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
  WHERE pi.ProductID = @ProductID

END
--supplier dgn brand searching guna id disp apa yg patut

select *from t_ProductRegister

EXEC sp_SearchRecords 
@ProductID = PD123;

