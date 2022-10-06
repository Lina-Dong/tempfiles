---- 1b
SELECT job, count(job) AS count FROM Employee GROUP BY job ORDER BY job ASC;

---- 1e
SELECT deptID
FROM Employee
WHERE job = 'engineer'
GROUP BY deptID
HAVING COUNT(job) >= (
	SELECT MAX(cnt)
	FROM (SELECT COUNT(job) AS cnt
		FROM Employee
		WHERE job = 'engineer'
		GROUP BY deptID
		) AS sub_cnt
	)
;

---- 1g
select empID from Employee where salary in (select max(salary) from Employee where salary < (select max(salary) from Employee));

---- 2a
select empName, empID from Employee where empID not in (select empID from Assigned);

---- 2e
select sum(salary) as projectSalary, projID from Employee natural left outer join Assigned group by projID;

---- 3a
UPDATE 
	Employee AS emp 
	NATURAL JOIN Assigned
	NATURAL JOIN Project AS proj 
SET 
	emp.salary = emp.salary * 1.10
WHERE
	proj.title = 'compiler'
;

---- 3b
UPDATE 
	Employee AS emp
	NATURAL JOIN Department AS dept
SET 
	emp.salary = emp.salary * 
	CASE 
    WHEN dept.location = 'Waterloo' THEN 1.08 
    WHEN emp.job = 'janitor' THEN 1.05
    ELSE 1
    END
WHERE
	dept.location = 'Waterloo'
    OR emp.job = 'janitor'
;


---- 3c
ALTER TABLE Employee
ADD shift VARCHAR(5)
;


---- 3d
UPDATE 
	Employee AS emp
SET 
	emp.shift = 
	CASE 
    WHEN NOT empID IN (
		SELECT empID
        FROM Assigned
	) 
    THEN 'N.A.'
    WHEN emp.empID % 2 = 0 THEN 'DAY'
    ELSE 'NIGHT'
    END
;

