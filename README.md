# Matrimonial Management

http://shyloomatrimony.in

## Features

* Viewing the details of the bride, bridegroom.

### Feature 1: List of all bride/bridegroom 
```sql
create sequence users_id_sq increment by 1;
create table profiles
(
user_id number,
user_name varchar2(50) not null,
d_o_b date not null,
gender char(1)not null,
religion varchar2(50)not null,
caste varchar2(50),
country varchar2(50)not null,
states varchar2(30)not null,
city varchar2(30)not null,
mob_no number not null,
aadhar_no number not null,
mail_id varchar2(50) not null,
height number ,
education varchar2(30),
registerd_date date default sysdate,
marital_sts varchar2(20)not null,
occupation varchar2(20),
salary number,
membership_type varchar2(20)not null,
pass varchar2(50)not null,
active number default 1,
constraint pass_uq unique(pass),
constraint aadhar_no_uq unique(aadhar_no),
constraint membership_type_ck check(membership_type in('platinum','gold','silver')),
constraint marital_sts_cq check(marital_sts in ('unmarried','widow','widower','divorced')),
constraint user_id_pk primary key(user_id),
constraint gender_cq check(gender in ('M','F')),
constraint mail_id_uq unique(mail_id),
constraint user_name_mob_no_uq unique(user_name,mob_no)
);
alter table profiles add(pic varchar2(50));
```
* Query

select * from profiles;
| USER_ID | USER_NAME | D_O_B    | GENDER | RELIGION | CASTE | COUNTRY | STATE     | CITY    | MOB_NO     | AADHAR_NO    | MAIL_ID          | HEIGHT | EDUCATION | REGISTERED_DATE | MARITAL_STS | OCCUPATION | SALARY | MEMBERSHIP_TYPE | PASS    | ACTIVE | PIC        |
|---------|-----------|----------|--------|----------|-------|---------|-----------|---------|------------|--------------|------------------|--------|-----------|-----------------|-------------|------------|--------|-----------------|---------|--------|------------|
| 42      | Shyloo    | 20-11-94 | F      | aaa      | bbb   | India   | TamilNadu | chennai | 9876543211 | 123456789012 | shyloo@gmail.com | 5.5    | BE(CSE)   | 29-01-20        | unmarried   | professor  | 30000  | platinum        | shyloo  | 1      | shyloo.jpg |
| 43      | Sound     | 27-12-98 | F      | aaa      | bbb   | India   | TamilNadu | Madurai | 9042814610 | 778899006655 | sound@gmail.com  | 5.2    | BE(CSE)   | 29-01-20        | unmarried   | developer  | 15000  | gold            | pass456 | 1      | sound.jpg  |
| 44      | Aishu     | 14-12-97 | F      | aaa      | bbb   | India   | TamilNadu | Erode   | 6380357541 | 112233445566 | aishu@gmail.com  | 5      | BE        | 29-01-20        | unmarried   | teacher    | 25000  | silver          | pass789 | 1      | aishu.jpg  |

```
### Feature 2: Display the membership_plan details 

```sql

create table plan(
plan_id number,
membership_type varchar2(20)not null,
total_months number not null,
amount number not null,
constraint plan_id_pk primary key (plan_id),
constraint membership_type_cq check(membership_type in('platinum','gold','silver')),
constraint total_months_cq check(total_months in (12,6,3))
);

select * from plan;

| PLAN_ID | MEMBERSHIP_TYPE | TOTAL_MONTHS | AMOUNT |
|---------|-----------------|--------------|--------|
| 1       | platinum        | 12           | 5000   |
| 2       | gold            | 6            | 3000   |
| 3       | silver          | 3            | 2000   |

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

| MEMBER_ID | MD_USER_ID | MD_PLAN_ID | EXPIRY_DATE |
|-----------|------------|------------|-------------|
| 1001      | 101        | 1          | 02-JAN-21   |
| 1002      | 102        | 2          | 02-JUL-20   |
| 1003      | 103        | 3          | 02-APR-20   |

```
### Feature 4: Display the user_request_status details 

```sql
create table request
(
requestor varchar2(40) not null,
acceptor varchar2(40)not null,
status varchar2(20)default 'pending' not null,
constraint status_ck check(status in('pending','accepted','rejected'))
);

select * from request;

| REQUESTOR        | ACCEPTOR         | STATUS   |
|------------------|------------------|----------|
| aishu@gmail.com  | charan@gmail.com | accepted |
| charan@gmail.com | sound@gmail.com  | rejected |
| charan@gmail.com | shyloo@gmail.com | pending  |
```
### Feature 5: Display the admin login details

```sql
create table login
(user_name varchar(20)not null,
password varchar(20)not null);
insert into login(user_name,password)values('admin','admin');

| USER_NAME | PASSWORD |
|-----------|----------|
| admin     | admin    |

```
# Use cases:


* Dispaly total count of all users
```sql
select count(*)as total_count from profiles;

| TOTAL_COUNT |
|-------------|
| 4           |

```
* Display all the bride list 
```sql
select * from profiles where gender='F';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION | SALARY |
|---------|-----------|-----------|--------|----------|-------|---------|------------|--------|-----------|----------------|-------------|------------|--------|
| 101     | Shyloo    | 20-NOV-94 | F      | aaa      | bbb   | India   | 9876543211 | 5.5    | BE(CSE)   | 02-JAN-20      | unmarried   | professor  | 30000  |
| 103     | riya      | 10-JAN-95 | F      | ccc      | ddd   | India   | 9654311654 | 5.2    | BSC(CS)   | 02-JAN-20      | widow       |  -         |  -     |

```
* Display all the bridegroom list
```sql
select * from profiles where gender='M';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
| 104     | charan    | 22-FEB-93 | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 02-JAN-20      | unmarried   | HR                | 45000  |
```
* List all bride with height specification
```sql
select * from profiles where height >=5.5 and gender='F';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION | SALARY |
|---------|-----------|-----------|--------|----------|-------|---------|------------|--------|-----------|----------------|-------------|------------|--------|
| 101     | Shyloo    | 20-NOV-94 | F      | aaa      | bbb   | India   | 9876543211 | 5.5    | BE(CSE)   | 02-JAN-20      | unmarried   | professor  | 30000  |
```
* List all bridegroom with height specification
```sql
select * from profiles where height >=5.5 and gender='M';

| USER_ID | USER_NAME | D_O_B     | GENDER | RELIGION | CASTE | COUNTRY   | MOB_NO     | HEIGHT | EDUCATION | REGISTERD_DATE | MARITAL_STS | OCCUPATION        | SALARY |
|---------|-----------|-----------|--------|----------|-------|-----------|------------|--------|-----------|----------------|-------------|-------------------|--------|
| 102     | Surya     | 28-DEC-92 | M      | bbb      | ccc   | Australia | 8763452983 | 5.9    | BSC(CS)   | 02-JAN-20      | divorced    | Software Engineer | 35000  |
| 104     | charan    | 22-FEB-93 | M      | bbb      | ccc   | India     | 8885555754 | 6.1    | MBA       | 02-JAN-20      | unmarried   | HR                | 45000  |
```
* Display all users name,education,occupation and their salary details
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
* list all the users with their age and marital status
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


