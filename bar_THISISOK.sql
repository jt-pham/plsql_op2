


/* 
Use the TEMP1 table to record the number of employees earning more than the 
threshold amount (2000) 

the number of employees whose commission is greater than their 
salary

, and the total wages of the employees of the department number and job 
combination.  This will necessitate the creation of a TEMP1 table of the f
ollowing structure:

1. Sum of wages for all employees whos com > salary
2. sum of wages for all employees (given deptno and job title)



*/


DECLARE
	depthold number(2) := &dnum;
	jobhold varchar2(10) := UPPER('&jobtype');
	jobfound boolean := FALSE;

	CURSOR emp_cursor IS 
		SELECT sal, comm FROM emp WHERE deptno = depthold AND job = jobhold;

		--dept cursor is independent of emp cursor to perform summations
	cursor dept_cursor is 
  		select sal, comm, job, ename from emp where deptno = depthold;

  		--selecting all distinct job elements to compare jobhold to 
  	cursor job_cursor is 
  		select distinct job from emp; 


	total_wages number(11,2) := 0;
	high_paid number(4) := 0;
	higher_comm number(4) := 0;
	emp_record emp_cursor%rowtype;
	job_record job_cursor%rowtype;

	INVALID_TITLE EXCEPTION; 

BEGIN
	OPEN emp_cursor;

	FETCH emp_cursor into emp_record;


	
	-- main fuckin logic defined by scammel. THis shit doesnt work in the case of invalid combo or job title 
	FOR dept_record IN dept_cursor LOOP
		dept_record.comm := NVL(dept_record.comm, 0);
		

		IF dept_record.job = jobhold THEN
		total_wages := total_wages + dept_record.sal + dept_record.comm;
		dbms_output.put_line(total_wages);
		END IF;

		IF dept_record.sal > 2000 THEN --not working 
			high_paid := high_paid + 1;
		END IF;

		IF dept_record.comm > dept_record.sal THEN
			higher_comm := higher_comm + 1;
		END IF;

	END LOOP;

	INSERT INTO temp1 VALUES (high_paid, higher_comm, total_wages);
	commit; 


	FOR job_record in job_cursor LOOP
		IF job_record.job = jobhold THEN
			jobfound := TRUE;
		END IF;
	END LOOP;

	IF (emp_cursor%rowcount = 0) AND (jobfound = TRUE) THEN RAISE no_data_found;

	END IF;

	IF (emp_cursor%rowcount = 0) AND (jobfound = FALSE) THEN RAISE INVALID_TITLE;
	
	END IF;
	

	


	

EXCEPTION
	WHEN no_data_found THEN 
		dbms_output.put_line('No qualifying Employee(s)');
		INSERT INTO temp1 VALUES (high_paid, higher_comm, total_wages);
	WHEN INVALID_TITLE THEN
		dbms_output.put_line(jobhold || ' Is not a valid job title');
		INSERT INTO temp1 VALUES (high_paid, higher_comm, total_wages);

END;

/


/*--loop through all distinct job elements
	FOR job_record in job_cursor LOOP
		IF job_record.job = jobhold THEN
			jobfound := TRUE;
		END IF;
	END LOOP;

	IF (emp_cursor%rowcount = 0) AND (jobfound = TRUE) THEN RAISE no_data_found;
	END IF;

	IF (emp_cursor%rowcount = 0) AND (jobfound = FALSE) THEN RAISE INVALID_TITLE;
	END IF;
*/