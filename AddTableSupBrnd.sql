ALTER PROCEDURE sp_AddBrandAndSupplier
  @SupplierID NVARCHAR(20) = NULL,
  @BrandID NVARCHAR(20) = NULL,
  @SupplierName NVARCHAR(50) = NULL,
  @SupplierContact NVARCHAR(20) = NULL,
  @SupplierTitle NVARCHAR(20) = NULL,
  @SupplierAddress NVARCHAR(20) = NULL,
  @SupplierCity NVARCHAR(20) = NULL,
  @SupplierCountry NVARCHAR(20) = NULL,
  @SupplierPhone NVARCHAR(20) = NULL,
  @SupplierEmail NVARCHAR(20) = NULL,
  @SupplierWebsite NVARCHAR(20) = NULL,
  @BrandName NVARCHAR(50) = NULL,
  @BrandWebsite NVARCHAR(20) = NULL
AS
BEGIN
  -- Insert into t_Supplier if SupplierID is provided
  IF (@SupplierID IS NOT NULL)
  IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE SupplierID  = @SupplierID )
  BEGIN
    INSERT INTO t_Supplier (SupplierID, SupplierName, SupplierContact, SupplierTitle, SupplierAddress, SupplierCity, SupplierCountry, SupplierPhone, SupplierEmail, SupplierWebsite, SupplierCreated, SupplierUpdated)
    VALUES (@SupplierID, @SupplierName, @SupplierContact, @SupplierTitle, @SupplierAddress, @SupplierCity, @SupplierCountry, @SupplierPhone, @SupplierEmail, @SupplierWebsite, GETDATE(), GETDATE());
  END
  ELSE
  BEGIN
    -- Handle the case when the @ProductID does not exist in the other table or is not equal to '4'
    RAISERROR ('The specified ProductID does not exist or is wrong ProductID.', 16, 1);
    RETURN;
  END

  -- Insert into t_Brand if BrandID is provided
  IF (@BrandID IS NOT NULL)
  IF EXISTS (SELECT 1 FROM t_ProductRegister WHERE BrandID  = @BrandID )
  BEGIN
    INSERT INTO t_Brand (BrandID, BrandName, BrandWebsite, BrandCreated, BrandUpdated)
    VALUES (@BrandID, @BrandName, @BrandWebsite, GETDATE(), GETDATE());
  END
  ELSE
  BEGIN
    -- Handle the case when the @ProductID does not exist in the other table or is not equal to '4'
    RAISERROR ('The specified ProductID does not exist or is wrong ProductID.', 16, 1);
    RETURN;
	END
END;

EXEC sp_AddBrandAndSupplier
  @SupplierID = 'S112',
  @SupplierName = 'Supplier Name',
  @SupplierContact = 'Supplier Contact',
  @SupplierTitle = 'Supplier Title',
  @SupplierAddress = 'Supplier Address',
  @SupplierCity = 'Supplier City',
  @SupplierCountry = 'Supplier Country',
  @SupplierPhone = 'Supplier Phone',
  @SupplierEmail = 'Supplier Email',
  @SupplierWebsite = 'Supplier Website';


  EXEC sp_AddBrandAndSupplier
  @BrandID = 'B002',
  @BrandName = 'Brand Name',
  @BrandWebsite = 'Brand Website';

