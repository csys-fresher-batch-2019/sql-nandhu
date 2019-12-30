create table book(books_id number,b_name varchar2(100)not null,
author_name varchar2(50)not null,
price number not null,
publisher varchar2(50)not null,
version number,
cat varchar2(50)not null,
active_status number default 1,
constraint books_id_pk primary key(books_id),
constraint name_version_uq unique(b_name,author_name,version),
constraint price_ck check(price>=0),
constraint active_status_ck check(active_status in(1,0))
);


create table orders(
order_id number,u_name varchar2(50)not null,
books_id number not null,
ordered_date timestamp not null,
delivered_date timestamp,
amount number not null,
status varchar2(100),
comments varchar2(100),
constraint order_id_pk primary key(order_id),
constraint books_id_fk foreign key(books_id) references book(books_id),
constraint book_date_uq unique(u_name,books_id,ordered_date),
constraint amount_ck check(amount>=0),
constraint status_ck check(status in ('ordered','not available','delivered','canceled')) 
);


insert into book(books_id,b_name,author_name,price,publisher,version,cat)
values(1,'JAVA','AAA',1000,'BBB',2,'practical');


insert into book(books_id,b_name,author_name,price,publisher,version,cat)
values(4,'oracle','ooo',2000,'rrr',2,'practical');

insert into book(books_id,b_name,author_name,price,publisher,version,cat)
values(2,'C','bbb',2000,'CCC',1,'practical');


insert into orders(order_id,u_name,books_id,ordered_date,amount,status,comments)
values(1,'shyloo',1,timestamp '2020-01-01 21:22:23',1000,'ordered','abcd');


insert into orders(order_id,u_name,books_id,ordered_date,amount,status,comments)
values(2,'nandhu',1,timestamp '2020-01-03 21:22:23',1000,'ordered','abcd');

insert into orders(order_id,u_name,books_id,ordered_date,delivered_date,amount,status,comments)
values(3,'riya',1,timestamp '2020-01-01 21:22:23',timestamp '2020-01-04 21:22:23',2000,'delivered','abcd');


select * from book,orders;


select b.b_name,o.u_name from book b inner join orders o on b.books_id=o.books_id;

select b.books_id,b.b_name,b.price,o.order_id,o.books_id,o.u_name,o.comments from book b left outer join orders o on b.books_id=o.books_id; 


select b.books_id,b.b_name,b.price,o.order_id,o.books_id,o.u_name,o.comments from book b right outer join orders o on b.books_id=o.books_id; 


select b.books_id,b.b_name,b.price,o.order_id,o.books_id,o.u_name,o.comments from book b full outer join orders o on b.books_id=o.books_id; 
