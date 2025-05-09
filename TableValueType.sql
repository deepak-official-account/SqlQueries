-- Create the type
CREATE TYPE EmployeeTableType AS TABLE
(
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL,
    Department NVARCHAR(50),
    Position NVARCHAR(50)
);
GO

-- Create the procedure
CREATE PROCEDURE InsertInEmployeeTable
    @EmployeeTableType EmployeeTableType READONLY
AS
BEGIN
    INSERT INTO Employee (FirstName, LastName, Email, HireDate, Department, Position)
    SELECT FirstName, LastName, Email, HireDate, Department, Position 
    FROM @EmployeeTableType;
END
GO

-- Declare and use the variable in the same batch
DECLARE @EmployeeTableType EmployeeTableType;

INSERT INTO
    @EmployeeTableType (
        FirstName,
        LastName,
        Email,
        HireDate,
        Department,
        Position
    )
VALUES (
        'Kanha',
        'yadav',
        'kanha.yadav@company.com',
        '2020-05-15',
        'CEO',
        'Software Developer'
    ),
    (
        'SHiva',
        'Bhole',
        'shiva.bhole@company.com',
        '2019-03-10',
        'CTO',
        'HR Manager'
    );

EXEC InsertInEmployeeTable @EmployeeTableType;

-- I need to execute the entire code as a whole
SELECT *
FROM Employee;