# Matrimonial Management

http://matrimony.in

## Features

* Viewing the details of the bride, bridegroom.

### Feature 1: List all bride/bridegroom 
'''sql
create table profiles
(
user_id number,
user_name varchar2(50) not null,
age number not null,
gender char(1),
religion varchar2(50)not null,
caste varchar2(50),
country varchar2(50)not null,
mob_no number not null,
height number ,
education varchar2(30),
constraint user_id_pk primary key(user_id),
constraint gender_cq check(gender in ('M','F'))
);
'''
*Query


insert into profiles(user_id,user_name,age,gender,religion,caste,country,mob_no,height,education)
values(101,'Shyloo',26,'F','aaa','bbb','India',9876543211,5.5,'BE(CSE)');


insert into profiles(user_id,user_name,age,gender,religion,caste,country,mob_no,height,education)
values(102,'Surya',28,'M','bbb','ccc','Australia',8763452983,5.9,'BSC(CS)');

select * from profiles;
