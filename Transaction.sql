CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR (50) NOT NULL,
    LastName NVARCHAR (50) NOT NULL,
    Email NVARCHAR (100) UNIQUE,
    HireDate DATE NOT NULL,
    Department NVARCHAR (50),
    Position NVARCHAR (50),
    CONSTRAINT CHK_Email CHECK (Email LIKE '%_@__%.__%')
);

CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY IDENTITY (1, 1),
    EmployeeID INT NOT NULL,
    BasicSalary DECIMAL(10, 2) NOT NULL,
    Allowances DECIMAL(10, 2) DEFAULT 0,
    Deductions DECIMAL(10, 2) DEFAULT 0,
    EffectiveDate DATE NOT NULL,
    --CONSTRAINT FK_Salary_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT CHK_BasicSalary CHECK (BasicSalary > 0)
);

INSERT INTO
    Employee (
        FirstName,
        LastName,
        Email,
        HireDate,
        Department,
        Position
    )
VALUES (
        'John',
        'Doe',
        'john.doe@company.com',
        '2020-05-15',
        'IT',
        'Software Developer'
    ),
    (
        'Jane',
        'Smith',
        'jane.smith@company.com',
        '2019-03-10',
        'HR',
        'HR Manager'
    ),
    (
        'Robert',
        'Johnson',
        'robert.johnson@company.com',
        '2021-01-20',
        'Finance',
        'Accountant'
    ),
    (
        'Emily',
        'Williams',
        'emily.williams@company.com',
        '2018-11-05',
        'Marketing',
        'Marketing Specialist'
    ),
    (
        'Michael',
        'Brown',
        'michael.brown@company.com',
        '2022-02-28',
        'IT',
        'System Administrator'
    );

INSERT INTO
    Salary (
        EmployeeID,
        BasicSalary,
        Allowances,
        Deductions,
        EffectiveDate
    )
VALUES (
        1,
        75000.00,
        5000.00,
        2000.00,
        '2023-01-01'
    ),
    (
        2,
        85000.00,
        7000.00,
        2500.00,
        '2023-01-01'
    ),
    (
        3,
        65000.00,
        4000.00,
        1500.00,
        '2023-01-01'
    ),
    (
        4,
        70000.00,
        4500.00,
        1800.00,
        '2023-01-01'
    ),
    (
        5,
        72000.00,
        4800.00,
        1900.00,
        '2023-01-01'
    );

--DROP PROCEDURE InsertInEmpAndSal
CREATE PROCEDURE InsertInEmpAndSal
	@FirstName NVARCHAR(50) ,
    @LastName NVARCHAR(50) ,
    @Email NVARCHAR(100) ,
    @HireDate DATE ,
    @Department NVARCHAR(50),
    @Position NVARCHAR(50),
    @BasicSalary DECIMAL(10,2) ,
    @Allowances DECIMAL(10,2) ,
    @Deductions DECIMAL(10,2) ,
    @EffectiveDate DATE ,
	@EmployeeID INT
	AS
	BEGIN
	BEGIN TRANSACTION 
	DECLARE @TransactionFailed BIT =0;
	INSERT INTO Employee (FirstName, LastName, Email, HireDate, Department, Position) VALUES 
    (@FirstName, @LastName, @Email, @HireDate, @Department, @Position);
	
	IF(@@ROWCOUNT=0)
	BEGIN
	SET @TransactionFailed=1;
	PRINT 'Transaction Failed';
	END

	
	INSERT INTO Salary ( EmployeeID,BasicSalary, Allowances, Deductions, EffectiveDate)
    VALUES 
    (@EmployeeID,@BasicSalary, @Allowances, @Deductions, @EffectiveDate);
	IF(@@ROWCOUNT=0)
	BEGIN

		PRINT 'Transaction Failed ';

	END
	ELSE
	BEGIN
	COMMIT TRANSACTION
	END
	END
GO

EXEC InsertInEmpAndSal @FirstName = 'Sarah',
@LastName = 'Connor',
@Email = 'sarah.connor@company.com',
@HireDate = '2023-06-15',
@Department = 'IT',
@Position = 'Security Specialist',
@BasicSalary = 80000.00,
@Allowances = 6000.00,
@Deductions = 2200.00,
@EmployeeID = 6,
@EffectiveDate = '2023-06-15';

Select * from Employee;

Select * From Salary;