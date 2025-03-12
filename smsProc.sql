-- 24th Feb

-- create proc login
CREATE PROC LoginByUser
	@username VARCHAR(100),
	@password VARCHAR(100)
AS
BEGIN
	SELECT * FROM Users WHERE(email = @username OR name = @username) AND password = @password;
END

-- create proc NewUser
CREATE PROC NewUser
    @email VARCHAR(100),
    @name VARCHAR(100),
    @password VARCHAR(100)
AS
BEGIN
    INSERT INTO Users(name, email, password, role)
    VALUES(@name, @email, @password, 'user');
END

-- change user Password
CREATE PROC ChangePassword
    @email VARCHAR(100),
    @newPassword VARCHAR(100)
AS
BEGIN
	UPDATE Users
    SET password = @newPassword
    WHERE (email = @email OR name = @email);
END

-- find user by email
CREATE PROC FindUsernameByEmail
	@email VARCHAR(100)
AS
BEGIN
	SELECT * FROM Users WHERE email = @email;
END
	
-- adding a bill and sending a notification
ALTER PROCEDURE AddBillAndNotify
    @flat_id INT,
    @bill_title VARCHAR(255),
    @amount DECIMAL(10,2),
    @month VARCHAR(30),
    @paid_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @bill_id INT, @user_id INT, @message VARCHAR(MAX);

    -- Insert the bill into the Bills table
    INSERT INTO Bills (flat_id, bill_title, amount, month, paid_date, paid_amount)
    VALUES (@flat_id, @bill_title, @amount, @month, @paid_date, NULL);

    -- Get the ID of the inserted bill
    SET @bill_id = SCOPE_IDENTITY();

    -- Get the user associated with the flat from the Allotments table
    SELECT @user_id = user_id FROM Allotments WHERE flat_id = @flat_id;

    -- Ensure @user_id is not NULL before inserting the notification
    IF @user_id IS NOT NULL
    BEGIN
        -- Create notification message for the user
        SET @message = 'New bill added for ' + @bill_title + ' in the month of ' + @month + '. Amount: ' + CAST(@amount AS VARCHAR);

        -- Insert notification for the user
        INSERT INTO Notifications (user_id, notification_type, event_id, message, link, read_status, created_at)
        VALUES (@user_id, 'Bill Added', @bill_id, @message, CONCAT('BillPaymentUser.aspx?billId=', @bill_id), 'unread', GETDATE());
    END
END;

-- get flat id 
ALTER PROC GetFlatId
	@flatNumber	VARCHAR(100),
	@block_number VARCHAR(100)
AS
BEGIN
	SELECT id, block_number FROM Flats WHERE flat_number = @flatNumber AND block_number = @block_number;
END

-- bind flat number & block number
ALTER PROC BindFlatNumber
AS
BEGIN
    SELECT block_number, flat_number FROM Flats;
END

-- Load Bill
CREATE PROC LoadBill
	@id int
AS
BEGIN
	SELECT bill_title, amount, month, paid_date, payment_method, paid_amount, created_at FROM Bills WHERE id = @id;
END

select * from Bills;
select * from Notifications;
select * from Users;
select * from Allotments;
select * from Flats;
select * from Complaints;
select * from Visitors; 

UPDATE Notifications 
SET link = 'BillPaymentUser.aspx?billId=1'
WHERE id = 1;	

UPDATE Notifications 
SET read_status = 'unread'
WHERE id = 1;	


UPDATE Bills 
SET paid_date = NULL
WHERE id  = 1;

Update Allotments
set flat_id = 7
where id = 5;