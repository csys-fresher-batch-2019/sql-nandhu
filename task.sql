create table task(status number not null,t_name varchar2(50)not null,task_by varchar2(50)not null,
deadline date not null,completed_date date,
constraint status_cq check(status in (1,0)),
constraint completed_date_cq check(completed_date <=deadline));

insert into task (status,t_name,task_by,deadline,completed_date) 
values(1,'task_1','shyloo',to_date('28-12-2019','dd-MM-yyyy'),to_date('27-12-2019','dd-MM-yyyy');

insert into task (status,t_name,task_by,deadline) 
values(0,'task_2','riya',to_date('29-12-2019','dd-MM-yyyy');


select * from task where status=0;

alter table task add(priority number);

insert into task(status,t_name,task_by,deadline,completed_date,priority) 
values(1,'task_3','ammu',to_date('29-12-2019','dd-MM-yyyy'),to_date('29-12-2019','dd-MM-yyyy',1);
       
insert into task(status,t_name,task_by,deadline,completed_date,priority) 
values(1,'task_4','priya',to_date('27-12-2019','dd-MM-yyyy'),to_date('26-12-2019','dd-MM-yyyy',2);       
       
select * from task;       
