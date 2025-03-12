create database sms;

-- Users table
create table Users(
	id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
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
    FOREIGN KEY (user_id) REFERENCES [Users](id) ON DELETE CASCADE,
    FOREIGN KEY (flat_id) REFERENCES [Flats](id) ON DELETE CASCADE
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
    status VARCHAR(20) NOT NULL CHECK ([status] IN ('pending', 'in_progress', 'resolved')),
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

-- Insert into Users Table
INSERT INTO Users (name, email, password, role) VALUES
-- ('aamirindi', 'admin@sms.com', '123', 'admin'),
-- ('Peter Parker', 'peterparker@sms.com', '123', 'user'),
('Roshan Parker', 'roshanparker@sms.com', '123', 'user'),
('Suraj K', 'surajk@sms.com', '123', 'user'),
('Vivek S', 'viveks@sms.com', '123', 'user');

-- Insert into Flats Table
INSERT INTO Flats (flat_number, floor, block_number, flat_type, created_at) VALUES
('101', 1, 'A', '1 BHK Flat', '2025-02-25 11:37:45'),
('102', 1, 'A', '1 BHK Flat', '2025-03-25 12:48:39'),
('103', 1, 'A', '1 BHK Flat', '2025-03-25 12:48:55'),
('101', 1, 'B', '2 BHK Flat', '2025-03-06 12:51:59'),
('102', 1, 'B', '2 BHK Flat', '2025-03-06 12:52:12'),
('201', 2, 'B', '2 BHK Flat', '2025-03-06 12:52:25'),
('202', 2, 'B', '2 BHK Flat', '2025-03-06 12:52:38');

-- Insert into Allotments
INSERT INTO Allotments (user_id, flat_id, move_in_date) VALUES
( 3, 1, '2025-03-18'),
( 5, 2, '2025-03-20'),
( 4, 3, '2025-03-30');

-- Insert into Bills
INSERT INTO Bills (flat_id, bill_title, amount, month, paid_date, payment_method, paid_amount) VALUES
(1, 'Electricity Bill for January 2025', 350.00, '2025-03', '2025-03-10', 'Cash', 350.00);


-- Insert into Complaints
INSERT INTO Complaints (user_id, flat_id, description, master_comment, status) VALUES
(3, 1, 'Testing Complaints with edit process', '[{"datetime":"2023-02-27 11:04:20","details":"Testing Master in process comment"}]', 'resolved');



-- Select table
select * from Users;
select * from Flats;
select * from Allotments;
select * from Bills;
select * from Complaints;
select * from Visitors;	
select * from Notifications;