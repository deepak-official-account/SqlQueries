role : id rolename isAcitve createdat updatedat

use db;

CREATE TABLE ROLES (
    RoleId INT PRIMARY KEY IDENTITY (1, 1),
    Role NVARCHAR (100),
    IsActive BIT,
    CreatedAt DateTime,
    UpdatedAt DateTime
);

CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY (1, 1),
    Name Nvarchar (100) UNIQUE NOT NULL,
    RoleId INT FOREIGN KEY REFERENCES ROLES (RoleId),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    DeletedAt DATETIME
);
--DROP TABLE Users;
--DROP TABLE Roles;
Select * from Users;

Select * from Roles;

--Add user
CREATE PROCEDURE [dbo].[AddUser]
  @Name Nvarchar(100),
  @RoleId INT ,
  @UpdatedAt DATETIME,
  @DeletedAt DATETIME
  AS
  BEGIN
  DECLARE  @CreatedAt DATETIME =CURRENT_TIMESTAMP;
  INSERT INTO Users (Name ,
  RoleId ,
  CreatedAt ,
  UpdatedAt ,
  DeletedAt )
  VALUES
  (
  @Name ,
  @RoleId ,
    @CreatedAt ,
    @UpdatedAt ,
    @DeletedAt 
  )
  END;
GO

--DROP PROCEDURE [dbo].[AddUser]

--Get all

CREATE PROCEDURE [dbo].[GetAllUsers]
AS
BEGIN
  SELECT u.* from Users u inner join Roles r on  u.RoleId =r.RoleId WHERE r.IsActive=1;
END;
GO

-- Get user by id if active
CREATE PROCEDURE [dbo].[GetActiveUserById]
@UserId INT
AS
BEGIN
    Select u.* FROM Users u inner join Roles r on u.RoleId=r.RoleId WHERE Id=@UserId AND r.IsActive=1;
	

END;
GO

DECLARE @UserId INT=99;

--Update 
CREATE PROCEDURE [dbo].[UpdateUser]
@UserId INT,
@Name NVARCHAR(100),
@RoleId INT
AS
BEGIN
  DECLARE @UpdatedAt DATETIME = CURRENT_TIMESTAMP;
  Update Users SET  Name=@Name ,
  RoleId=@RoleId ,
    UpdatedAt=@UpdatedAt WHERE Id=@UserId ;
END;
Go
--Delete

CREATE PROCEDURE [dbo].[DeleteUser]
@UserId INT
AS
BEGIN

  DELETE FROM Users WHERE Id=@UserId ;
END;
GO
EXEC [dbo].[GetActiveUserById] @UserId