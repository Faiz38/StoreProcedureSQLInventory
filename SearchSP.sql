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

    r.OrderID,
    r.ProductID
    -- Select the desired columns from t_Receive

  FROM t_ProductInventory pi
  LEFT JOIN t_ProductSales ps ON pi.InventoryID = ps.InventoryID
  LEFT JOIN t_ProductRegister pr ON pi.ProductID = pr.ProductID
  LEFT JOIN t_Brand b ON pr.BrandID = b.BrandID
  LEFT JOIN t_Supplier s ON pr.SupplierID = s.SupplierID
  LEFT JOIN t_Order o ON ps.ProductID = o.ProductID
  LEFT JOIN t_Receive r ON o.OrderID = r.OrderID 

 WHERE pi.ProductID = @ProductID
    AND pr.BrandID = @BrandID
    AND pr.SupplierID = @SupplierID
    AND (@OrderID = 0 OR r.OrderID = @OrderID)
END;



--supplier dgn brand searching guna id disp apa yg patut

select *from t_ProductRegister

EXEC sp_SearchRecords 
@SupplierID = 'PD123';

