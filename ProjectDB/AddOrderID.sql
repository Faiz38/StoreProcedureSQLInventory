ALTER PROCEDURE [dbo].[sp_AddOrder]
  @OrderID INT,
  @ProductID NVARCHAR(20),
  @OrderStatus NVARCHAR(20),
  @OrderQuantity INT,
  @OrderDate DATETIME = NULL
AS
BEGIN
  SET IDENTITY_INSERT t_Order ON;

  IF @OrderDate IS NULL
    SET @OrderDate = GETDATE();

  -- Check if the @ProductID exists in the other table
  IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE ProductID = @ProductID)
  BEGIN
    INSERT INTO t_Order (OrderID, ProductID, OrderDate, OrderStatus, OrderQuantity)
    VALUES (@OrderID, @ProductID, @OrderDate, @OrderStatus, @OrderQuantity);

    MERGE t_Receive AS Target
    USING t_Order AS Source
    -- For Inserts
    ON Source.OrderID = Target.OrderID
    WHEN NOT MATCHED BY Target THEN
      INSERT (OrderID, ProductID, OrderDate, OrderStatus, OrderQuantity, OrderReceivedQuantity) 
      VALUES (Source.OrderID,Source.ProductID, Source.OrderDate, Source.OrderStatus, Source.OrderQuantity, 0)
    -- For Updates
    WHEN MATCHED THEN UPDATE SET
      Target.OrderStatus = Source.OrderStatus;

    SET IDENTITY_INSERT t_Order OFF;
  END
  ELSE
  BEGIN
    -- Handle the case when the @ProductID does not exist in the other table or is not equal to '4'
    RAISERROR ('The specified ProductID does not exist or is wrong ProductID.', 16, 1);
    RETURN;
  END
END




EXEC sp_AddOrder
  @OrderID = 1,
  @ProductID = 'PD123',
  @OrderStatus = 'Pending',
  @OrderQuantity = 5

SELECT * FROM t_Order
SELECT * FROM t_Receive
SELECT * FROM t_ProductSales

