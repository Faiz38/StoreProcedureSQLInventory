CREATE PROCEDURE sp_DeleteData
  @ProductID NVARCHAR(20) = NULL,
  @BrandID NVARCHAR(20) = NULL,
  @SupplierID NVARCHAR(20) = NULL,
  @OrderID INT = NULL,
  @ReceiveID INT = NULL
AS
BEGIN
  -- Delete from t_ProductInventory and t_ProductSales based on ProductID
  IF (@ProductID IS NOT NULL)
  BEGIN
    DELETE FROM t_ProductSales WHERE InventoryID IN (SELECT InventoryID FROM t_ProductInventory WHERE ProductID = @ProductID);
    DELETE FROM t_ProductInventory WHERE ProductID = @ProductID;
  END

  -- Delete from t_Brand based on BrandID
  IF (@BrandID IS NOT NULL)
  BEGIN
    DELETE FROM t_Brand WHERE BrandID = @BrandID;
  END

  -- Delete from t_Supplier based on SupplierID
  IF (@SupplierID IS NOT NULL)
  BEGIN
    DELETE FROM t_Supplier WHERE SupplierID = @SupplierID;
  END

  -- Delete from t_Order based on OrderID
  IF (@OrderID IS NOT NULL)
  BEGIN
    DELETE FROM t_Order WHERE OrderID = @OrderID;
  END

  -- Delete from t_Receive based on ReceiveID
  IF (@ReceiveID IS NOT NULL)
  BEGIN
    DELETE FROM t_Receive WHERE ReceiveID = @ReceiveID;
  END
END;

EXEC sp_DeleteData
  @ProductID = 'P123';

EXEC sp_DeleteData
  @BrandID = 'B123';

EXEC sp_DeleteData
  @SupplierID = 'S123';

EXEC sp_DeleteData
  @OrderID = 1;

EXEC sp_DeleteData
  @ReceiveID = 1;
