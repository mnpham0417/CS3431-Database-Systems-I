/*
	Author: Group 007
		Dung (Kevin) Nguyen - tnguyen4
		Minh Pham - mnpham
*/


/* Question 1 */
create view ClassTypeStats as 
select ClassType, COUNT(dateSubmitted) as Submitted, COUNT(dateRejected) as Rejected, COUNT(dateApproved) as Approved
from wines W
join forms F
on W.wineID = F.wineID
group by ClassType;

create view RemainingCForms as 
select ClassType, (Submitted - Rejected - Approved) as Remaining
from ClassTypeStats 
where LOWER(ClassType) LIKE 'c%'
order by ClassType;
    
select *
from RemainingCForms;

/* Question 2 */
CREATE OR REPLACE PROCEDURE FormsByAgent(AgentName varchar2) IS
    output_name varchar2(25);
    numForms number;
    hasValue number(1) default 1;
Begin 
    Begin 
        SELECT AC.name, count(F.formID) into output_name, numForms
        FROM (select * from accounts where name = AgentName) AC
        JOIN agents AG
            ON AC.loginname = AG.loginname
        JOIN process P
            ON P.ttbID = AG.ttbID
        JOIN forms F
            ON F.formID = P.formID
        group by AC.name;
    
        exception when NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE ('Agent ' || agentName || ': ' || 0); 
          hasValue := 0;
    End;
    if (hasValue = 1) then
        DBMS_OUTPUT.PUT_LINE ('Agent ' || output_name || ': ' || numForms);
    end if;
End;
/
set serveroutput on;

exec FormsByAgent('Mary Young');
exec FormsByAgent('James Williams');
exec FormsByAgent('Jony Yang');

--test cases for question 4
INSERT INTO Forms VALUES (160, 'working', 1989,'02-May-18', '02-May-17',null,101,104,107); 
insert into Forms values (161, 'working', 1990, '02-May-18', null, '02-May-17',101,104,107); 
insert into Forms values (162, 'working', 1990, null, '02-May-18', '02-May-17',101,104,107); 


/* Question 3 */
create or replace trigger InsertErrorDates 
before insert on forms 
for each row
begin
    IF (:new.daterejected < :new.datesubmitted) 
    then 
        raise_application_error(-20001, 'The rejection date of the given form cannot be before its submission date.');    
    elsif (:new.dateApproved < :new.dateSubmitted)
    then
        raise_application_error(-20001, 'The approval date of the given form cannot be before its submission date.');
    elsif (:new.dateApproved is not NULL and :new.dateRejected is not NULL) 
    then
        raise_application_error(-20001, 'The form cannot be both rejected and approved.');
    end if;
end;
/

--test cases for question 3
INSERT INTO Forms VALUES (156, 'working', 1989,'02-May-18', '02-May-17',null,101,104,107); --3a
insert into Forms values (157, 'working', 1990, '02-May-18', null, '02-May-17',101,104,107); --3b
insert into Forms values (158, 'working', 1990, null, '02-May-18', '02-May-17',101,104,107); --3c


/* Question 4 */
create or replace trigger ExistingErrorDates 
before insert on forms
for each row
declare 
    cursor c1 is 
    select datesubmitted, daterejected, dateapproved 
        from forms;
begin 
    for rec in c1 loop
        IF (rec.daterejected < rec.datesubmitted) 
        then 
            raise_application_error(-20001, 'Existing record: The rejection date of the given form cannot be before its submission date.');
        elsif (rec.dateApproved < rec.dateSubmitted)
        then
            raise_application_error(-20001, 'Existing record: The approval date of the given form cannot be before its submission date.');
        elsif (rec.dateApproved is not NULL and rec.dateRejected is not NULL) 
        then
            raise_application_error(-20001, 'Existing record: The form cannot be both rejected and approved.');
        end if;
    end loop;
end;
/
insert into Forms values (163, 'working', 1990, '02-May-18', null, '02-May-19',101,104,107); 

/* Question 5 */
create or replace trigger TooManyReview
after insert or update on process 
declare 
    cursor c1 is
    select a.ttbid, count(f.formid) as countwineform
    from agents a 
    join process p on a.ttbid = p.ttbid
    join forms f on p.formid = f.formid
    group by a.ttbid;
begin
    for rec in c1 loop
        IF (rec.countwineform > 5) 
        then 
            raise_application_error(-20001, 'Current reviewer of too many forms');
        end if;
    end loop;
end;
/
-- Test case:
INSERT INTO Process VALUES (100, 118, '20-Feb-18', 'problem with the alcohol percentage'); -- this should work
INSERT INTO Process VALUES (100, 119, '20-Feb-18', 'problem with the alcohol percentage'); -- this should cause an error
INSERT INTO Process VALUES (101, 112, '20-Feb-18', 'problem with the alcohol percentage'); -- this should cause an error

/* Question 6 */
create or replace trigger ChangeStatus
after insert or update of datesubmitted, daterejected, dateapproved
on forms
DECLARE
    CURSOR c1 is 
    select * from forms;
BEGIN
    for rec in c1 loop
        if(rec.dateRejected is not NULL) 
        then
            update forms set status = 'Rejected' where forms.formID = rec.formID;
        elsif (rec.dateApproved is not null)
        then
            update forms set status = 'Approved' where forms.formID = rec.formID;
        end if;
    end loop;
end;
/
select * from forms;
-- test case for question 6

-- must be included because in table forms, there already are invalid records (test cases from table 4)
drop trigger existingerrordates; 
INSERT INTO Forms VALUES (170,'working',2017,'28-Aug-18', '30-Aug-18',NULL,105,103,102);
INSERT INTO Forms VALUES (154,'working',1989,'02-May-18', null,'02-May-19',101,104,107);
select * from forms;

