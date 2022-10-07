---- 1b
SELECT job, COUNT(*) as count FROM Employee group by job order by job asc;

---- 1e
SELECT deptID FROM (SELECT deptId, COUNT(*) as cnt from Employee where job = "engineer" group by deptID order by COUNT(*) desc) as T
where cnt = (SELECT COUNT(*) as cnt from Employee where job = "engineer" group by deptID order by COUNT(*) desc LIMIT 1);


---- 1g
SELECT empID from Employee where salary = (SELECT salary from Employee where salary < (SELECT salary from Employee order by salary desc LIMIT 1) order by salary desc LIMIT 1);


---- 2a
SELECT Employee.empName, Employee.empID FROM Employee WHERE Employee.empID NOT IN (SELECT empID FROM Assigned);


---- 2e
SELECT projID, SUM(salary) as projectSalary from (Employee natural join Assigned) group by projID union SELECT NULL, SUM(salary) FROM (Employee) WHERE Employee.empID NOT IN (SELECT empID FROM Assigned);

---- 3a
update Employee set salary = salary * 1.1 WHERE empID IN (SELECT empID from Project JOIN Assigned WHERE Project.projID = Assigned.projID and Project.title = "compiler");


---- 3b
update (Employee natural join Department)
set salary = salary * 
(case
when location = "Waterloo" and job = "janitor" then 1.08
when job = "janitor" then 1.05
when location = "Waterloo" then 1.08
else 1
end);


---- 3c
ALTER TABLE Employee
ADD shift VARCHAR(5);


---- 3d
update (Employee natural join Assigned)
set shift = 
(case
when projID = null then "N.A."
when MOD(empID, 2) = 0 then "DAY"
when MOD(empID, 2) != 0 then "NIGHT"
end);
