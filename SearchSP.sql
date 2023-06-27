ALTER PROCEDURE sp_SearchRecords
  @ProductID NVARCHAR(20) = '',
  @SalesID INT = 0,
  @BrandID NVARCHAR(20) = '',
  @SupplierID NVARCHAR(20) = '',
  @OrderID INT = 0
AS
BEGIN
  IF @OrderID <> 0 -- Filter by OrderID
  BEGIN
    IF EXISTS (SELECT 1 FROM t_Order WHERE OrderID = @OrderID)
    BEGIN
      SELECT
        o.OrderID,
        o.ProductID,
        pr.BrandID,
        pr.SupplierID,
        s.SupplierContact,
        o.OrderStatus,
        o.OrderQuantity,
        r.OrderReceivedQuantity,
        r.RemainingOrderQuantity,
        r.ReceivedOrderDate
      FROM t_Order o
      LEFT JOIN t_ProductRegister pr ON o.ProductID = pr.ProductID
      LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
      LEFT JOIN t_Receive r ON o.OrderID = r.OrderID
      WHERE o.OrderID = @OrderID
    END
    ELSE
    BEGIN
      RAISERROR('The specified OrderID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
  ELSE IF @ProductID <> '' -- Filter by ProductID
  BEGIN
    IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE ProductID = @ProductID)
    BEGIN
      SELECT
        pi.ProductID,
        b.BrandID,
        s.SupplierID,
        ps.SalesID,
        pi.ProductName,
        pi.ProductCategory
      FROM t_ProductInventory pi
      LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
      LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
      LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
      LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
      WHERE pi.ProductID = @ProductID
    END
    ELSE
    BEGIN
      RAISERROR('The specified ProductID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
  ELSE IF @SalesID <> 0 -- Filter by SalesID
  BEGIN
    IF EXISTS (SELECT 1 FROM t_ProductSales WHERE SalesID = @SalesID)
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
    ELSE
    BEGIN
      RAISERROR('The specified ProductID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
  ELSE IF @BrandID <> '' -- Filter by BrandID
  BEGIN
    IF EXISTS (SELECT 1 FROM t_Brand WHERE BrandID = @BrandID)
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
      FROM t_ProductInventory pi
      LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
      INNER JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
      LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
      LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
      WHERE b.BrandID = @BrandID
    END
    ELSE
    BEGIN
      RAISERROR('The specified BrandID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
  ELSE IF @SupplierID <> '' -- Filter by SupplierID
  BEGIN
    IF EXISTS (SELECT 1 FROM t_Supplier WHERE SupplierID = @SupplierID)
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
      FROM t_ProductInventory pi
      LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
      INNER JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
      LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
      LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
      WHERE s.SupplierID = @SupplierID
    END
    ELSE
    BEGIN
      RAISERROR('The specified SupplierID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
  ELSE -- No filters provided, return all data
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
@ProductID = P001;

EXEC sp_SearchRecords 
@SupplierID = S002;

EXEC sp_SearchRecords 
@BrandID = B001;

EXEC sp_SearchRecords 
@SalesID = 1;

EXEC sp_SearchRecords
@OrderID=2;

