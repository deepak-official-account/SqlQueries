use db;
---create table
IF NOT EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.TABLES
    WHERE
        TABLE_NAME = 'Invoices'
        AND TABLE_SCHEMA = 'dbo'
) BEGIN
CREATE TABLE dbo.Invoices (
    InvoiceId INT PRIMARY KEY,
    CustomerName NVARCHAR (255),
    Amount DECIMAL(10, 2),
    CreatedAt DATETIME DEFAULT GETDATE ()
) END ELSE BEGIN PRINT ('Table Already Exist') END

-----update column
IF(
    COL_LENGTH (
        'dbo.Invoices',
        'CustomerName'
    )
) IS NOT NULL BEGIN
ALTER TABLE Invoices
ALTER COLUMN CustomerNam NVARCHAR (500) NOT NULL END ELSE BEGIN PRINT 'Column Not Exist' END

--Delete Operation
IF(
    COL_LENGTH ('dbo.Invoices', 'Amount')
) IS NOT NULL BEGIN
ALTER TABLE dbo.Invoices
DROP COLUMN Amount;

END ELSE BEGIN PRINT 'No Such Column is Present' END