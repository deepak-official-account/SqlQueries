CREATE TABLE dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR (50) NOT NULL,
    LastName NVARCHAR (50) NOT NULL,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

PRINT 'Employees table created successfully';
GO

INSERT INTO
    dbo.Employees (
        EmployeeID,
        FirstName,
        LastName,
        HireDate,
        Salary
    )
VALUES (
        1,
        'John',
        'Smith',
        '2020-01-15',
        75000.00
    ),
    (
        2,
        'Sarah',
        'Johnson',
        '2019-05-22',
        82000.50
    ),
    (
        3,
        'Michael',
        'Williams',
        '2021-03-10',
        68000.75
    ),
    (
        4,
        'Emily',
        'Brown',
        '2018-11-05',
        91000.00
    ),
    (
        5,
        'David',
        'Jones',
        '2022-02-28',
        72000.25
    );

PRINT '5 records inserted into Employees table';
GO

--Create Procedure
IF OBJECT_ID ('dbo.GetEmployees', 'P') IS NOT NULL PRINT 'Deleting Existing Procedure'
DROP PROCEDURE dbo.GetEmployees;
GO

CREATE PROCEDURE dbo.GetEmployees
AS
BEGIN 
    SELECT * FROM dbo.Employees;
END;
GO

-- CREATE UPDATE DELETE IN SINGLE PROCEDURE
IF(
    OBJECT_ID ('dbo.PerformOperations', 'P')
) IS NOT NULL BEGIN PRINT 'Deleting Existing Procedure'
DROP PROCEDURE dbo.PerformOperations;

END

CREATE PROCEDURE [dbo].[PerformOperations]
    @IsInsertOperation BIT,
    @IsDeleteOperation BIT,
    @IsUpdateOperation BIT,
    @EmployeeID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @HireDate DATE,
    @Salary DECIMAL(10,2)
AS
BEGIN
    IF @IsInsertOperation = 1
    BEGIN
        INSERT INTO dbo.Employees (
            EmployeeID,
            FirstName,
            LastName,
            HireDate,
            Salary
        )
        VALUES (
            @EmployeeID,
            @FirstName,
            @LastName,
            @HireDate,
            @Salary
        )
    END
    
    IF @IsUpdateOperation = 1
    BEGIN
        UPDATE dbo.Employees 
        SET FirstName = @FirstName,
            LastName = @LastName,
            HireDate = @HireDate,
            Salary = @Salary
        WHERE EmployeeID = @EmployeeID;
    END
    
    IF @IsDeleteOperation = 1
    BEGIN
        DELETE FROM dbo.Employees 
        WHERE EmployeeID = @EmployeeID;
    END
END

IF(
    (
        OBJECT_ID ('dbo.GetOperations', 'P')
    )
) IS NOT NULL BEGIN PRINT 'Deleting Exisitng Procedure'
DROP PROCEDURE dbo.GetOperations END

CREATE PROCEDURE [dbo].[GetOperations]
 @IsGetAllOperation BIT,
 @IsGetByEmployeeIdOperation BIT,
 @EmployeeID INT
AS
BEGIN
    IF @IsGetAllOperation=1
	BEGIN
    SELECT * FROM dbo.Employees;
	END

	IF @IsGetByEmployeeIdOperation=1
	BEGIN
	SELECT * FROM dbo.Employees WHERE EmployeeID=@EmployeeID;
	END
END

--Pagination
SELECT *
FROM Employees
ORDER BY EmployeeID
OFFSET
    2 ROWS FETCH NEXT 2 ROWS ONLY;

IF(
    OBJECT_ID ('dbo.GetPaginatedResult', 'P')
) IS NOT NULL PRINT 'Deleting Previous Procedure'
DROP PROCEDURE dbo.GetPaginatedResult

CREATE PROCEDURE [dbo].[GetPaginatedResult]
  @PageNo INT,
  @Limit INT
  AS
  BEGIN
  SELECT * FROM Employees ORDER BY EmployeeID ASC OFFSET @PageNo-1 ROWS
  FETCH NEXT @Limit ROWS ONLY
  END
GO