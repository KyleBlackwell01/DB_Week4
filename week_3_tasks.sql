--Task 1

DROP PROCEDURE IF EXISTS dbo.MULTIPLY1;
GO

CREATE PROCEDURE MULTIPLY1 @num1 int, @num2 int AS
BEGIN
    SELECT @num1 * @num2
END;

GO

EXEC dbo.MULTIPLY @num1 = '4', @num2 = '5';


--- Task 2
DROP FUNCTION IF EXISTS dbo.test1234;

GO

CREATE FUNCTION test1234 (@num1 INT, @num2 INT) RETURNS NVARCHAR(30) AS
BEGIN
    Return CONCAT('test ', @num1+@num2);
END;

GO

BEGIN  
    SELECT dbo.test1234(12,12);
END;


-- Task 3

-- DDL
DROP TABLE IF EXISTS dbo.LOG;
DROP TABLE IF EXISTS dbo.Account;

CREATE TABLE Account 
(
    AcctNo INT PRIMARY KEY,
    FName VARCHAR(100),
    LName VARCHAR(100),
    CreditLimit INT,
    Balance Int
);

CREATE TABLE LOG
(
    OrigAcct INT,
    LogDateTime DATE,
    RecAcct INT,
    Amount INT,
    PRIMARY KEY (OrigAcct,LogDateTime),
    FOREIGN KEY (OrigAcct) REFERENCES Account,
    FOREIGN KEY (RecAcct) REFERENCES Account
);

-- Test Data 

INSERT INTO Account(AcctNo,FName,LName,CreditLimit,Balance) VALUES
(1,'Test','Simmons',20000,2000),
(2,'Kyle','Blackwell',20000,3000);


-- Stored Procedure 
DROP PROCEDURE IF EXISTS dbo.tests;
GO

CREATE PROCEDURE tests @a1 INT, @a2 INT, @a3 INT AS
BEGIN

    SELECT @a3 = Amount
    FROM dbo.LOG;

    UPDATE Account
    SET Balance = Balance-@a3
    WHERE AcctNo = @a1;

    UPDATE Account
    SET Balance = Balance+@a3
    WHERE AcctNo = @a2;

    INSERT INTO LOG(OrigAcct,LogDateTime,RecAcct,Amount) VALUES
    (@a1,'2018-01-22',@a2,@a3);

END;
GO


-- Procedure Exceution
EXEC tests @a1 = 2, @a2 = 1, @a3 = 110;

SELECT *
FROM LOG;

SELECT *
FROM dbo.ACCOUNT;


--EOF 