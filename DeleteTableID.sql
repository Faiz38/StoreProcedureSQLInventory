ALTER PROCEDURE sp_DeleteData
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
  IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE ProductID = @ProductID)
  BEGIN
    DELETE FROM t_ProductSales WHERE InventoryID IN (SELECT InventoryID FROM t_ProductInventory WHERE ProductID = @ProductID);
    DELETE FROM t_ProductInventory WHERE ProductID = @ProductID;
  END
  ELSE
    BEGIN
      RAISERROR('The specified ProductID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
	END

  -- Delete from t_Brand based on BrandID
  IF (@BrandID IS NOT NULL)
  BEGIN
  IF EXISTS (SELECT 1 FROM t_Brand WHERE BrandID = @BrandID)
  BEGIN
    DELETE FROM t_Brand WHERE BrandID = @BrandID;
  END
    ELSE
    BEGIN
      RAISERROR('The specified BrandID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
	END

  -- Delete from t_Supplier based on SupplierID
  IF (@SupplierID IS NOT NULL)
  BEGIN
  IF EXISTS (SELECT 1 FROM t_Supplier WHERE SupplierID = @SupplierID)
  BEGIN
    DELETE FROM t_Supplier WHERE SupplierID = @SupplierID;
  END
      ELSE
    BEGIN
      RAISERROR('The specified SupplierID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
	END
END;

EXEC sp_DeleteData
  @ProductID = 'P003';

EXEC sp_DeleteData
  @BrandID = 'B001';

EXEC sp_DeleteData
  @SupplierID = 'S002';

