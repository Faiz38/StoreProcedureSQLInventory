ALTER PROCEDURE sp_SearchRecords
  @ProductID NVARCHAR(20) = '',
  @SalesID INT = 0,
  @BrandID NVARCHAR(20) = '',
  @SupplierID NVARCHAR(20) = ''
AS
BEGIN
  IF @ProductID <> ''  -- Filter by ProductID
  BEGIN
    SELECT
      pi.ProductID,
	  b.BrandID,
      s.SupplierID, 
	  ps.SalesID,
--	  ps.InventoryID,
      pi.ProductName,
      pi.ProductCategory
--      ps.ProductQuantity,
--      pi.CurrentUnitLeft,
--      ps.ProductUnitPrice,
--      ps.ProductUnitSold,
--      ps.ProductTotalValue
    FROM t_ProductInventory pi
    LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
    LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
    LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
    LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
    WHERE pi.ProductID = @ProductID
  END
  ELSE IF @SalesID <> 0  -- Filter by SalesID
  BEGIN
    SELECT
      pi.ProductID,
	  b.BrandID,
      s.SupplierID,
	  ps.SalesID,
      pi.ProductName,
      pi.ProductCategory,
      ps.ProductUnitPrice,
      ps.ProductUnitSold,
      ps.ProductTotalValue,
	  ps.ProductQuantity,
	  pi.CurrentUnitLeft
    FROM t_ProductInventory pi
    INNER JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
    LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
    LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
    LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
    WHERE ps.SalesID = @SalesID
  END
  ELSE IF @BrandID <> ''  -- Filter by BrandID
  BEGIN
    SELECT
      pi.ProductID,
      pi.ProductName,
	  b.BrandID,
	  s.SupplierID,
	  b.BrandName,
	  b.BrandUpdated,
	  b.BrandWebsite,
	  b.BrandCreated,
	  b.BrandUpdated
--      pi.CurrentUnitLeft,
--     ps.InventoryID,
--      ps.ProductName,
--      ps.ProductQuantity,
--      ps.ProductUnitPrice,
--      pi.CurrentUnitLeft,
--      ps.SalesID,
--      ps.ProductUnitSold,
--      ps.ProductTotalValue,
--      b.BrandID,     
    FROM t_ProductInventory pi
    LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
    INNER JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
    LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
    LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
    WHERE b.BrandID = @BrandID
  END
  ELSE IF @SupplierID <> ''  -- Filter by SupplierID
  BEGIN
    SELECT
      pi.ProductID,
      pi.ProductName,
      b.BrandID,
	  s.SupplierID,
	  s.SupplierName,
	  s.SupplierContact,
	  s.SupplierTitle,
	  s.SupplierAddress,
	  s.SupplierCity,
	  s.SupplierCountry,
	  s.SupplierPhone,
	  s.SupplierEmail,
	  s.SupplierWebsite,
	  s.SupplierCreated,
	  s.SupplierUpdated

--      pi.ProductCategory,
--      pi.CurrentUnitLeft,
--      ps.InventoryID,
--      ps.ProductName,
--      ps.ProductQuantity,
--      ps.ProductUnitPrice,
--      pi.CurrentUnitLeft,
--      ps.SalesID,
--      ps.ProductUnitSold,
--     ps.ProductTotalValue,

--      s.SupplierID
    FROM t_ProductInventory pi
    LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
    INNER JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
    LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
      LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
    WHERE s.SupplierID = @SupplierID
  END
  ELSE  -- No filters provided, return all data
  BEGIN
    SELECT
      pi.ProductID,
      ps.SalesID,
      b.BrandID,
      s.SupplierID,
      pi.ProductName,
      pi.ProductCategory,
      pi.CurrentUnitLeft,
      ps.InventoryID,
      ps.ProductQuantity,
      ps.ProductUnitPrice,
      pi.CurrentUnitLeft,
      ps.ProductUnitSold,
      ps.ProductTotalValue
    FROM t_ProductInventory pi
    LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
    LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
    LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
    LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
  END
END


--supplier dgn brand searching guna id disp apa yg patut

select *from t_ProductRegister

EXEC sp_SearchRecords 
@ProductID = PD123;

EXEC sp_SearchRecords 
@SupplierID = S123;

EXEC sp_SearchRecords 
@BrandID = B123;

EXEC sp_SearchRecords 
@SalesID = 1;

