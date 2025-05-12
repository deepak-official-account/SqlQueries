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

DECLARE @EmployeeID INT,
    @FirstName NVARCHAR(50) ,
    @LastName NVARCHAR(50) ,
    @HireDate DATE,
    @Salary DECIMAL(10,2);
Select (EmployeeID,FirstName,LastName,HireDate,Salary) from Employees into @EmployeeID,@FirstName,@LastName,@HireDate ,@Salary;
Select * From dbo.Employees_Audit;
--DROP PROCEDURE CopyData;
CREATE PROCEDURE CopyData
    
	AS
	BEGIN
	DECLARE @EmployeeID INT,
    @FirstName NVARCHAR(50) ,
    @LastName NVARCHAR(50) ,
    @HireDate DATE,
    @Salary DECIMAL(10,2);

    DECLARE employee_cursor CURSOR FOR
    SELECT EmployeeID, FirstName, LastName, HireDate, Salary 
    FROM dbo.Employees;

    OPEN employee_cursor;

    FETCH NEXT FROM employee_cursor 
    INTO @EmployeeID, @FirstName, @LastName, @HireDate, @Salary;

    WHILE @@FETCH_STATUS = 0  -- Check if the cursor has more rows to fetch
    BEGIN

	INSERT INTO dbo.Employees_Audit ( EmployeeID, FirstName, LastName, HireDate, Salary) 
	values  ( @EmployeeID, @FirstName, @LastName, @HireDate, @Salary);

    FETCH NEXT FROM employee_cursor 
    INTO @EmployeeID, @FirstName, @LastName, @HireDate, @Salary;
END


CLOSE employee_cursor;
	END
GO

EXEC CopyData;

Select * From dbo.Employees_Audit;