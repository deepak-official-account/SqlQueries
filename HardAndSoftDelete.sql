use db;

CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY (1, 1),
    Name NVARCHAR (100),
    Email NVARCHAR (100),
    isActive BIT
);

INSERT INTO
    Users (Name, Email, isActive)
VALUES (
        'Alice Johnson',
        'alice.johnson@example.com',
        1
    ),
    (
        'Bob Smith',
        'bob.smith@example.com',
        0
    ),
    (
        'Carol Lee',
        'carol.lee@example.com',
        1
    ),
    (
        'David Kim',
        'david.kim@example.com',
        0
    ),
    (
        'Eva Chen',
        'eva.chen@example.com',
        1
    ),
    (
        'Frank Garcia',
        'frank.garcia@example.com',
        1
    ),
    (
        'Grace Hall',
        'grace.hall@example.com',
        0
    ),
    (
        'Henry Adams',
        'henry.adams@example.com',
        1
    );

select * from Users;

select * from Users where isActive = 1;