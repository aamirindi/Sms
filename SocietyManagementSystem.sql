--this is my database
CREATE DATABASE SocietyManagementSystem;
GO

USE SocietyManagementSystem;
GO

-- Users table
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) NOT NULL CHECK (role IN ('admin', 'user')),
    created_at DATETIME DEFAULT GETDATE()
);

-- Flats Table
CREATE TABLE Flats (
    id INT IDENTITY(1,1) PRIMARY KEY,
    flat_number VARCHAR(255) NOT NULL,
    floor INT NOT NULL,
    block_number VARCHAR(10) NOT NULL,
    flat_type VARCHAR(30) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

-- Allotments Table
CREATE TABLE Allotments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    flat_id INT NOT NULL,
    move_in_date DATE NOT NULL,
    move_out_date DATE NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (flat_id) REFERENCES Flats(id) ON DELETE CASCADE
);

-- Bills Table
CREATE TABLE Bills (
    id INT IDENTITY(1,1) PRIMARY KEY,
    flat_id INT NOT NULL,
    bill_title VARCHAR(255) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    month VARCHAR(30) NOT NULL,
    paid_date DATE NULL,
    payment_method VARCHAR(255) NULL,
    paid_amount DECIMAL(10,2) NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (flat_id) REFERENCES Flats(id) ON DELETE CASCADE
);

-- Complaints Table
CREATE TABLE Complaints (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    flat_id INT NOT NULL,
    description VARCHAR(MAX) NOT NULL,
    master_comment VARCHAR(MAX) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'in_progress', 'resolved')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (flat_id) REFERENCES Flats(id) ON DELETE CASCADE
);

-- Notifications Table
CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    event_id INT NOT NULL,
    message VARCHAR(MAX) NOT NULL,
    link VARCHAR(255) NULL,
    read_status VARCHAR(10) NOT NULL DEFAULT 'unread' CHECK (read_status IN ('unread', 'read')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Visitors Table
CREATE TABLE Visitors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    flat_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NULL,
    address VARCHAR(MAX) NULL,
    person_to_meet VARCHAR(255) NULL,
    reason VARCHAR(MAX) NULL,
    in_datetime DATETIME NULL,
    out_remark VARCHAR(MAX) NULL,
    out_datetime DATETIME NULL,
    is_in_out VARCHAR(5) NOT NULL CHECK (is_in_out IN ('in', 'out')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (flat_id) REFERENCES Flats(id) ON DELETE CASCADE
);

-- Audit Trail Table
CREATE TABLE AuditTrail (
    id INT IDENTITY(1,1) PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_by INT NOT NULL,
    action_date DATETIME DEFAULT GETDATE(),
    old_value NVARCHAR(MAX) NULL,
    new_value NVARCHAR(MAX) NULL,
    FOREIGN KEY (action_by) REFERENCES Users(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_flats_flat_number ON Flats(flat_number);
CREATE INDEX idx_allotments_user_id ON Allotments(user_id);
CREATE INDEX idx_allotments_flat_id ON Allotments(flat_id);
CREATE INDEX idx_bills_flat_id ON Bills(flat_id);
CREATE INDEX idx_complaints_user_id ON Complaints(user_id);
CREATE INDEX idx_complaints_flat_id ON Complaints(flat_id);
CREATE INDEX idx_notifications_user_id ON Notifications(user_id);
CREATE INDEX idx_visitors_flat_id ON Visitors(flat_id);

-- Insert into Users Table
INSERT INTO Users (name, email, password, role) VALUES
('Aamirindi', 'admin1@sms.com', '123', 'admin'),
('Surajsahu', 'admin2@sms.com', '123', 'admin'),
('User 1', 'user1@sms.com', '123', 'user'),
('User 2', 'user2@sms.com', '123', 'user'),
('User 3', 'user3@sms.com', '123', 'user'),
('User 4', 'user4@sms.com', '123', 'user'),
('User 5', 'user5@sms.com', '123', 'user'),
('User 6', 'user6@sms.com', '123', 'user'),
('User 7', 'user7@sms.com', '123', 'user'),
('User 8', 'user8@sms.com', '123', 'user'),
('User 9', 'user9@sms.com', '123', 'user'),
('User 10', 'user10@sms.com', '123', 'user');

-- Insert into Flats Table
INSERT INTO Flats (flat_number, floor, block_number, flat_type, created_at) VALUES
('101', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('102', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('103', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('104', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('105', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('106', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('201', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45'),
('202', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45'),
('203', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45'),
('204', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45'),
('205', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45'),
('206', 2, 'B', '2 BHK Flat', '2025-02-25 11:37:45');

-- Insert into Users Table
INSERT INTO Users (name, email, password, role) VALUES
('User 11', 'user11@sms.com', '123', 'user'),
('User 12', 'user12@sms.com', '123', 'user');

-- Insert into Allotments
INSERT INTO Allotments (user_id, flat_id, move_in_date) VALUES
(3, 1, '2025-03-01'),
(4, 2, '2025-03-02'),
(5, 3, '2025-03-03'),
(6, 4, '2025-03-04'),
(7, 5, '2025-03-05'),
(8, 6, '2025-03-06'),
(9, 7, '2025-03-07'),
(10, 8, '2025-03-08'),
(11, 9, '2025-03-09'),
(12, 10, '2025-03-10'),
(13, 11, '2025-03-11'),
(14, 12, '2025-03-12');

-- Insert into Bills
INSERT INTO Bills (flat_id, bill_title, amount, month, paid_date, payment_method, paid_amount) VALUES
(1, 'Electricity Bill for January 2025', 350.00, 'January 2025', '2025-03-10', 'Cash', 350.00),
(2, 'Water Bill for January 2025', 200.00, 'January 2025', '2025-03-11', 'Cash', 200.00),
(3, 'Maintenance Bill for January 2025', 500.00, 'January 2025', '2025-03-12', 'Cash', 500.00),
(4, 'Electricity Bill for February 2025', 370.00, 'February 2025', '2025-03-13', 'Cash', 370.00),
(5, 'Water Bill for February 2025', 220.00, 'February 2025', '2025-03-14', 'Cash', 220.00),
(6, 'Maintenance Bill for February 2025', 520.00, 'February 2025', '2025-03-15', 'Cash', 520.00),
(7, 'Electricity Bill for March 2025', 390.00, 'March 2025', '2025-03-16', 'Cash', 390.00),
(8, 'Water Bill for March 2025', 240.00, 'March 2025', '2025-03-17', 'Cash', 240.00),
(9, 'Maintenance Bill for March 2025', 540.00, 'March 2025', '2025-03-18', 'Cash', 540.00),
(10, 'Electricity Bill for April 2025', 410.00, 'April 2025', '2025-03-19', 'Cash', 410.00),
(11, 'Water Bill for April 2025', 260.00, 'April 2025', '2025-03-20', 'Cash', 260.00),
(12, 'Maintenance Bill for April 2025', 560.00, 'April 2025', '2025-03-21', 'Cash', 560.00);

-- Insert into Complaints
INSERT INTO Complaints (user_id, flat_id, description, master_comment, status) VALUES
(3, 1, 'Leakage in bathroom', 'Plumber visited and fixed the issue', 'resolved'),
(4, 2, 'No electricity', 'Electrician visited and fixed the issue', 'resolved'),
(5, 3, 'Water supply issue', 'Plumber visited and fixed the issue', 'resolved'),
(6, 4, 'Noise complaint', 'Security visited and resolved the issue', 'resolved'),
(7, 5, 'Parking issue', 'Security visited and resolved the issue', 'resolved'),
(8, 6, 'Lift not working', 'Technician visited and fixed the issue', 'resolved'),
(9, 7, 'Garbage not collected', 'Cleaning staff visited and resolved the issue', 'resolved'),
(10, 8, 'Internet issue', 'Technician visited and fixed the issue', 'resolved'),
(11, 9, 'AC not working', 'Technician visited and fixed the issue', 'resolved'),
(12, 10, 'Pest control needed', 'Pest control visited and resolved the issue', 'resolved'),
(13, 11, 'Drainage issue', 'Plumber visited and fixed the issue', 'resolved'),
(14, 12, 'Security concern', 'Security visited and resolved the issue', 'resolved');

-- Insert into Notifications
INSERT INTO Notifications (user_id, notification_type, event_id, message, link, read_status) VALUES
(3, 'Complaint', 1, 'Your complaint has been resolved', NULL, 'unread'),
(4, 'Complaint', 2, 'Your complaint has been resolved', NULL, 'unread'),
(5, 'Complaint', 3, 'Your complaint has been resolved', NULL, 'unread'),
(6, 'Complaint', 4, 'Your complaint has been resolved', NULL, 'unread'),
(7, 'Complaint', 5, 'Your complaint has been resolved', NULL, 'unread'),
(8, 'Complaint', 6, 'Your complaint has been resolved', NULL, 'unread'),
(9, 'Complaint', 7, 'Your complaint has been resolved', NULL, 'unread'),
(10, 'Complaint', 8, 'Your complaint has been resolved', NULL, 'unread'),
(11, 'Complaint', 9, 'Your complaint has been resolved', NULL, 'unread'),
(12, 'Complaint', 10, 'Your complaint has been resolved', NULL, 'unread'),
(13, 'Complaint', 11, 'Your complaint has been resolved', NULL, 'unread'),
(14, 'Complaint', 12, 'Your complaint has been resolved', NULL, 'unread');

-- Insert into Visitors
INSERT INTO Visitors (flat_id, name, phone, address, person_to_meet, reason, in_datetime, is_in_out) VALUES
(1, 'Visitor 1', '1234567890', 'Address 1', 'User 1', 'Friend visit', '2025-03-01 10:00:00', 'in'),
(2, 'Visitor 2', '2345678901', 'Address 2', 'User 2', 'Friend visit', '2025-03-02 11:00:00', 'in'),
(3, 'Visitor 3', '3456789012', 'Address 3', 'User 3', 'Friend visit', '2025-03-03 12:00:00', 'in'),
(4, 'Visitor 4', '4567890123', 'Address 4', 'User 4', 'Friend visit', '2025-03-04 13:00:00', 'in'),
(5, 'Visitor 5', '5678901234', 'Address 5', 'User 5', 'Friend visit', '2025-03-05 14:00:00', 'in'),
(6, 'Visitor 6', '6789012345', 'Address 6', 'User 6', 'Friend visit', '2025-03-06 15:00:00', 'in'),
(7, 'Visitor 7', '7890123456', 'Address 7', 'User 7', 'Friend visit', '2025-03-07 16:00:00', 'in'),
(8, 'Visitor 8', '8901234567', 'Address 8', 'User 8', 'Friend visit', '2025-03-08 17:00:00', 'in'),
(9, 'Visitor 9', '9012345678', 'Address 9', 'User 9', 'Friend visit', '2025-03-09 18:00:00', 'in'),
(10, 'Visitor 10', '0123456789', 'Address 10', 'User 10', 'Friend visit', '2025-03-10 19:00:00', 'in'),
(11, 'Visitor 11', '1230987654', 'Address 11', 'User 11', 'Friend visit', '2025-03-11 20:00:00', 'in'),
(12, 'Visitor 12', '2341234567', 'Address 12', 'User 12', 'Friend visit', '2025-03-12 21:00:00', 'in');

--query to check all the tables
--To check all the tables in your database, you can use the following SQL query:
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='SocietyManagementSystem';

--If you want to see the structure of each table, you can use the following query to get the column details for each table:
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = 'SocietyManagementSystem'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

--If you want to check the data in each table, you can run this queries:
SELECT * FROM Users;
SELECT * FROM Flats;
SELECT * FROM Allotments;
SELECT * FROM Bills;
SELECT * FROM Complaints;
SELECT * FROM Notifications;
SELECT * FROM Visitors;
SELECT * FROM AuditTrail;


--STORED PROCEDURES


-- Stored Procedure to Add a New User
CREATE PROCEDURE NewUser
    @email VARCHAR(100),
    @name VARCHAR(100),
    @password VARCHAR(100),
    @role VARCHAR(10) = 'user',
    @action_by INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Users (name, email, password, role)
        VALUES (@name, @email, @password, @role);

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Users', 'INSERT', @action_by, NULL, CONCAT('Name: ', @name, ', Email: ', @email, ', Role: ', @role));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Login User
CREATE PROCEDURE LoginByUser
    @username VARCHAR(100),
    @password VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Users WHERE (email = @username OR name = @username) AND password = @password;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Change User Password
CREATE PROCEDURE ChangePassword
    @email VARCHAR(100),
    @newPassword VARCHAR(100),
    @action_by INT
AS
BEGIN
    BEGIN TRY
        UPDATE Users
        SET password = @newPassword
        WHERE email = @email;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Users', 'UPDATE', @action_by, CONCAT('Email: ', @email), CONCAT('New Password: ', @newPassword));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Find User by Email
CREATE PROCEDURE FindUsernameByEmail
    @email VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Users WHERE email = @email;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Add an Allotment
CREATE PROCEDURE AddAllotment
    @user_id INT,
    @flat_id INT,
    @move_in_date DATE,
    @move_out_date DATE = NULL,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Allotments (user_id, flat_id, move_in_date, move_out_date, created_at)
        VALUES (@user_id, @flat_id, @move_in_date, @move_out_date, GETDATE());

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Allotments', 'INSERT', @action_by, NULL, CONCAT('User ID: ', @user_id, ', Flat ID: ', @flat_id, ', Move In Date: ', @move_in_date, ', Move Out Date: ', @move_out_date));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch All Allotments
CREATE PROCEDURE GetAllAllotments
    @searchTerm NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        SELECT
            a.id,
            u.name AS AllotedTo,
            f.flat_number,
            f.block_number,
            f.flat_type,
            a.move_in_date,
            a.move_out_date,
            a.created_at
        FROM
            Allotments a
        JOIN
            Users u ON a.user_id = u.id
        JOIN
            Flats f ON a.flat_id = f.id
        WHERE
            (@searchTerm IS NULL OR u.name LIKE '%' + @searchTerm + '%')
        ORDER BY
            u.name ASC;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Delete an Allotment
CREATE PROCEDURE DeleteAllotment
    @allotment_id INT,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Allotments WHERE id = @allotment_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Allotments', 'DELETE', @action_by, CONCAT('Allotment ID: ', @allotment_id), NULL);
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Update an Allotment
CREATE PROCEDURE UpdateAllotment
    @allotment_id INT,
    @user_id INT,
    @flat_id INT,
    @move_in_date DATE,
    @move_out_date DATE = NULL,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        UPDATE Allotments
        SET user_id = @user_id,
            flat_id = @flat_id,
            move_in_date = @move_in_date,
            move_out_date = @move_out_date
        WHERE id = @allotment_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Allotments', 'UPDATE', @action_by, CONCAT('Allotment ID: ', @allotment_id), CONCAT('User ID: ', @user_id, ', Flat ID: ', @flat_id, ', Move In Date: ', @move_in_date, ', Move Out Date: ', @move_out_date));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Add a Complaint
CREATE PROCEDURE AddComplaint
    @user_id INT,
    @flat_id INT,
    @description NVARCHAR(MAX),
    @status NVARCHAR(50),
    @created_at DATETIME,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Complaints (user_id, flat_id, description, status, created_at)
        VALUES (@user_id, @flat_id, @description, @status, @created_at);

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Complaints', 'INSERT', @action_by, NULL, CONCAT('User ID: ', @user_id, ', Flat ID: ', @flat_id, ', Description: ', @description, ', Status: ', @status));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch All Complaints
CREATE PROCEDURE GetComplaints
AS
BEGIN
    BEGIN TRY
        SELECT c.id, u.name AS UserName, f.flat_number AS FlatNumber, c.description, c.status, c.created_at
        FROM Complaints c
        JOIN Users u ON c.user_id = u.id
        JOIN Flats f ON c.flat_id = f.id;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch a Complaint by ID
CREATE PROCEDURE GetComplaintById
    @complaint_id INT
AS
BEGIN
    BEGIN TRY
        SELECT
            c.id,
            u.name AS UserName,
            f.flat_number,
            f.block_number,
            c.description,
            c.status,
            c.created_at,
            c.master_comment
        FROM
            Complaints c
        JOIN
            Users u ON c.user_id = u.id
        JOIN
            Flats f ON c.flat_id = f.id
        WHERE
            c.id = @complaint_id;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Update a Complaint
CREATE PROCEDURE UpdateComplaint
    @complaint_id INT,
    @description NVARCHAR(MAX),
    @status NVARCHAR(50),
    @action_by INT
AS
BEGIN
    BEGIN TRY
        UPDATE Complaints
        SET description = @description,
            status = @status
        WHERE id = @complaint_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Complaints', 'UPDATE', @action_by, CONCAT('Complaint ID: ', @complaint_id), CONCAT('Description: ', @description, ', Status: ', @status));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Delete a Complaint
CREATE PROCEDURE DeleteComplaint
    @complaint_id INT,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Complaints WHERE id = @complaint_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Complaints', 'DELETE', @action_by, CONCAT('Complaint ID: ', @complaint_id), NULL);
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Add a Visitor
CREATE PROCEDURE AddVisitor
    @flat_id INT,
    @name NVARCHAR(255),
    @phone NVARCHAR(20),
    @address NVARCHAR(MAX),
    @person_to_meet NVARCHAR(255),
    @reason NVARCHAR(MAX),
    @in_datetime DATETIME,
    @is_in_out NVARCHAR(5),
    @action_by INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Visitors (flat_id, name, phone, address, person_to_meet, reason, in_datetime, is_in_out)
        VALUES (@flat_id, @name, @phone, @address, @person_to_meet, @reason, @in_datetime, @is_in_out);

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Visitors', 'INSERT', @action_by, NULL, CONCAT('Flat ID: ', @flat_id, ', Name: ', @name, ', Phone: ', @phone, ', Address: ', @address, ', Person to Meet: ', @person_to_meet, ', Reason: ', @reason, ', In DateTime: ', @in_datetime, ', Is In Out: ', @is_in_out));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch All Visitors
CREATE PROCEDURE GetVisitors
AS
BEGIN
    BEGIN TRY
        SELECT v.id, f.flat_number, f.block_number, v.name, v.phone, v.person_to_meet, v.in_datetime, v.out_datetime, v.is_in_out, v.out_remark, v.address, v.reason
        FROM Visitors v
        JOIN Flats f ON v.flat_id = f.id;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch a Visitor by ID
CREATE PROCEDURE GetVisitorById
    @visitor_id INT
AS
BEGIN
    BEGIN TRY
        SELECT v.id, f.flat_number, f.block_number, v.name, v.phone, v.person_to_meet, v.in_datetime, v.out_datetime, v.is_in_out, v.out_remark, v.address, v.reason
        FROM Visitors v
        JOIN Flats f ON v.flat_id = f.id
        WHERE v.id = @visitor_id;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Update a Visitor
CREATE PROCEDURE UpdateVisitor
    @visitor_id INT,
    @flat_id INT,
    @name NVARCHAR(255),
    @phone NVARCHAR(20),
    @address NVARCHAR(MAX),
    @person_to_meet NVARCHAR(255),
    @reason NVARCHAR(MAX),
    @in_datetime DATETIME,
    @is_in_out NVARCHAR(5),
    @out_remark NVARCHAR(MAX),
    @out_datetime DATETIME,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        UPDATE Visitors
        SET flat_id = @flat_id,
            name = @name,
            phone = @phone,
            address = @address,
            person_to_meet = @person_to_meet,
            reason = @reason,
            in_datetime = @in_datetime,
            is_in_out = @is_in_out,
            out_remark = @out_remark,
            out_datetime = @out_datetime
        WHERE id = @visitor_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Visitors', 'UPDATE', @action_by, CONCAT('Visitor ID: ', @visitor_id), CONCAT('Flat ID: ', @flat_id, ', Name: ', @name, ', Phone: ', @phone, ', Address: ', @address, ', Person to Meet: ', @person_to_meet, ', Reason: ', @reason, ', In DateTime: ', @in_datetime, ', Is In Out: ', @is_in_out, ', Out Remark: ', @out_remark, ', Out DateTime: ', @out_datetime));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Delete a Visitor
CREATE PROCEDURE DeleteVisitor
    @visitor_id INT,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Visitors WHERE id = @visitor_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Visitors', 'DELETE', @action_by, CONCAT('Visitor ID: ', @visitor_id), NULL);
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Get Bill Report
CREATE PROCEDURE GetBillReport
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    BEGIN TRY
        SELECT b.id, f.flat_number, f.block_number, b.bill_title, b.amount, b.month, b.paid_date, b.payment_method, b.paid_amount
        FROM Bills b
        JOIN Flats f ON b.flat_id = f.id
        WHERE b.created_at BETWEEN @start_date AND @end_date;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Get Complaint Report
CREATE PROCEDURE GetComplaintReport
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    BEGIN TRY
        SELECT c.id, u.name AS UserName, f.flat_number, f.block_number, c.description, c.status, c.created_at
        FROM Complaints c
        JOIN Users u ON c.user_id = u.id
        JOIN Flats f ON c.flat_id = f.id
        WHERE c.created_at BETWEEN @start_date AND @end_date;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Get Visitor Report
CREATE PROCEDURE GetVisitorReport
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    BEGIN TRY
        SELECT v.id, f.flat_number, f.block_number, v.name, v.phone, v.address, v.person_to_meet, v.reason, v.in_datetime, v.out_remark, v.out_datetime, v.is_in_out
        FROM Visitors v
        JOIN Flats f ON v.flat_id = f.id
        WHERE v.created_at BETWEEN @start_date AND @end_date;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch Users for Dropdown
CREATE PROCEDURE GetUsersForDropdown
AS
BEGIN
    BEGIN TRY
        SELECT id, name FROM Users ORDER BY name ASC;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-- Stored Procedure to Fetch Flats for Dropdown
CREATE PROCEDURE GetFlatsForDropdown
AS
BEGIN
    BEGIN TRY
        SELECT id, flat_number, block_number FROM Flats ORDER BY id DESC;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

--Query to check all Stored Procedure
SELECT * 
  FROM SocietyManagementSystem.INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE'


 --If you want to check the data in each table, you can run this queries:
SELECT * FROM Users;
SELECT * FROM Flats;
SELECT * FROM Allotments;
SELECT * FROM Bills;
SELECT * FROM Complaints;
SELECT * FROM Notifications;
SELECT * FROM Visitors;
SELECT * FROM AuditTrail;


--If you want to reset the auto-increment value, you can use the following SQL command: 
--This will reset the IDENTITY seed to 0, and the next inserted row will start from 1
DBCC CHECKIDENT ('Allotments', RESEED, 0);



--David stored procedures
-- Stored Procedure to List Users for Management
CREATE PROCEDURE UserManagementList
AS
BEGIN
    SELECT id, name, email, role, created_at
    FROM Users
    ORDER BY created_at DESC;
END;

-- Stored Procedure to Delete a User
CREATE PROCEDURE UserDelete
    @id INT
AS
BEGIN
    DELETE FROM Users WHERE id = @id;
END;

-- Stored Procedure to Fetch User Data for Editing
CREATE PROCEDURE EditDataFetch
    @id INT
AS
BEGIN
    SELECT name, email FROM Users WHERE id = @id;
END;

-- Stored Procedure to Update User Information
CREATE PROCEDURE UserUpdate
    @id INT,
    @name VARCHAR(255),
    @email VARCHAR(255),
    @password VARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET name = @name, email = @email, password = @password
    WHERE id = @id;
END;

-- Stored Procedure to Add a New User
ALTER PROCEDURE NewUser
    @name VARCHAR(100),
    @email VARCHAR(100),
    @password VARCHAR(100)
AS
BEGIN
    INSERT INTO Users (name, email, password, role)
    VALUES (@name, @email, @password, 'user');
END;

-- Stored Procedure to Fetch Profile Data for Editing
CREATE PROCEDURE EditProfileFetchData
    @email VARCHAR(100)
AS
BEGIN
    SELECT name, email FROM Users WHERE email = @email;
END;

-- Stored Procedure to Save Edited Profile Data
CREATE PROCEDURE EditProfileSaveData
    @emailByID VARCHAR(255),
    @name VARCHAR(255),
    @email VARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET name = @name, email = @email
    WHERE email = @emailByID;
END;

---- Stored Procedure to Fetch Profile Data for Editing
--CREATE PROCEDURE EditProfileFetchData
--    @email VARCHAR(100)
--AS
--BEGIN
--    SELECT name, email FROM Users WHERE email = @email;
--END;

---- Stored Procedure to Save Edited Profile Data
--ALTER PROCEDURE EditProfileSaveData
--    @emailByID VARCHAR(255),
--    @name VARCHAR(255),
--    @email VARCHAR(255)
--AS
--BEGIN
--    UPDATE Users
--    SET name = @name, email = @email
--    WHERE email = @emailByID;
--END;

-- Stored Procedure to Search Users by Name
CREATE PROCEDURE SearchByname
    @name VARCHAR(255)
AS
BEGIN
    SELECT id, name, email, role, created_at
    FROM Users
    WHERE name LIKE '%' + @name + '%';
END;



--Table for Meetings
CREATE TABLE Meetings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(MAX) NULL,
    meeting_date DATE NOT NULL,
    meeting_time TIME NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (created_by) REFERENCES Users(id) ON DELETE CASCADE
);

--Procedure for Adding Meeting
CREATE PROCEDURE AddMeeting
    @title VARCHAR(255),
    @description VARCHAR(MAX),
    @meeting_date DATE,
    @meeting_time TIME,
    @created_by INT
AS
BEGIN
    BEGIN TRY
        -- Insert the new meeting
        INSERT INTO Meetings (title, description, meeting_date, meeting_time, created_by)
        VALUES (@title, @description, @meeting_date, @meeting_time, @created_by);

        -- Get the ID of the newly created meeting
        DECLARE @meeting_id INT = SCOPE_IDENTITY();

        -- Send notifications to all users
        INSERT INTO Notifications (user_id, notification_type, event_id, message, link, read_status)
        SELECT id, 'Meeting', @meeting_id, 
               CONCAT('New Meeting: ', @title, ' on ', @meeting_date, ' at ', @meeting_time),
               NULL, 'unread'
        FROM Users
        WHERE role = 'user';

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Meetings', 'INSERT', @created_by, NULL, 
                CONCAT('Title: ', @title, ', Description: ', @description, ', Date: ', @meeting_date, ', Time: ', @meeting_time));
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

--Create a Stored Procedure to Fetch Meetings
CREATE PROCEDURE GetMeetings
AS
BEGIN
    BEGIN TRY
        SELECT 
            m.id, 
            m.title, 
            m.description, 
            m.meeting_date, 
            m.meeting_time, 
            u.name AS created_by_name,
            m.created_at
        FROM Meetings m
        JOIN Users u ON m.created_by = u.id
        ORDER BY m.meeting_date DESC, m.meeting_time DESC;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

--Create a Stored Procedure to Delete a Meeting
CREATE PROCEDURE DeleteMeeting
    @meeting_id INT,
    @action_by INT
AS
BEGIN
    BEGIN TRY
        -- Delete the meeting
        DELETE FROM Meetings WHERE id = @meeting_id;

        -- Audit Trail
        INSERT INTO AuditTrail (table_name, action_type, action_by, old_value, new_value)
        VALUES ('Meetings', 'DELETE', @action_by, CONCAT('Meeting ID: ', @meeting_id), NULL);
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

--Create a Stored Procedure to Fetch Meetings for Notifications
CREATE PROCEDURE GetMeetingsForNotifications
    @user_id INT
AS
BEGIN
    BEGIN TRY
        SELECT 
            n.id AS notification_id,
            m.title,
            m.description,
            m.meeting_date,
            m.meeting_time,
            n.read_status
        FROM Notifications n
        JOIN Meetings m ON n.event_id = m.id
        WHERE n.user_id = @user_id AND n.notification_type = 'Meeting'
        ORDER BY m.meeting_date DESC, m.meeting_time DESC;
    END TRY
    BEGIN CATCH
        -- Return error details
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

--Example Queries for Testing
EXEC AddMeeting 
     @title = 'Monthly Society Meeting',
     @description = 'Discussing maintenance and security issues.',
     @meeting_date = '2025-04-15',
     @meeting_time = '10:00:00',
     @created_by = 1;

--Fetch All Meetings
EXEC GetMeetings;

--Delete a Meeting
EXEC DeleteMeeting @meeting_id = 1, @action_by = 1;

--Fetch Meetings for Notifications
EXEC GetMeetingsForNotifications @user_id = 3;


--Aishwaryas stored procedure
--Add a New Flat
CREATE PROCEDURE sp_AddFlat
    @FlatNumber VARCHAR(255),
    @Floor INT,
    @BlockNumber VARCHAR(10),
    @FlatType VARCHAR(30)
AS
BEGIN
    INSERT INTO Flats (flat_number, floor, block_number, flat_type, created_at)
    VALUES (@FlatNumber, @Floor, @BlockNumber, @FlatType, GETDATE());
END;

--Update an Existing Flat
CREATE PROCEDURE sp_UpdateFlat
    @ID INT,
    @FlatNumber VARCHAR(255),
    @Floor INT,
    @BlockNumber VARCHAR(10),
    @FlatType VARCHAR(30)
AS
BEGIN
    UPDATE Flats
    SET
        flat_number = @FlatNumber,
        floor = @Floor,
        block_number = @BlockNumber,
        flat_type = @FlatType
    WHERE id = @ID;
END;

--Get Flat Details by ID
CREATE PROCEDURE GetFlatDetails
    @id INT
AS
BEGIN
    SELECT id, flat_number, floor, block_number, flat_type
    FROM Flats
    WHERE id = @id;
END;

--Get All Flats
CREATE PROCEDURE sp_GetAllFlats
AS
BEGIN
    SELECT * FROM Flats;
END;


--Delete a Flat
CREATE PROCEDURE sp_DeleteFlats
    @id INT
AS
BEGIN
    DELETE FROM Flats WHERE id = @id;
END;

--Get Flat ID by User ID
CREATE PROCEDURE GetFlatIdByUserId
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT flat_id FROM Allotments WHERE user_id = @user_id;
END;

-- Add Complaint and Notify Admin
	CREATE PROCEDURE AddComplaintAndNotify
		@user_id INT,
		@description VARCHAR(MAX),
		@status VARCHAR(20) = 'pending'
	AS
	BEGIN
		SET NOCOUNT ON;
		DECLARE @complaint_id INT, @admin_id INT, @message VARCHAR(MAX), @flat_id INT;
		SELECT @flat_id = flat_id FROM Allotments WHERE user_id = @user_id;
		IF @flat_id IS NULL
		BEGIN
			RAISERROR ('Flat ID not found for this user.', 16, 1);
			RETURN;
		END
		INSERT INTO Complaints (user_id, flat_id, description, master_comment, status, created_at)
		VALUES (@user_id, @flat_id, @description, '', @status, GETDATE());
		SET @complaint_id = SCOPE_IDENTITY();
		IF @complaint_id IS NULL
		BEGIN
			RAISERROR ('Complaint could not be inserted.', 16, 1);
			RETURN;
		END
		SELECT TOP 1 @admin_id = id FROM Users WHERE role = 'admin';
		IF @admin_id IS NULL
		BEGIN
			RAISERROR ('Admin not found.', 16, 1);
			RETURN;
		END
		SET @message = 'New complaint received from user ID ' + CAST(@user_id AS VARCHAR(10));
		INSERT INTO Notifications (user_id, notification_type, event_id, message, link, read_status, created_at)
		VALUES (@admin_id, 'New Complaint', @complaint_id, @message, '/admin/complaints', 'unread', GETDATE());
	END;

	--Get Complaints by User ID
	CREATE PROCEDURE GetComplaintsByUserId
		@user_id INT
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT
			c.id,
			u.name AS UserName,
			c.flat_id AS FlatNumber,
			c.description AS Description,
			c.status AS Status,
			c.created_at AS CreatedAt
		FROM
			Complaints c
		INNER JOIN
			Users u ON c.user_id = u.id
		WHERE
			c.user_id = @user_id;
	END;

	--Notify User on Complaint Status Update
	CREATE PROCEDURE NotifyUserOnStatusUpdate
		@user_id INT,
		@complaint_id INT,
		@status VARCHAR(20)
	AS
	BEGIN
		SET NOCOUNT ON;
		DECLARE @message VARCHAR(MAX);
		SET @message = 'Your complaint (ID: ' + CAST(@complaint_id AS VARCHAR(10)) + ') has been updated to ' + @status;
		INSERT INTO Notifications (user_id, notification_type, event_id, message, link, read_status, created_at)
		VALUES (@user_id, 'Complaint Status Update', @complaint_id, @message, '/user/complaints', 'unread', GETDATE());
	END;

	--Get User Complaints
	CREATE PROCEDURE GetUserComplaints
		@user_id INT
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT
			c.id,
			u.name AS UserName,
			f.flat_number AS FlatNumber,
			c.description,
			c.master_comment,
			c.status,
			c.created_at
		FROM Complaints c
		JOIN Users u ON c.user_id = u.id
		JOIN Flats f ON c.flat_id = f.id
		WHERE c.user_id = @user_id;
	END;

--Get User Complaints
CREATE PROCEDURE GetUserComplaints
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        c.id,
        u.name AS UserName,
        f.flat_number AS FlatNumber,
        c.description,
        c.master_comment,
        c.status,
        c.created_at AS CreatedAt  -- Add alias here
    FROM Complaints c
    JOIN Users u ON c.user_id = u.id
    JOIN Flats f ON c.flat_id = f.id
    WHERE c.user_id = @user_id;
END;

--Aamir Stored Procedure
--Fetching Bill Amount
CREATE PROCEDURE FetchingAmount
    @billId INT
AS
BEGIN
    SELECT amount
    FROM Bills
    WHERE id = @billId;
END;

--Updating Bill Payment
CREATE PROCEDURE UpdatingBillPayment
    @paymentDate DATE,
    @paidAmount DECIMAL(10, 2),
    @paymentMethod VARCHAR(255),
    @billId INT
AS
BEGIN
    UPDATE Bills
    SET paid_date = @paymentDate,
        paid_amount = @paidAmount,
        payment_method = @paymentMethod
    WHERE id = @billId;
END;

--Updating Notification Link After Payment
CREATE PROCEDURE UpdatingNotiAfterPayment
    @billId INT
AS
BEGIN
    UPDATE Notifications
    SET link = NULL
    WHERE event_id = @billId;
END;

--Get User Bills
CREATE PROCEDURE GetUserBills
    @UserId INT,
    @Month VARCHAR(30) = NULL,
    @PaymentStatus VARCHAR(20) = NULL
AS
BEGIN
    SELECT b.id, b.bill_title, b.amount, b.month, b.paid_date,
           b.payment_method,
           COALESCE(CAST(b.paid_amount AS VARCHAR), 'Not Paid') AS paid_amount,
           b.created_at
    FROM Bills b
    INNER JOIN Allotments a ON b.flat_id = a.flat_id
    WHERE a.user_id = @UserId
    AND (@Month IS NULL OR b.month = @Month)
    AND (@PaymentStatus IS NULL OR
         (@PaymentStatus = 'Paid' AND b.paid_amount IS NOT NULL) OR
         (@PaymentStatus = 'Not Paid' AND b.paid_amount IS NULL));
END;

--Get Bill Details
CREATE PROCEDURE GetBillDetails
    @billId INT
AS
BEGIN
    SELECT b.bill_title, b.amount, b.month, b.paid_date,
           b.payment_method, b.paid_amount, b.created_at
    FROM Bills b
    WHERE b.id = @billId;
END;

--Get Bill Details For User
CREATE PROCEDURE GetBillDetailsForUser
    @billId INT,
    @userId INT
AS
BEGIN
    SELECT f.flat_number + ', ' + f.block_number AS flat_details,
           b.bill_title, b.amount, b.month
    FROM Bills b
    JOIN Allotments a ON b.flat_id = a.flat_id
    JOIN Flats f ON a.flat_id = f.id
    WHERE b.id = @billId AND a.user_id = @userId;
END;

--Get Bill Amount
CREATE PROCEDURE GetBillAmount
    @billId INT
AS
BEGIN
    SELECT amount
    FROM Bills
    WHERE id = @billId;
END;


--Update Bill Payment
CREATE PROCEDURE UpdateBillPayment
    @billId INT,
    @paymentDate DATE,
    @paidAmount DECIMAL(10, 2),
    @paymentMethod VARCHAR(255)
AS
BEGIN
    UPDATE Bills
    SET paid_date = @paymentDate,
        paid_amount = @paidAmount,
        payment_method = @paymentMethod
    WHERE id = @billId;
END;

--Update Notification Link After Payment
CREATE PROCEDURE UpdateNotificationLinkAfterPayment
    @billId INT
AS
BEGIN
    UPDATE Notifications
    SET link = NULL
    WHERE event_id = @billId;
END;

--Get All User Bills
CREATE PROCEDURE GetAllUserBills
AS
BEGIN
    SELECT u.name AS Name, b.id, b.bill_title, b.amount, b.month, b.paid_date,
           b.payment_method, b.paid_amount, b.created_at
    FROM Bills b
    JOIN Allotments a ON b.flat_id = a.flat_id
    JOIN Users u ON a.user_id = u.id;
END;

--Load Bill
CREATE PROCEDURE LoadBill
    @billId INT
AS
BEGIN
    SELECT bill_title, amount, month, paid_date, payment_method, paid_amount, created_at
    FROM Bills
    WHERE id = @billId;
END;

--Get Bill By Id
CREATE PROCEDURE GetBillById
    @billId INT
AS
BEGIN
    SELECT bill_title, amount, month, paid_date, payment_method, paid_amount, created_at
    FROM Bills
    WHERE id = @billId;
END;

--Update Bill Edit Admin
CREATE PROCEDURE UpdateBillEditAdmin
    @billId INT,
    @billTitle VARCHAR(255),
    @billAmount DECIMAL(10, 2),
    @billMonth VARCHAR(30),
    @billPaidDate DATE,
    @billPaymentMethod VARCHAR(255),
    @billPaidAmount DECIMAL(10, 2)
AS
BEGIN
    UPDATE Bills
    SET bill_title = @billTitle,
        amount = @billAmount,
        month = @billMonth,
        paid_date = @billPaidDate,
        payment_method = @billPaymentMethod,
        paid_amount = @billPaidAmount
    WHERE id = @billId;
END;

--Delete Bill
CREATE PROCEDURE DeleteBill
    @billId INT
AS
BEGIN
    DELETE FROM Bills
    WHERE id = @billId;
END;

--Add Bill
CREATE PROCEDURE AddBill
    @flatId INT,
    @billTitle VARCHAR(255),
    @amount DECIMAL(10, 2),
    @month VARCHAR(30)
AS
BEGIN
    INSERT INTO Bills (flat_id, bill_title, amount, month, created_at)
    VALUES (@flatId, @billTitle, @amount, @month, GETDATE());
END;


-- Stored Procedure to Get Total Count
CREATE PROCEDURE GetTotalCount
    @tableName NVARCHAR(128)
AS
BEGIN
    DECLARE @query NVARCHAR(MAX);
    SET @query = 'SELECT COUNT(*) FROM ' + @tableName;
    EXEC sp_executesql @query;
END;

-- Stored Procedure to Get Complaint Count
CREATE PROCEDURE GetComplaintCount
    @status NVARCHAR(50),
    @flatId INT = NULL
AS
BEGIN
    IF @flatId IS NULL
    BEGIN
        SELECT COUNT(*) FROM complaints WHERE status = @status;
    END
    ELSE
    BEGIN
        SELECT COUNT(*) FROM complaints WHERE status = @status AND flat_id = @flatId;
    END
END;

-- Stored Procedure to Get Flat ID for User
CREATE PROCEDURE GetFlatIdForUser
    @userId INT
AS
BEGIN
    SELECT flat_id FROM allotments WHERE user_id = @userId;
END;

-- Stored Procedure to Get Total Complaint Count for User
CREATE PROCEDURE GetTotalComplaintCountForUser
    @flatId INT
AS
BEGIN
    SELECT COUNT(*) FROM complaints WHERE flat_id = @flatId;
END;

-- Stored Procedure to Get Total Bills for User
CREATE PROCEDURE GetTotalBillsForUser
    @flatId INT
AS
BEGIN
    SELECT COUNT(*) FROM bills WHERE flat_id = @flatId;
END;

-- Stored Procedure to Get Total Visitors for User
CREATE PROCEDURE GetTotalVisitorsForUser
    @flatId INT
AS
BEGIN
    SELECT COUNT(*) FROM visitors WHERE flat_id = @flatId;
END;

-- Invoice
-- 
create proc FetchBillById
	@billId int
as
begin
	SELECT * FROM Bills WHERE id = @billId;
end


Update Users
set email = 'aamirindi001@gmail.com'
where id = 14;

-- AdminDashBoard.aspx
-- Pie Chart Data
CREATE PROCEDURE GetMoveInDatesByMonth
AS
BEGIN
    SELECT 
        FORMAT(move_in_date, 'MMMM yyyy') AS MonthYear,
        COUNT(*) AS Count
    FROM 
        Allotments
    WHERE 
        move_in_date IS NOT NULL
    GROUP BY 
        FORMAT(move_in_date, 'MMMM yyyy')
    ORDER BY 
        MIN(move_in_date)
END

-- 
Create proc GetPaidDataPieChart
as
begin
	SELECT 
	CASE 
	WHEN payment_method IS NULL THEN 'Not Paid'
	ELSE 'Paid'
	END AS payment_status,
	COUNT(*) AS bill_count
	FROM Bills
	GROUP BY 
	CASE 
	WHEN payment_method IS NULL THEN 'Not Paid'
	ELSE 'Paid'
	END
End

select * from Bills;
Select * from Users;
select * from Flats;
select * from Allotments;
