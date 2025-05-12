use db;

select * from STUDENT;

INSERT INTO
    STUDENT (
        PhoneNumber,
        Name,
        Surname,
        Age
    )
VALUES (
        '2345678901',
        'Jane',
        'Smith',
        21
    ),
    (
        '3456789012',
        'Robert',
        'Johnson',
        22
    ),
    (
        '4567890123',
        'Emily',
        'Williams',
        19
    );

DECLARE itr CURSOR FOR
SELECT *
FROM Employee;

OPEN itr FETCH NEXT
FROM itr;