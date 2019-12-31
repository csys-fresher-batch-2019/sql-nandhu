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
*Query
```sql

insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(101,'Shyloo',to_date('20-11-1994','dd-MM-yyyy'),'F','aaa','bbb','India',9876543211,5.5,'BE(CSE)');


insert into profiles(user_id,user_name,d_o_b,gender,religion,caste,country,mob_no,height,education)
values(102,'Surya',to_date('28-12-1992','dd-MM-yyyy'),'M','bbb','ccc','Australia',8763452983,5.9,'BSC(CS)');

select * from profiles;

```
* alter query
```sql
alter table profiles add(
registerd_date date default sysdate);

```
### Feature 2: Display the membership_plan details 

```sql
create table plan(
plan_id number,
user_id number,
membership_type varchar2(20)not null,
total_duration number not null,
constraint plan_id_pk primary key (plan_id),
constraint user_id_fk foreign key (user_id)references profiles(user_id),
constraint membership_type_cq check(membership_type in('platinum','gold','silver')),
constraint total_duration_cq check(total_duration in (12,6,3))
);

```
### Feature 3: Display the membership_duration details 

```sql
create table membersip_duration(
member_id number,
user_duration_id number,
plan_id number,
expiry_date date not null,
constraint member_id_pk primary key(member_id),
constraint user_duration_id_fk foreign key(user_duration_id)references profiles(user_id),
constraint plan_id_fk foreign key(plan_id)references plan(plan_id)
);
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
```
