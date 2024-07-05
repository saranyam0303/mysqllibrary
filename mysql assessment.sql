                                     #Topic : Library Management System
#Create a database named library and following TABLES in the database: 

#1. Branch       [• Branch_no Set as PRIMARY KEY ,• Manager_Id ,• Branch_address ,• Contact_no ]
#2. Employee     [• Emp_Id – Set as PRIMARY KEY,• Emp_name ,• Position ,• Salary,
                    #• Branch_no Set as FOREIGN KEY and it refer Branch_no in Branch table]
#3. Books        [• ISBN Set as PRIMARY KEY,• Book_title,• Category,• Rental_Price,
                     #• Status [Give yes if book available and no if book not available],• Author,• Publisher]
#4. Customer     [• Customer_Id Set as PRIMARY KEY,• Customer_name,• Customer_address,• Reg_date]
#5. IssueStatus  [• Issue_Id Set as PRIMARY KEY ,• Issued_cust – Set as FOREIGN KEY and it refer customer_id in CUSTOMER table
                    #  • Issue_date,• Isbn_book – Set as FOREIGN KEY and it should refer isbn in BOOKS table ]
#6. ReturnStatus [• Return_Id Set as PRIMARY KEY,• Return_cust,• Return_book_name,• Return_date,
                     #• Isbn_book2 Set as FOREIGN KEY and it should refer isbn in BOOKS table ]

CREATE DATABASE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'South Block 1st Floor', '9994567890'),
    (2, 102, 'Main Block', '9876543210'),
    (3, 103, '2nd Floor Main block', '9123456711'),
    (4,104,'4th floor north CS','9876548745'),
    (5,105,'3rd floor north EC','9087767654');
    
SELECT * FROM Branch;
    
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)VALUES
    (201, 'Anil Akhil', 'HOD', 55000, 1),
    (202, 'Binu Thomas', 'Professor', 60000, 2),
    (203, 'Johnson Joy', 'Asst.Professor',40000, 2),
    (204, 'Savatri sam', 'Manager', 40000, 2),
    (205,'James Joy','Asst.Professor',52000,2),
    (206,'Gayatri','Professor',60000,2),
    (207,'Ganga R','Professor',60000,2);
    
SELECT * FROM Employee;
    
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
    
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)VALUES
	('93-684-843-5', 'Romeo and Juliet', 'Literature', 13, 'yes', 'William Shakespeare', 'ABC Publishing'),
    ('0-8694-84-A', 'Time Machine', 'Literature', 26, 'yes', 'H.G Wells', 'j&j Publishing'),
    ('0-684-84328-5', 'Introduction to SQL', 'Technical', 26, 'yes', 'Kernal', 'Tech Publishing'),
    ('0-8046-2957-X', 'Data Structures and Algorithms', 'Programming', 15, 'no', 'Jane Doe', 'Coding House'),
    ('0-8044-2957-X', 'History of World War II', 'History', 30, 'yes', 'David Johnson', 'History Press'),
    ('0-1-23-456789-0','introduction To python','Technical',26,'no','Kennal c','ABC publishing');

    SELECT * FROM Books;
    
    CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)VALUES
    (301, 'Job Jacob', 'J&J villa,TVM', '2021-01-15'),
    (302, 'Anju A', 'Adam Villa,TVm', '2021-02-28'),
    (303, 'Arun P', 'Arun Bhavan,TVM', '2023-03-10'),
    (304,'Bijila M','Biji nivas,Tvm','2021-06-08');

SELECT * FROM Customer;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issue_date, Isbn_book)VALUES
    (401, 301, '2023-06-16', '93-684-843-5'),
    (402, 302, '2023-02-10', '0-8046-2957-X'),
    (403, 303, '2023-06-05', '0-684-84328-5');
    
SELECT * FROM IssueStatus;


CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)VALUES
    (1, 301, 'Introduction to python', '2023-06-22', '0-1-23-456789-0'),
    (2, 302, 'Data Structures and Algorithms', '2023-03-03', '0-8046-2957-X'),
    (3, 303,'History of World War II', '2023-03-11', '0-8044-2957-X');
    
SELECT * FROM ReturnStatus;

#1. Retrieve the book title, category, and rental price of all available books.  
SELECT Book_title, Category, Rental_Price FROM Books
WHERE Status = 'yes';

#2List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary FROM Employee
ORDER BY Salary DESC;

#3.Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT B.Book_title, C.Customer_name FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

#4.Display the total count of books in each category. 
SELECT Category, COUNT(*) AS Total_Books FROM Books
GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position FROM Employee
WHERE Salary > 50000;

#6.List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer_name as 'customer name' FROM Customer 
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

#7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

#8.Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;

#9.Retrieve book_title from book table containing history. 
SELECT Book_title FROM Books
WHERE Category LIKE '%history%';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

#11.Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address FROM Employee E
JOIN Branch B ON E.Branch_no = B.Branch_no
WHERE Position = 'Manager';

#12.Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;














    