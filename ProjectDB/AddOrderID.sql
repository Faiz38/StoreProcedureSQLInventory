CREATE PROCEDURE sp_AddToReceive
  @OrderID INT,
  @OrderDate NVARCHAR(20),
  @OrderStatus NVARCHAR(20),
  @OrderQuantity INT,
  @ReceivedStatus NVARCHAR(50)
AS
BEGIN
  INSERT INTO t_Receive (OrderID, OrderDate, OrderStatus, OrderQuantity, ReceivedStatus)
  VALUES (@OrderID, @OrderDate, @OrderStatus, @OrderQuantity, @ReceivedStatus);
END;

EXEC sp_AddToReceive
  @OrderID = 2,
  @OrderDate = '2023-06-16',
  @OrderStatus = 'Pending',
  @OrderQuantity = 10,
  @ReceivedStatus = 'Not Received';
