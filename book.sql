create table book(b_id number,b_name varchar2(100)not null,
author_name varchar2(50)not null,
price number not null,
publisher varchar2(50)not null,
version number,
cat varchar2(50)not null,
active_status number default 1,
constraint b_id_pk primary key(b_id),
constraint name_version_uq unique(b_name,author_name,version),
constraint price_ck check(price>=0),
constraint active_status_ck check(active_status in(1,0))
);


create table orders(
order_id number,u_name varchar2(50)not null,
b_id number not null,
ordered_date timestamp not null,
delivered_date timestamp,
amount number not null,
qty number default 1,
status varchar2(100),
comments varchar2(100),
constraint order_id_pk primary key(order_id),
constraint b_id_fk foreign key(b_id) references book(b_id),
constraint book_date_uq unique(u_name,b_id,ordered_date),
constraint amount_ck check(amount>=0),
constraint qty_ck check(qty>=1),
constraint status_ck check(status in ('ordered','not available','delivered','canceled')) 
);

insert into book(b_id,b_name,author_name,price,publisher,version,cat)
values(1,'JAVA','AAA',1000,'BBB',2,'practical');


insert into book(b_id,b_name,author_name,price,publisher,version,cat)
values(2,'C','bbb',2000,'CCC',1,'practical');


insert into orders(order_id,u_name,b_id,ordered_date,amount,qty,status,comments)
values(1,'shyloo',1,timestamp '2020-01-01 21:22:23',1000,1,'ordered','abcd');


insert into orders(order_id,u_name,b_id,ordered_date,amount,status,comments)
values(2,'nandhu',2,current_timestamp ,2000,'not available','efgh');


select * from book;


select * from orders;
