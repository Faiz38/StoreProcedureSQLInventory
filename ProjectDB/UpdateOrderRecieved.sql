USE [Final_Project]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddToReceive]    Script Date: 17/6/2023 3:05:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddToReceive]
  @OrderID INT,
  @OrderStatus NVARCHAR(20),
  @ReceivedStatus NVARCHAR(50)
AS
BEGIN
    UPDATE t_Receive
    SET OrderStatus = @OrderStatus, ReceivedStatus = @ReceivedStatus
    WHERE OrderID = @OrderID

    MERGE t_Order AS Target
	USING t_Receive	AS Source
	-- For Updates
	ON Source.OrderID = Target.OrderID
	WHEN MATCHED THEN UPDATE SET
	Target.OrderStatus	= Source.OrderStatus;
END;

EXEC sp_AddToReceive
  @OrderID = 2,
  @OrderStatus = 'Not Complete',
  @ReceivedStatus = '9';

TRUNCATE TABLE t_Order


SELECT * FROM t_Order
SELECT * FROM t_Receive