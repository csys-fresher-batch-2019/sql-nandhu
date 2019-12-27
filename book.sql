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
status varchar2(100),
comments varchar2(100),
constraint order_id_pk primary key(order_id),
constraint b_id_fk foreign key(b_id) references book(b_id),
constraint book_date_uq unique(u_name,b_id,ordered_date),
constraint amount_ck check(amount>=0),
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
                           

insert into orders(order_id,u_name,b_id,ordered_date,delivered_date,amount,qty,status,comments)
values(3,'riya',1,timestamp '2020-01-01 21:22:23',timestamp '2020-01-04 21:22:23',2000,1,'delivered','abcd');
                           


select count(delivered_date) as sales_count from orders where status='delivered';
                     
create table order_item(item_id number,
order_id number,
bo_id number,
qty number default 1,
sts varchar2(50),
constraint qty_ck check(qty>=1),
constraint item_id_pk primary key(item_id), 
constraint order_id_fk foreign key(order_id)references orders(order_id),
constraint bo_id_fk foreign key(bo_id)references book(b_id)
);        


create table stocks(st_id number,
book_id number,
qnty number,
constraint st_id_pk primary key(st_id),
constraint book_id_fk foreign key(book_id)references book(b_id)
);


insert into order_item(item_id,order_id,bo_id,qty,sts)
values(101,1,1,3,'ordered');

insert into order_item(item_id,order_id,bo_id,qty,sts)
values(102,2,2,4,'ordered');

select * from order_item;

insert into stocks(st_id,book_id,qnty)
values(1001,1,10);
insert into stocks(st_id,book_id,qnty)
values(1002,2,3);
                     
select * from stocks;
                           
select b_name,
(select sum(qty) from order_item where bo_id=b.b_id)as total_count
from book b;
                           
select b_name,
(select sum(qnty) from stocks where book_id=b.b_id)as total_count
from book b;
                           
select b_name,
(
(select sum(qnty) from stocks where book_id=b.b_id)-
(select sum(qty) from order_item where bo_id=b.b_id)
)as available_count
from book b;                   
                   
                   
                   
