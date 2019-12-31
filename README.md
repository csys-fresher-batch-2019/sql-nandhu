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
registerd_date date default sysdate);

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(101,'Shyloo',to_date('20-11-1994','dd-MM-yyyy'),'F','aaa','bbb','India',9876543211,5.5,'BE(CSE)');


insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(102,'Surya',to_date('28-12-1992','dd-MM-yyyy'),'M','bbb','ccc','Australia',8763452983,5.9,'BSC(CS)');

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(103,'riya',to_date('10-01-1995','dd-MM-yyyy'),'F','ccc','ddd','India',9654311654,5.2,'BSC(CS)');

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(104,'charan',to_date('22-02-1993','dd-MM-yyyy'),'M','bbb','ccc','India',8885555754,6.1,'MBA');

select * from profiles;

| USER_ID | USER_NAME | D_O_B              | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE |
|---------|-----------|--------------------|--------|----------|-------|-----------|------------|--------|-----------|----------------|
| 101     | Shyloo    | 20-NOV-94          | F      | aaa      | bbb   | India     | 9876543211 | 5.5    | BE(CSE)   | 31-DEC-19      |
| 102     | Surya     | 28-DEC-92          | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 31-DEC-19      |
| 103     | riya      | 10-JAN-95          | F      | ccc      | ddd   | India     | 9654311654 | 5.2    | BSC(CS)   | 31-DEC-19      |
| 104     | Charan    | 22-FEB-93          | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 31-DEC-19      |


```
### Feature 2: Display the membership_plan details 

```sql
create table plan(
plan_id number,
membership_type varchar2(20)not null,
total_months number not null,
constraint plan_id_pk primary key (plan_id),
constraint membership_type_cq check(membership_type in('platinum','gold','silver')),
constraint total_months_cq check(total_months in (12,6,3))
);
```
* Query
```sql
insert into plan(plan_id,membership_type,total_months)
values(1,'platinum',12);

insert into plan(plan_id,membership_type,total_months)
values(2,'gold',6);


insert into plan(plan_id,membership_type,total_months)
values(3,'silver',3);

select * from plan;

| PLAN_ID | MEMBERSHIP_TYPE | TOTAL_MONTHS |
|---------|-----------------|--------------|
| 1       | platinum        | 12           |
| 2       | gold            | 6            |
| 3       | silver          | 3            |

### Table 3: Display the membership_duration details

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

update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=101),12)where md_user_id=101 ;
update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=102),6)where md_user_id=102 ;
update  membership_duration set expiry_date=add_months((select registerd_date from profiles where user_id=103),3)where md_user_id=103;

| MEMBER_ID | MD_USER_ID | MD_PLAN_ID | EXPIRY_DATE |
|-----------|------------|------------|-------------|
| 1001      | 101        | 1          | 31-DEC-20   |
| 1002      | 102        | 2          | 30-JUN-20   |
| 1003      | 103        | 3          | 31-MAR-20   |

```
### Feature 3: Display the user_request_status details 

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

| USER_1_ID | USER_2_ID | STATUS   | REQUEST_STARTS_BY |
|-----------|-----------|----------|-------------------|
| 101       | 102       | rejected | 101               |
| 103       | 104       | accepted | 104               |
```
