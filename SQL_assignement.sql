-- Creating database sql_assignement
CREATE DATABASE sql_assignement;

-- Creating Department table
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Creating Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

-- Inserting data into Department table
INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Inserting data into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);

SELECT d.name AS Department, ranked_employees.name AS Employee, ranked_employees.salary AS Salary, ranked_employees.salary_rank  AS _rank
FROM 
    (SELECT id, name, salary, departmentId,
		DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_rank
     FROM Employee
    ) AS ranked_employees
JOIN Department AS d 
ON ranked_employees.departmentId = d.id
WHERE ranked_employees.salary_rank <= 3
ORDER BY d.name, ranked_employees.salary DESC, ranked_employees.name;



