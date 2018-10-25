

/* Use the TEMP1 table to record the number of employees earning more than the 
threshold amount, the number of employees whose commission is greater than their 
salary, and the total wages of the employees of the department number and job 
combination.  This will necessitate the creation of a TEMP1 table of the f
ollowing structure:

1. Sum of wages for all employees whos com > salary
2. sum of wages for all employees (given deptno and job title)



*/


DECLARE 

depthold number(2) := &dnum;
jobhold varchar2(10) := UPPER('&jobtype');
	cursor emp_cursor is 
		select sal, comm from emp where deptno = depthold and job = jobhold;
total_wages number(11,2) := 0;
high_paid number(4) := 0;
higher_comm number(4) := 0;
emp_record emp_cursor%rowtype;

BEGIN
	open emp_cursor;
	LOOP
		FETCH emp_cursor into emp_record;
		exit when emp%cursor notfound;
		total_wages := total_wages + emp_record.sal + emp_record.comm;

		IF emp_record.sal > 2000 THEN 
			high_paid := high_paid + 1;
		END IF;

		
	END LOOP;

	DBMS_OUTPUT.PUT_LINE(high_paid);
	DBMS_OUTPUT.PUT_LINE(higher_comm);
	DBMS_OUTPUT.PUT_LINE(total_wages);

	INSERT INTO temp1 values (high_paid, higher_comm, 'Total Wages: ' || to_char(total_wages));
	commit;
END;
/


