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
  @ReceiveID INT = NULL,
  @ReceivedStatus NVARCHAR(50) = NULL
AS
BEGIN
  -- Update t_ProductInventory based on ProductID
  IF (@ProductID IS NOT NULL)
  BEGIN
    UPDATE t_ProductInventory
    SET
      ProductName = COALESCE(@ProductName, ProductName),
      ProductCategory = COALESCE(@ProductCategory, ProductCategory),
      CurrentUnitLeft = COALESCE(@CurrentUnitLeft, CurrentUnitLeft)
    WHERE ProductID = @ProductID;
  END

  -- Update t_ProductSales based on ProductID
  IF (@ProductID IS NOT NULL)
  BEGIN
    UPDATE t_ProductSales
    SET
      ProductName = COALESCE(@ProductName, ProductName),
      ProductCategory = COALESCE(@ProductCategory, ProductCategory),
      ProductQuantity = COALESCE(@ProductQuantity, ProductQuantity),
      ProductUnitPrice = COALESCE(@ProductUnitPrice, ProductUnitPrice),
      ProductUnitSold = COALESCE(@ProductUnitSold, ProductUnitSold),
      ProductTotalValue = COALESCE(@ProductTotalValue, ProductTotalValue)
    WHERE InventoryID IN (SELECT InventoryID FROM t_ProductInventory WHERE ProductID = @ProductID);
  END

  -- Update t_Brand based on BrandID
  IF (@BrandID IS NOT NULL)
  BEGIN
    UPDATE t_Brand
    SET
      BrandName = COALESCE(@BrandName, BrandName),
      BrandWebsite = COALESCE(@BrandWebsite, BrandWebsite)
    WHERE BrandID = @BrandID;
  END

  -- Update t_Supplier based on SupplierID
  IF (@SupplierID IS NOT NULL)
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

  -- Update t_Order based on OrderID
  IF (@OrderID IS NOT NULL)
  BEGIN
    UPDATE t_Order
    SET
      ProductID = COALESCE(@ProductID, ProductID),
      OrderDate = COALESCE(@OrderDate, OrderDate),
      OrderStatus = COALESCE(@OrderStatus, OrderStatus),
      ProductName = COALESCE(@ProductNameOrder, ProductName)
    WHERE OrderID = @OrderID;
  END

  -- Update t_Receive based on ReceiveID
  IF (@ReceiveID IS NOT NULL)
  BEGIN
    UPDATE t_Receive
    SET
      OrderID = COALESCE(@OrderID, OrderID),
      OrderDate = COALESCE(@OrderDate, OrderDate),
      OrderStatus = COALESCE(@OrderStatus, OrderStatus),
      OrderQuantity = COALESCE(@ProductQuantity, OrderQuantity),
      ReceivedStatus = COALESCE(@ReceivedStatus, ReceivedStatus)
    WHERE ReceiveID = @ReceiveID;
  END
END;

select* from t_Supplier
EXEC sp_UpdateData
  @ProductID = 'P123',
  @ProductName = 'New Proajdsiuct Name',
  @ProductCategory = 'New Cat[psdjnegory';
