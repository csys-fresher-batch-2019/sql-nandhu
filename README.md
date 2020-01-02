# Matrimonial Management

http://matrimony.in

## Features

* Viewing the details of the bride, bridegroom.

### Feature 1: List of all bride/bridegroom 
```sql
create table profiles
(
user_id number,
user_name varchar2(50) not null,
d_o_b date not null,
gender char(1)not null,
religion varchar2(50)not null,
caste varchar2(50),
country varchar2(50)not null,
mob_no number not null,
height number ,
education varchar2(30),
constraint user_id_pk primary key(user_id),
constraint gender_cq check(gender in ('M','F'))
);
```
* Query
```sql

alter table profiles add(
registerd_date date default sysdate,
marital_sts varchar2(20)not null,
occupation varchar2(20),
salary number,
constraint marital_sts_cq check(marital_sts in ('unmarried','widow','widower','divorced'))
);

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education,occupation,salary,marital_sts)
values(101,'Shyloo',to_date('20-11-1994','dd-MM-yyyy'),'F','aaa','bbb','India',9876543211,5.5,'BE(CSE)','professor',30000,'unmarried');

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education,occupation,salary,marital_sts)
values(102,'Surya',to_date('28-12-1992','dd-MM-yyyy'),'M','bbb','ccc','Australia',8763452983,5.9,'BSC(CS)','Software Engineer','35000','divorced');

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education,marital_sts)
values(103,'riya',to_date('10-01-1995','dd-MM-yyyy'),'F','ccc','ddd','India',9654311654,5.2,'BSC(CS)','widow');

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education,occupation,salary,marital_sts)
values(104,'charan',to_date('22-02-1993','dd-MM-yyyy'),'M','bbb','ccc','India',8885555754,6.1,'MBA','HR',45000,'unmarried');


select * from profiles;

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 101     | Shyloo    | 20-NOV-94 | F      | aaa      | bbb   | India     | 9876543211 | 5.5    | BE(CSE)   | 02-JAN-20      | unmarried   | professor         | 30000  |
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
| 104     | charan    | 22-FEB-93 | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 02-JAN-20      | unmarried   | HR                | 45000  |
| 103     | riya      | 10-JAN-95 | F      | ccc      | ddd   | India     | 9654311654 | 5.2    | BSC(CS)   | 02-JAN-20      | widow       |  -                |  -     |


```
### Feature 2: Display the membership_plan details 

```sql

create table plan(
plan_id number,
membership_type varchar2(20)not null,
total_months number not null,
phone_no_count number not null,
amount number not null,
constraint plan_id_pk primary key (plan_id),
constraint membership_type_cq check(membership_type in('platinum','gold','silver')),
constraint total_months_cq check(total_months in (12,6,3))
);

insert into plan(plan_id,membership_type,total_months,phone_no_count,amount)
values(1,'platinum',12,100,5000);

insert into plan(plan_id,membership_type,total_months)
values(2,'gold',6,60,3000);

insert into plan(plan_id,membership_type,total_months)
values(3,'silver',3,40,2000);

select * from plan;

| PLAN_ID | MEMBERSHIP_TYPE | TOTAL_MONTHS | PHONE_NO_COUNT | AMOUNT |
|---------|-----------------|--------------|----------------|--------|
| 1       | platinum        | 12           | 100            | 5000   |
| 2       | gold            | 6            | 60             | 3000   |
| 3       | silver          | 3            | 40             | 2000   |

```
### Feature 3: Display the membership_duration details 

```sql
create table membership_duration(
member_id number,
md_user_id number,
md_plan_id number,
expiry_date date,
constraint member_id_pk primary key(member_id),
constraint md_user_id_fk foreign key(md_user_id)references profiles(user_id),
constraint md_plan_id_fk foreign key(md_plan_id)references plan(plan_id)
);
```
* query
```sql
insert into membership_duration
(member_id,md_user_id,md_plan_id)
values(1001,101,1);

 insert into membership_duration
(member_id,md_user_id,md_plan_id)
values(1002,102,2);

 insert into membership_duration
(member_id,md_user_id,md_plan_id)
values(1003,103,3);

update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=101),12)where md_user_id=101 and md_plan_id=1 ;
update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=102),6)where md_user_id=102 and md_plan_id=2 ;
update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=103),3)where md_user_id=103 and md_plan_id=3;


| MEMBER_ID | MD_USER_ID | MD_PLAN_ID | EXPIRY_DATE |
|-----------|------------|------------|-------------|
| 1001      | 101        | 1          | 02-JAN-21   |
| 1002      | 102        | 2          | 02-JUL-20   |
| 1003      | 103        | 3          | 02-APR-20   |

```
### Feature 4: Display the user_request_status details 

```sql
create table request_status
(
user_1_id  number,
user_2_id number,
status varchar2(20)not null,
request_starts_by number(20)not null,
constraint user_1_id_fk foreign key(user_1_id)references profiles(user_id),
constraint user_2_id_fk foreign key(user_2_id)references profiles(user_id),
constraint status_cq check(status in ('accepted','rejected'))
);

insert into  request_status(user_1_id,user_2_id,status,request_starts_by)
values(101,102,'rejected',101);

insert into  request_status(user_1_id,user_2_id,status,request_starts_by)
values(103,104,'accepted',104);

select * from request_status;

| USER_1_ID   | USER_2_ID | STATUS   | REQUEST_STARTS_BY |
|-------------|-----------|----------|-------------------|
| 101         | 102       | rejected | 101               |
| 103         | 104       | accepted | 104               |
| 101         | 104       | rejected | 101               |
| 103         | 102       | accepted | 103               |
| 104         | 101       | rejected | 101               |
| 104         | 103       | accepted | 103               |
```

# Use cases:


* Dispaly total count of all users
```sql
select count(*)as total_count from profiles;

| TOTAL_COUNT |
|-------------|
| 4           |

```
* Display the total count of bride
```sql
select count(*)as bride_count from profiles where gender='F';

| BRIDE_COUNT |
|-------------|
| 2           |
```
* Display the total count of bridegroom
```sql
select count(*)as bridegroom_count from profiles where gender='M';

| BRIDEGROOM_COUNT |
|------------------|
| 2                |

```
* Display all the bride ist in ascending order
```sql
select * from profiles where gender='F';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION | SALARY |
|---------|-----------|-----------|--------|----------|-------|---------|------------|--------|-----------|----------------|-------------|------------|--------|
| 101     | Shyloo    | 20-NOV-94 | F      | aaa      | bbb   | India   | 9876543211 | 5.5    | BE(CSE)   | 02-JAN-20      | unmarried   | professor  | 30000  |
| 103     | riya      | 10-JAN-95 | F      | ccc      | ddd   | India   | 9654311654 | 5.2    | BSC(CS)   | 02-JAN-20      | widow       |  -         |  -     |

```
* Display all the bridegroom ist in descending order
```sql
select * from profiles where gender='M';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
| 104     | charan    | 22-FEB-93 | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 02-JAN-20      | unmarried   | HR                | 45000  |
```
* Display all user name,education,occupation and their salary details
```sql
select user_name,education,occupation,salary from profiles ;

| USER_NAME | EDUCATION | OCCUPATION        | SALARY |
|-----------|-----------|-------------------|--------|
| Shyloo    | BE(CSE)   | professor         | 30000  |
| Surya     | BSC(CS)   | Software Engineer | 35000  |
| riya      | BSC(CS)   |  -                |  -     |
| charan    | MBA       | HR                | 45000  |

```
* List the bridegroom list with the specific occupation
```sql
select * from profiles where gender='M' and occupation = 'Software Engineer';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
|         |           |           |        |          |       |           |            |        |           |                |             |                   |        |
```
* list all the bridegroom having the salary greater than 30000/-
```sql
select * from profiles where salary>30000 and gender='M';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
| 104     | charan    | 22-FEB-93 | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 02-JAN-20      | unmarried   | HR                | 45000  |
```
* list all the users their age and marital status
```sql
select user_name,extract(year from sysdate)-extract(year from d_o_b)as Age,marital_sts from profiles;

| USER_NAME | AGE | MARITAL_STS |
|-----------|-----|-------------|
| Shyloo    | 26  | unmarried   |
| Surya     | 28  | divorced    |
| riya      | 25  | widow       |
| charan    | 27  | unmarried   |
```
* list the user name with their registration date ,expiry date and the membership type
```sql
select p.user_name,p.registerd_date,m.expiry_date,l.membership_type
from profiles p,plan l,membership_duration m
where p.user_id=m.md_user_id
and l.plan_id=m.md_plan_id;

| USER_NAME | REGISTERD_DATE | EXPIRY_DATE | MEMBERSHIP_TYPE |
|-----------|----------------|-------------|-----------------|
| Shyloo    | 02-JAN-20      | 02-JAN-21   | platinum        |
| Surya     | 02-JAN-20      | 02-JUL-20   | gold            |
| riya      | 02-JAN-20      | 02-APR-20   | silver          |

```
* Display the user name and remaining days for the expiry date of the membership plan  
```sql
select user_name,
(
(select expiry_date from membership_duration where md_user_id=102)-
(select registerd_date from profiles where user_id=102)
)as remaining_days 
from profiles where user_id=102; 

| USER_NAME | REMAINING_DAYS |
|-----------|----------------|
| Surya     | 182            |
```
* Extending the validity time after the membership has expired
```sql
update membership_duration set expiry_date=add_months(expiry_date,12)
where md_user_id=101; 

select * from membership_duration;

| MEMBER_ID | MD_USER_ID | MD_PLAN_ID | EXPIRY_DATE |
|-----------|------------|------------|-------------|
| 1001      | 101        | 1          | 02-JAN-22   |
| 1002      | 102        | 2          | 02-JUL-20   |
| 1003      | 103        | 3          | 02-APR-20   |

```


