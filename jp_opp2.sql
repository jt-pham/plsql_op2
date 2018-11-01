DECLARE
depthold number(2) := &dnum;
jobhold varchar2(10) := UPPER('&jobtype');
  cursor emp_cursor is
      select sal, comm from emp where deptno = depthold and job = jobhold;
  cursor dept_roles is
	  select DISTINCT JOB from emp WHERE job = jobhold;
  total_wages   number(11,2) := 0;
  high_paid     number(4) := 0;
  higher_comm   number(4) := 0;
  emp_record emp_cursor%rowtype;
  emp_job dept_roles%rowtype;

  norow_exception exception;
BEGIN
  open emp_cursor;
  open dept_roles;
  loop
	 fetch dept_roles into emp_job;
	 if dept_roles%ROWCOUNT<1 THEN
     raise norow_exception;
	 end if;
     exit when dept_roles%notfound;

  end loop;
  loop
     fetch emp_cursor into emp_record;
	   if emp_cursor%ROWCOUNT<1 THEN
		  RAISE NO_DATA_FOUND;
	   end if;
     exit when emp_cursor%notfound;
     emp_record.comm := nvl(emp_record.comm,0);
     total_wages := total_wages + emp_record.sal +
           emp_record.comm;
     if emp_record.sal > 2000 then
          high_paid := high_paid + 1;
     end if;
     if emp_record.comm  > emp_record.sal then
          higher_comm := higher_comm + 1;
     end if;
   end loop;
   insert into temp1 values (high_paid, higher_comm,
        'Total Wages: ' || to_char(total_wages));
   commit;
   EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_output.put_line('No Qualifying Employee(s)');
	WHEN OTHERS THEN
		DBMS_output.put_line(jobhold ||' is not a valid job');
end;
/
