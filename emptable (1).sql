set echo on
set feedback on
drop table dept cascade constraints;
drop table emp cascade constraints;
create table dept (deptno number(2) primary key, dname varchar2(14), loc varchar2(13));
create table emp (empno number(4) primary key, ename varchar2(10) not null, job varchar2(10),
mgr number(4), hiredate date, sal number(7,2), comm number(7,2), 
deptno number(2) not null references dept (deptno));
create table temp1 (col1 varchar2(10), col2 varchar(10), message varchar2(30));
insert into dept values (10, 'ACCOUNTING', 'NEW YORK');
insert into dept values (20, 'RESEARCH', 'DALLAS');
insert into dept values (30, 'SALES', 'CHICAGO');
insert into dept values (40, 'OPERATIONS', 'BOSTON');
insert into emp values (7369, 'SMITH', 'CLERK', 7902, '17-dec-80', 800, null, 20);
insert into emp values (7499, 'ALLEN', 'SALESMAN', 7698, '20-feb-81', 1600, 300, 30);
insert into emp values (7521, 'WARD', 'SALESMAN', 7698, '22-feb-81', 1250, 500, 30);
insert into emp values (7566, 'JONES', 'MANAGER', 7839, '02-apr-81', 2975, null, 20);
insert into emp values (7654, 'MARTIN', 'SALESMAN', 7698, '28-sep-81', 1250, 1400, 30);
insert into emp values (7698, 'BLAKE', 'MANAGER', 7839, '01-may-81', 2850, null, 30);
insert into emp values (7782, 'CLARK', 'MANAGER', 7839, '09-jun-81', 2450, null, 10);
insert into emp values (7788, 'SCOTT', 'ANALYST', 7566, '19-apr-87', 3000, null, 20);
insert into emp values (7839, 'KING', 'PRESIDENT', null, '17-nov-81', 5000, null, 10);
insert into emp values (7844, 'TURNER', 'SALESMAN', 7698, '08-sep-81', 1500, 0, 30);
insert into emp values (7876, 'ADAMS', 'CLERK', 7788, '23-may-87', 1100, null, 20);
insert into emp values (7900, 'JAMES', 'CLERK', 7698, '03-dec-81', 950, null, 30);
insert into emp values (7902, 'FORD', 'ANALYST', 7566, '03-dec-81', 3000, null, 20);
insert into emp values (7934, 'MILLER', 'CLERK', 7782, '23-jan-82', 1300, null, 10);
commit;
set linesize 130
set pagesize 100
desc dept
select * from dept;
desc emp
select * from emp;