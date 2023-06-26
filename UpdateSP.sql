ALTER PROCEDURE sp_UpdateData
  @ProductID NVARCHAR(20) = NULL,
  @ProductName NVARCHAR(50) = NULL,
  @ProductCategory NVARCHAR(50) = NULL,
  @CurrentUnitLeft INT = NULL,
  @ProductQuantity INT = NULL,
  @ProductUnitPrice FLOAT = NULL,
  @ProductUnitSold INT = NULL,
  @ProductTotalValue FLOAT = NULL,
  @BrandID NVARCHAR(20) = NULL,
  @BrandName NVARCHAR(50) = NULL,
  @BrandWebsite NVARCHAR(20) = NULL,
  @SupplierID NVARCHAR(20) = NULL,
  @SupplierName NVARCHAR(50) = NULL,
  @SupplierContact NVARCHAR(20) = NULL,
  @SupplierTitle NVARCHAR(20) = NULL,
  @SupplierAddress NVARCHAR(20) = NULL,
  @SupplierCity NVARCHAR(20) = NULL,
  @SupplierCountry NVARCHAR(20) = NULL,
  @SupplierPhone NVARCHAR(20) = NULL,
  @SupplierEmail NVARCHAR(20) = NULL,
  @SupplierWebsite NVARCHAR(20) = NULL,
  @OrderID INT = NULL,
  @OrderDate NVARCHAR(20) = NULL,
  @OrderStatus NVARCHAR(20) = NULL,
  @ProductNameOrder NVARCHAR(50) = NULL,
  @OrderReceivedQuantity INT = NULL
AS
BEGIN
  -- Update t_ProductInventory based on ProductID
  IF (@ProductID IS NOT NULL)
  BEGIN
    IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE ProductID = @ProductID)
    BEGIN
      UPDATE t_ProductInventory
      SET
        ProductName = COALESCE(@ProductName, ProductName),
        ProductCategory = COALESCE(@ProductCategory, ProductCategory),
        CurrentUnitLeft = COALESCE(@CurrentUnitLeft, CurrentUnitLeft)
      WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
      RAISERROR('The specified ProductID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END

  -- Update t_Brand based on BrandID
  IF (@BrandID IS NOT NULL)
  BEGIN
    IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE BrandID = @BrandID)
    BEGIN
      UPDATE t_Brand
      SET
        BrandName = COALESCE(@BrandName, BrandName),
        BrandWebsite = COALESCE(@BrandWebsite, BrandWebsite)
      WHERE BrandID = @BrandID;
    END
    ELSE
    BEGIN
      RAISERROR('The specified BrandID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END

  -- Update t_Supplier based on SupplierID
  IF (@SupplierID IS NOT NULL)
  BEGIN
    IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE SupplierID = @SupplierID)
    BEGIN
      UPDATE t_Supplier
      SET
        SupplierName = COALESCE(@SupplierName, SupplierName),
        SupplierContact = COALESCE(@SupplierContact, SupplierContact),
        SupplierTitle = COALESCE(@SupplierTitle, SupplierTitle),
        SupplierAddress = COALESCE(@SupplierAddress, SupplierAddress),
        SupplierCity = COALESCE(@SupplierCity, SupplierCity),
        SupplierCountry = COALESCE(@SupplierCountry, SupplierCountry),
        SupplierPhone = COALESCE(@SupplierPhone, SupplierPhone),
        SupplierEmail = COALESCE(@SupplierEmail, SupplierEmail),
        SupplierWebsite = COALESCE(@SupplierWebsite, SupplierWebsite)
      WHERE SupplierID = @SupplierID;
    END
    ELSE
    BEGIN
      RAISERROR('The specified SupplierID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END

  -- Update t_Order based on OrderID
  IF (@OrderID IS NOT NULL)
  BEGIN
    IF EXISTS (SELECT 1 FROM t_Order WHERE OrderID = @OrderID)
    BEGIN
      UPDATE t_Order
      SET
        ProductID = COALESCE(@ProductID, ProductID),
        OrderDate = COALESCE(@OrderDate, OrderDate),
        OrderStatus = COALESCE(@OrderStatus, OrderStatus)
      WHERE OrderID = @OrderID;
    END
    ELSE
    BEGIN
      RAISERROR('The specified OrderID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END

  -- Update t_Receive based on ReceiveID
  IF (@OrderID IS NOT NULL AND @OrderReceivedQuantity IS NOT NULL)
  BEGIN
    IF EXISTS (SELECT 1 FROM t_Receive WHERE OrderID = @OrderID)
    BEGIN
      EXEC sp_AddToReceive
        @OrderID = @OrderID,
        @OrderStatus = @OrderStatus,
        @OrderReceivedQuantity = @OrderReceivedQuantity;
    END
    ELSE
    BEGIN
      RAISERROR('The specified OrderID does not exist or is incorrect.', 16, 1);
      RETURN;
    END
  END
END;


select* from t_ProductInventory
select* from t_ProductSales

--Test
EXEC sp_UpdateData
  @ProductID = 'PD002',
  @ProductQuantity = 1,
  @ProductUnitPrice = 100,
  @ProductName = 'New Proajdsiuct Name';

EXEC sp_UpdateData
  @SupplierID = 'S002',
  @SupplierName = 'New Name3'

EXEC sp_UpdateData
  @BrandID = 'B002',
  @BrandName = 'New Name3'
EXEC sp_UpdateData
  @OrderID = 1,
  @OrderReceivedQuantity = 300

