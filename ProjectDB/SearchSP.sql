ALTER PROCEDURE sp_SearchRecords
  @ProductID NVARCHAR(20) = '',
  @BrandID NVARCHAR(20) = '',
  @OrderID INT = 0,
  @SupplierID NVARCHAR(20) = '',
  @ReceiveID INT = 0
AS
BEGIN
  SELECT
    pi.ProductID AS InventoryProductID,
    pi.ProductName AS InventoryProductName,
    -- Select the desired columns from t_ProductInventory

    ps.ProductID AS SalesProductID,
    ps.ProductName AS SalesProductName,
    -- Select the desired columns from t_ProductSales

    pr.ProductID AS RegisterProductID,
    pr.ProductName AS RegisterProductName,
    -- Select the desired columns from t_ProductRegister

    b.BrandID,
    b.BrandName,
    b.BrandWebsite,
    -- Select the desired columns from t_Brand

    s.SupplierID,
    s.SupplierName,
    s.SupplierContact,
    -- Select the desired columns from t_Supplier

    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    -- Select the desired columns from t_Order

    r.ReceiveID,
    r.ReceivedStatus
    -- Select the desired columns from t_Receive

  FROM t_ProductInventory pi
  JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
  JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
  JOIN t_Brand b ON pr.BrandID = b.BrandID
  JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
  JOIN t_Order o ON ps.ProductID = o.ProductID
  JOIN t_Receive r ON o.OrderID = r.OrderID

  WHERE pi.ProductID = COALESCE(NULLIF(@ProductID, ''), pi.ProductID)
    AND pr.BrandID = COALESCE(NULLIF(@BrandID, ''), pr.BrandID)
    AND o.OrderID = CASE WHEN @OrderID = 0 THEN o.OrderID ELSE @OrderID END
    AND pr.SupplierID = COALESCE(NULLIF(@SupplierID, ''), pr.SupplierID)
    AND r.ReceiveID = CASE WHEN @ReceiveID = 0 THEN r.ReceiveID ELSE @ReceiveID END;
END;

--supplier dgn brand searching guna id disp apa yg patut

select *from t_ProductRegister

EXEC sp_SearchRecords @ProductID = 'P123';

