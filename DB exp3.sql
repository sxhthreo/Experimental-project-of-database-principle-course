--1、创建一个查询图书库存量的存储过程“cx_tskcl_proc”，输出的内容包含类别号、图书编号、图书名称、库存数等数据内容。
create procedure cx_tskcl_proc as
	select 类别号,图书编号,图书名称,库存数 from 图书明细表
exec cx_tskcl_proc;
--2、创建一个名为TS_CX_PROC的存储过程，它带有一个输入参数，用于接受图书编号，显示该图书的名称、作者、出版和复本数。
create procedure TS_CX_PROC
	@id char(10) 
as
	select 图书名称,作者,出版社,复本数 from 图书明细表 where @id = 图书编号
exec TS_CX_PROC '00000476';
--3、修改存储
--修改TS_CX_PROC存储过程，使之能按图书名称查询图书的相关信息。
alter procedure TS_CX_PROC
	@name char(30)
as
	select 图书名称,作者,出版社,复本数 from 图书明细表 where @name = 图书名称
--执行修改后的TS_CX_PROC存储过程，分别查询“航海英语”、“艺海潮音”等图书的信息。
exec TS_CX_PROC '航海英语';
exec TS_CX_PROC '艺海潮音';
--4、删除存储过程
drop procedure TS_CX_PROC;
--5、图书类别表上创建一个名为tslb_insert_trigger的触发器，当执行INSERT操作时，该触发器被触发，禁止插入记录。
create trigger tslb_insert_trigger on 图书类别 for insert
as
   if exists(select * from inserted)
	rollback;
insert into 图书类别 values('a','编译原理');
--6、在图书明细表上创建一个名为ts_delete_trigger的触发器，当执行DELETE操作时，该触发器被触发，禁止删除记录。
create trigger ts_delete_trigger on 图书明细表 for delete
as
  if exists(select * from deleted)
	rollback;
delete from 图书明细表 where 图书名称 = '艺海潮音';
--7、在读者信息表上创建一个名为dzxx_insert_trigger的触发器，当在读者信息表中插入记录时，将该记录中的借书证号自动插入借还明细表中。
create trigger dzxx_insert_trigger on 读者信息表 for insert
as
	declare @borrow char(10);
	if exists(select * from inserted)
	begin
		select @borrow = 借书证号 from inserted;
		insert into 借还明细表(借书证号) values (@borrow);
	end
insert into 读者信息表 values('1','钱泽枢','男','2001-11-30',1,'网络空间安全系','13080519036','828@csu.edu.cn');
select * from 读者信息表 where 姓名 = '钱泽枢';
select * from 借还明细表;
--8、删除触发器
drop trigger tslb_insert_trigger;
drop trigger ts_delete_trigger;
drop trigger dzxx_insert_trigger;