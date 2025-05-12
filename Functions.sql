CREATE FUNCTION GetAllEmployees()
RETURNS TABLE
AS
RETURN (
    SELECT * FROM dbo.Employees
);
GO
-- directly call the returned value
SELECT * FROM GetAllEmployees ();

CREATE FUNCTION GetEmployeeById (@EmployeeId INT) RETURNS
TABLE
RETURN (
    SELECT *
    FROM dbo.Employees
    where
        EmployeeID = @EmployeeId
)
-- execute both below lines at the same time
DECLARE @EmployeeId INT = 1;

Select *
FROM GetEmployeeById (@EmployeeId);