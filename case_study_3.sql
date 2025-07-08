create database case_study_3
use case_study_3

select * from Customers
select * from Transactions

 Display the count of customers in each region who have done the
transaction in the year 2020.

select count(C.customer_id) as no_of_customer,Co.region_name, year(T.txn_date) as year
from Customers as C 
inner join Transactions as T 
on C.customer_id = T.customer_id
inner join Continent as Co
on Co.region_id = C.region_id
group by Co.region_name, T.txn_date 
having year(T.txn_date) = 2020

SELECT Co.region_name, COUNT(DISTINCT C.customer_id) AS customer_count
FROM Customers AS C
INNER JOIN Transactions AS T ON C.customer_id = T.customer_id
INNER JOIN Continent AS Co ON Co.region_id = C.region_id
WHERE YEAR(T.txn_date) = 2020
GROUP BY Co.region_name;

--Display the maximum and minimum transaction amount of each
--transaction type.

select * from Transactions
select max(txn_amount) as max_txn , min(txn_amount) as min_txn ,txn_type
from Transactions group by txn_type

--Display the customer id, region name and transaction amount where
--transaction type is deposit and transaction amount > 2000.

select C.customer_id, Co.region_name, T.txn_amount from Customers as C
join Continent as Co 
on Co.region_id = C.region_id
join Transactions as T
on T.customer_id = C.customer_id
where T.txn_type = 'deposit' and T.txn_amount > 2000

--Find duplicate records in the Customer table
select * from Customers


SELECT customer_id, COUNT(*) AS duplicate_count
FROM Customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

5. Display the customer id, region name, transaction type and transaction
   amount for the minimum transaction amount in deposit.
   select * from Transactions
select C.customer_id, Co.region_name, T.txn_amount from Customers as C
join Continent as Co 
on Co.region_id = C.region_id
join Transactions as T
on T.customer_id = C.customer_id
where T.Txn_Type = 'deposit' and T.txn_amount =  (
      SELECT MIN(txn_amount)
      FROM Transactions
      WHERE txn_type = 'deposit'
  );

--  6. Create a stored procedure to display details of customers in the
--Transaction table where the transaction date is greater than Jun 2020.

 CREATE PROCEDURE GetCustomerAfterJune2020
AS
BEGIN
    SELECT 
        C.customer_id,
        
        T.txn_date,
        T.txn_type,
        T.txn_amount
    FROM Customers AS C
    INNER JOIN Transactions AS T ON C.customer_id = T.customer_id
    WHERE T.txn_date > '2020-06-30';
END;
EXEC GetCustomersAfterJune2020;

create procedure continent_details
as begin
select * from Continent
end
exec continent_details

Create a stored procedure to display the details of transactions that
happened on a specific day.

CREATE PROCEDURE GetTransactionsByDate
    @TxnDate DATE
AS
BEGIN
    SELECT 
     
        T.customer_id,
        T.txn_date,
        T.txn_type,
        T.txn_amount
    FROM Transactions AS T
    WHERE CAST(T.txn_date AS DATE) = @TxnDate;
END;
EXEC GetTransactionsByDate @TxnDate = '2020-01-11';
select * from transactions

--Create a user defined function to add 10% of the transaction amount in a
--table.
CREATE FUNCTION dbo.AddTenPercent
(
    @Amount DECIMAL(18, 2)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN @Amount * 1.10;
END;

SELECT 
   
    txn_amount,
    dbo.AddTenPercent(txn_amount) AS updated_amount
FROM Transactions;
begin transaction
UPDATE Transactions
SET txn_amount = dbo.AddTenPercent(txn_amount)
WHERE txn_type = 'deposit';
rollback transaction


--Create a user defined function to find the total transaction amount for a
--given transaction type.

CREATE FUNCTION dbo.GetTotalTxnAmountByType
(
    @TxnType VARCHAR(50)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(18, 2);

    SELECT @TotalAmount = SUM(txn_amount)
    FROM Transactions
    WHERE txn_type = @TxnType;

    RETURN ISNULL(@TotalAmount, 0);
END;

SELECT dbo.GetTotalTxnAmountByType('deposit') AS TotalDepositAmount;


--Create a table value function which comprises the columns customer_id,
--region_id ,txn_date , txn_type , txn_amount which will retrieve data from
--the above table


CREATE FUNCTION dbo.GetCustomerTransactionData()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        C.customer_id,
        C.region_id,
        T.txn_date,
        T.txn_type,
        T.txn_amount
    FROM Customers AS C
    INNER JOIN Transactions AS T
        ON C.customer_id = T.customer_id
);

SELECT * FROM dbo.GetCustomerTransactionData();

Create a TRY...CATCH block to print a region id and region name in a
single column.

BEGIN TRY
    SELECT 
        CAST(region_id AS VARCHAR) + ' - ' + region_name AS RegionInfo
    FROM Continent;
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
END CATCH;

Create a TRY...CATCH block to insert a value in the Continent table.

BEGIN TRY
    INSERT INTO Continent (region_id, region_name)
    VALUES (101, 'South Asia');

    PRINT 'Insert successful.';
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
END CATCH;

--Create a trigger to prevent deleting a table in a database.
CREATE TRIGGER PreventTableDrop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'You are not allowed to drop tables in this database.';
    ROLLBACK;
END;

--Create a trigger to audit the data in a table.

CREATE TABLE TransactionAudit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    action_type VARCHAR(10),
    txn_id INT,
    customer_id INT,
    txn_date DATETIME,
    txn_type VARCHAR(50),
    txn_amount DECIMAL(18, 2),
    action_time DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_AuditTransactions
ON Transactions
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- For INSERT
    INSERT INTO TransactionAudit (action_type, txn_id, customer_id, txn_date, txn_type, txn_amount)
    SELECT 'INSERT', txn_id, customer_id, txn_date, txn_type, txn_amount
    FROM inserted;

    -- For DELETE
    INSERT INTO TransactionAudit (action_type, txn_id, customer_id, txn_date, txn_type, txn_amount)
    SELECT 'DELETE', txn_id, customer_id, txn_date, txn_type, txn_amount
    FROM deleted;

    -- For UPDATE
    -- (To avoid double-logging, optionally skip or separate it from INSERT/DELETE)
END;

Create a trigger to prevent login of the same user id in multiple pages.

CREATE TABLE UserSessions (
    user_id INT PRIMARY KEY,
    login_time DATETIME DEFAULT GETDATE(),
    is_logged_in BIT DEFAULT 1
);

-- Step 1: Declare and set a test user ID
DECLARE @UserID INT = 101;  -- Change this to test with other user IDs

-- Step 2: Check if user is already logged in
IF EXISTS (
    SELECT 1 
    FROM UserSessions 
    WHERE user_id = @UserID AND is_logged_in = 1
)
BEGIN
    PRINT '❌ User is already logged in from another session.';
END
ELSE
BEGIN
    -- Step 3: Either insert a new session or update the existing one
    MERGE UserSessions AS target
    USING (SELECT @UserID AS user_id) AS source
    ON target.user_id = source.user_id
    WHEN MATCHED THEN
        UPDATE SET login_time = GETDATE(), is_logged_in = 1
    WHEN NOT MATCHED THEN
        INSERT (user_id, login_time, is_logged_in)
        VALUES (@UserID, GETDATE(), 1);

    PRINT '✅ Login successful.';
END;

DECLARE @UserID INT = 101;

UPDATE UserSessions
SET is_logged_in = 0
WHERE user_id = @UserID;

--Display top n customers on the basis of transaction type.
-- Replace @TopN with your desired number (e.g., 3)
--Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.

SELECT 
    customer_id,
    ISNULL([purchase], 0) AS total_purchase,
    ISNULL([withdrawal], 0) AS total_withdrawal,
    ISNULL([deposit], 0) AS total_deposit
FROM (
    SELECT 
        customer_id,
        txn_type,
        txn_amount
    FROM Transactions
) AS SourceTable
PIVOT (
    SUM(txn_amount)
    FOR txn_type IN ([purchase], [withdrawal], [deposit])
) AS PivotTable;
