create database bookstore;
use bookstore;

create table customers
(CustomerId int not null,
FirstName varchar(20) not null,
Surname varchar(20) not null,
Address varchar(100) not null,
mobile varchar(30),
primary key (customerid)
);


create table stock
(
StockId int not null,
Title varchar(50) not null,
CostPrice decimal(18,2) not null,
SupplierId int not null,
primary key (StockId)
);

create table suppliers
(
SupplierID int not null,
Supplier_Name varchar(50) not null,
Supplier_Address varchar(100) not null,
supplier_tel varchar(30) not null,
primary key (SupplierId)
);

Create table Orders
(
OrderId int not null,
CustomerId int not null,
primary key (OrderId)
);

create table Order_Items
(
ItemId int not null,
OrderId int not null,
StockId int not null,
ISBN varchar(50) not null,
Format varchar(20) not null,
Qty_sold int not null,
sale_price decimal (18,2),
primary key (ItemId)
);


insert into customers (CustomerId, FirstName,surname,address,mobile)
values (1, 'Joe', 'Bloggs', 'Main road', '+35315550934');

insert into Orders (OrderId, CustomerId)
values (100,1);

insert into Suppliers(SupplierID,Supplier_Name,Supplier_Address,supplier_tel)
values (500, 'Books Wholsale', 'Warehouse Lane', '+3531555023849');



insert into stock(StockId,Title,CostPrice,SupplierId)
values (400, 'A Database story', 1.99, 500);

insert into order_items (itemid, orderid, stockid, ISBN, Format, Qty_sold, sale_price)
values(200,100,400, '1234456-7765433', 'Hardback', 1, 9.99);

Select * from orders
select * from customers
select * from suppliers
select * from stock
select * from order_items



select *
from 
customers c
inner join orders o on c.customerid = o.customerid
inner join order_items oi on o.orderid = oi.orderid
inner join stock s on s.stockid = oi.stockid
inner join suppliers su on su.supplierid = s.supplierid  



