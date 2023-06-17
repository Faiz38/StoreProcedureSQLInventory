--Use to update value in the received
ALTER PROCEDURE [dbo].[sp_AddToReceive]
  @OrderID INT,
  @OrderStatus NVARCHAR(20),
  @OrderReceivedQuantity INT
AS
BEGIN
    DECLARE @ExistingOrderReceivedQuantity NVARCHAR(50);
    DECLARE @ExistingOrderStatus NVARCHAR(20);
    DECLARE @ProductID NVARCHAR(20); -- Add a variable to store the ProductID

    SELECT @ExistingOrderReceivedQuantity = OrderReceivedQuantity, @ExistingOrderStatus = OrderStatus, @ProductID = ProductID
    FROM t_Receive
    WHERE OrderID = @OrderID;

    IF @ExistingOrderStatus = 'Complete'
	BEGIN
        PRINT 'Order Already Received. No changes were made.';
    END
    ELSE
    BEGIN
        IF @ExistingOrderReceivedQuantity IS NULL
        BEGIN
            -- Update t_Receive and another table
            UPDATE t_Receive
            SET OrderStatus = @OrderStatus ,
                OrderReceivedQuantity = @OrderReceivedQuantity,
                RemainingOrderQuantity = OrderQuantity - CAST(@OrderReceivedQuantity AS INT),
                ReceivedOrderDate = CASE WHEN @OrderReceivedQuantity > 0 THEN GETDATE() ELSE NULL END
            WHERE OrderID = @OrderID;

            IF (SELECT RemainingOrderQuantity FROM t_Receive WHERE OrderID = @OrderID) <= 0
                SET @OrderStatus = 'Complete';
            ELSE
                SET @OrderStatus = 'Not Complete';
			--Update quantity on product on t_Product sales table
            UPDATE t_ProductSales
            SET ProductQuantity = ProductQuantity + @OrderReceivedQuantity
            WHERE ProductID = @ProductID;

            -- Update t_Order
            UPDATE t_Order
            SET OrderStatus = @OrderStatus
            WHERE OrderID = @OrderID;

            MERGE t_Order AS Target
            USING t_Receive AS Source
            ON Source.OrderID = Target.OrderID
            WHEN MATCHED THEN UPDATE SET Target.OrderStatus = Source.OrderStatus;
        END

        ELSE IF @ExistingOrderReceivedQuantity IS NOT NULL AND @ExistingOrderStatus = 'Pending'
        BEGIN
            -- Update t_Receive and another table
            UPDATE t_Receive
            SET OrderReceivedQuantity = OrderReceivedQuantity + @OrderReceivedQuantity,
                RemainingOrderQuantity = OrderQuantity - (CAST(OrderReceivedQuantity AS INT) + CAST(@OrderReceivedQuantity AS INT)),
                ReceivedOrderDate = CASE WHEN OrderReceivedQuantity + @OrderReceivedQuantity > 0 THEN GETDATE() ELSE NULL END
            WHERE OrderID = @OrderID;

            IF (SELECT RemainingOrderQuantity FROM t_Receive WHERE OrderID = @OrderID) <= 0
                SET @OrderStatus = 'Complete';

            UPDATE t_ProductSales
            SET ProductQuantity = ProductQuantity + @OrderReceivedQuantity
            WHERE ProductID = @ProductID;

            -- Update t_Order
            UPDATE t_Order
            SET OrderStatus = @OrderStatus
            WHERE OrderID = @OrderID;

            MERGE t_Order AS Target
            USING t_Receive AS Source
            ON Source.OrderID = Target.OrderID
            WHEN MATCHED THEN UPDATE SET Target.OrderStatus = Source.OrderStatus;
        END
        ELSE
        BEGIN
            PRINT 'Data already exists. No changes were made.';
        END;
    END;
END;

EXEC sp_AddToReceive
  @OrderID = 1,
  @OrderStatus = 'Pending',
  @OrderReceivedQuantity =  5

  
SELECT * FROM t_Order
SELECT * FROM t_Receive
SELECT * FROM t_ProductSales
