USE [Final_Project]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddOrder]    Script Date: 17/6/2023 3:21:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddOrder]
  @OrderID INT,
  @ProductID NVARCHAR(20),
  @OrderDate NVARCHAR(20),
  @OrderStatus NVARCHAR(20),
  @OrderQuantity INT
AS
BEGIN
SET IDENTITY_INSERT t_Order ON;
  INSERT INTO t_Order (OrderID, ProductID, OrderDate, OrderStatus, OrderQuantity)
  VALUES (@OrderID, @ProductID, @OrderDate, @OrderStatus, @OrderQuantity);

    MERGE t_Receive AS Target
	USING  t_Order	AS Source
	-- For Inserts
	ON Source.OrderID = Target.OrderID
	WHEN NOT MATCHED BY Target THEN
		INSERT (OrderID, OrderDate, OrderStatus, OrderQuantity, ReceivedStatus) 
		VALUES (Source.OrderID, Source.OrderDate, Source.OrderStatus, Source.OrderQuantity, 0)
	-- For Updates
    WHEN MATCHED THEN UPDATE SET
        Target.OrderStatus	= Source.OrderStatus;
	SET IDENTITY_INSERT t_Order OFF;
END


EXEC sp_AddOrder
  @OrderID = 1,
  @ProductID = 1,
  @OrderDate = '2023-06-16',
  @OrderStatus = 'RECEIVED',
  @OrderQuantity = 100;

SELECT * FROM t_Order
SELECT * FROM t_Receive