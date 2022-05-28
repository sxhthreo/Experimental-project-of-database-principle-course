# 一、实验一：数据表, 索引, 视图创建, 修改,删除的设计与完整性约束

## 1.1 实验目的

（1）掌握数据表设计的具体细节操作。

（2）掌握primary key 、check、default， references 等约束的应用。

## 1.2 实验内容

(一）创建以下六张表，有如下要求: 本次实验100分

1）创建后面给出的这6个表（20分）。

```sql
create table 读者信息表
(
	借书证号 char(10),
	姓名 char(10),
	性别 char(10),
	出生日期 date,
	借书量 smallint,
	工作单位 char(20),
	电话 char(15),
	Email char(20)
);
insert into 读者信息表 values 
('29307142','张晓露','女','1989-02-01',2,'管理信息系','85860126','zxl@163.com'),
('36405216','李阳','男','1988-12-26',1,'航海系','85860729','ly@sina.com.cn'),
('28308208','王新全','男','1988-04-25',1,'人文艺术系','85860618','wxq@yahoo.cn'),
('16406236','张继刚','男','1989-08-18',1,'轮机工程系','85860913','zjg@163.com');
insert into 读者信息表(借书证号,姓名,性别,出生日期,工作单位,电话,Email) values
('16406247','顾一帆','男','1981-12-30','轮机工程系','85860916','gyf@yahoo.cn');
create table 借还明细表
(
	借书证号 char(10),
	图书编号 char(10),
	借还 char(5),
	借书日期 date,
	还书日期 date,
	数量 smallint,
	工号 char(10)
);
insert into 借还明细表 values
('29307142','07108667','还','2008-03-28','2008-04-14',1,'002016');
insert into 借还明细表(借书证号,图书编号,借还,借书日期,数量,工号) values
('29307142','99011818','借','2008-04-27',1,'002016'),
('36405216','07410802','借','2008-04-27',1,'002018'),
('29307142','07410298','借','2008-04-28',1,'002018');
insert into 借还明细表 values
('36405216','00000746','还','2008-04-29','2008-05-09',1,'002016');
insert into 借还明细表(借书证号,图书编号,借还,借书日期,数量,工号) values
('28308208','07410139','借','2008-05-10',1,'002019'),
('16406236','07410139','借','2008-05-11',1,'002017');
create table 图书类别
(
	类别号 char(10),
	图书类别 char(10)
);
insert into 图书类别 values
('H31','英语'),('I267','当代作品'),('TP312','程序语言'),('TP393','计算机网络'),('U66','船舶工程');
create table 图书借阅明细表
(
	图书编号 char(10),
	图书名称 char(20),
	借书证号 char(10),
	借出日期 date,
	归还日期 date,
	库存数 smallint
);
insert into 图书借阅明细表(图书编号,图书名称,借书证号,借出日期,库存数) values
('99011818','文化苦旅','29307142','2008-04-27',14),
('07410802','航海英语','36405216','2008-04-27',24),
('07410298','C++程序设计语言','29307142','2008-04-28',14),
('07410139','艺海潮音','28308208','2008-05-10',18),
('07410139','艺海潮音','16406236','2008-05-11',17);
create table 工作人员
(
工号 char(10),
姓名 char(10),
性别 char(2),
出生日期 date,
联系电话 char(10),
Email  char(20)
);
insert into  工作人员 values
('002016','周学飞','男','1971-05-03','85860715','zxf@163.com'),
('002017','李晓静','女','1979-09-15','85860716','lj@163.com'),
('002018','顾彬','男','1972-04-25','85860717','gb@yahoo.cn'),
('002019','陈欣','女', '1968-11-03','85860718','cx@sina.com.cn');

create table 图书明细表
(
	类别号 char(10),
	图书编号 char(10),
	图书名称 char(30),
	作者 char(20),
	出版社 char(30),
	定价 money,
	购进日期 date,
	购入数 int,
	复本数 int,
	库存数 int
); 
insert into  图书明细表 values 
('I267','99011818','文化苦旅','余秋雨','知识出版社',16,'2000-03-19',8,15,14),
('TP312','00000476','Delphi高级开发指南','坎图','电子工业出版社',80,'2000-03-19',15,15,15),
('U66','01058589','船舶制造基础','杨敏','国防工业出版社',19,'2001-07-15',20,20,20),
('I267','07410139','艺海潮音','李叔','江苏文艺出版社',19,'2007-04-12',15,20,18),
('TP312','07410298','C++程序设计','成颖','东南大学出版社',38,'2007-05-08',10,15,14),
('H31','07410802','航海英语','陈宏权','武汉工业大学出版社',42,'2007-10-20',25,25,24),
('H31','07108667','大学英语学习辅导','姜丽蓉','北京理工大学出版社',23.5,'2008-02-06',25,25,25),
('TP393','07410810','网络工程实用教程','汪新民','北京大学出版社',34.8,'2008-08-21',10,15,15);
```

1)用不同的方法创建约束；2）查看和删除约束；(3）创建、删除默认和规则 (3*5分)

1）掌握主键约束的特点和用法；2）掌握惟一性约束的用法；3）掌握默认约束和默认对象的用法；4）掌握CHECK约束和规则对象的用法；5）掌握利用主键与外键约束实现参照完整性的方法(5*5分)。

创建约束如下：

```sql
create table 读者信息表
(
	借书证号 int primary key, --主码
	姓名 char(10) not null,
	性别 char(2) default '男',
	出生日期 date,
	借书量 smallint CHECK (借书量 between 0 and 100),
	工作单位 char(20),
	电话 char(10),
	Email char(20) 
);
```

1)增加一个字段；2)删除一个字段; 3)增加一个约束; 4)修改字段的数据类型(4*5分)；

```sql
alter table 读者信息表 add QQ int;
alter table 读者信息表 drop column QQ;
alter table 读者信息表 add CONSTRAINT ok1 PRIMARY KEY(QQ);
alter table 读者信息表 alter column QQ VARCHAR(64);
```

1）创建索引；2）重建索引(2*5分)。

```sql
--创建索引
create index index1 on 读者信息表(借书证号);
--重建索引
drop index index1 on 读者信息表;
create index index2 on 读者信息表(借书证号);
```

1）创建视图； 2）删除视图(2*5分)。

```sql
create view view1(qq1,qq2) as
	select 借书证号,姓名 from 读者信息表;
drop view view1;
```

# 二、实验二：SQL 语言与视图

## 2.1 实验目的

（1）掌握SQL 语言的编写。

（2）掌握视图的创建。 

## 2.2 实验内容

本次实验共100分，做对一个给4分。以随机抽查现场做为准

设如下四个表，先创建表， 插入数据， 然后做后面的查询：

student (学生信息表）

sno sname sex birthday class

108 曾华男09/01/77 95033

105 匡明男10/02/75 95031

107 王丽女01/23/76 95033

101 李军男02/20/76 95033

109 王芳女02/10/75 95031

103 陆军男06/03/74 95031

 

teacher(老师信息表）

tno tname sex birthday prof depart

804 李诚男12/02/58 副教授计算机系

856 李旭男03/12/69 讲师电子工程系

825 王萍女05/05/72 助教计算机系

831 刘冰女08/14/77 助教电子工程系

 

course(课程表）

cno cname tno

3-105 计算机导论825

3-245 操作系统804

6-166 数字电路856

9-888 高等数学825

 

score(成绩表）

sno cno degree

103 3-245 86

105 3-245 75

109 3-245 68

103 3-105 92

105 3-105 88

109 3-105 76

101 3-105 64

107 3-105 91

108 3-105 78

101 6-166 85

107 6-166 79

108 6-166 81

创建表的代码如下：

```sql
drop table sc;
drop table student;
drop table teacher;
drop table course;
drop table score;
create table student
(
	sno char(5),
	sname char(5),
	sex char(5),
	birthday date,
	class char(10)
);
insert into student values
('108', '曾华','男','2009-01-07','95033'),
('105', '匡明','男','2010-02-05','95031'),
('107', '王丽','女','2001-03-06','95033'),
('101', '李军','男','2002-10-06','95033'),
('109', '王芳','女','2002-10-05','95031'),
('103' ,'陆军','男','2006-03-04','95031');

create table teacher
(
	tno char(5),
	tname char(5),
	sex char(5),
	birthday date,
	prof char(10),
	depart char(10)
);
insert into teacher values
('804','李诚','男','2012-02-12','副教授','计算机系'),
('856','张旭','男','2003-12-23','讲师','电子工程系'),
('825','王萍','女','2005-05-12','助教','计算机系'),
('831','刘冰','女','2008-09-30','助教','电子工程系');
create table course 
(
cno char(10),
cname char(20),
tno  char(10)
)
insert into  course values
('3-105','计算机导论','825'),
('3-245','操作系统','804'),
('6-166','数字电路','856'),
('9-888','高等数学','825');

create table score
(
sno char(10),
cno char(10),
degree int
);
insert into  score values
('03','3-245',86),
('105','3-245',75),
('109','3-245',68),
('103','3-105',92),
('105','3-105',88),
('109','3-105',76),
('101','3-105',64),
('107','3-105',91),
('108','3-105',78),
('101','6-166',85),
('107','6-166',79),
('108','6-166',81);
```

请写出下列查询语句并给出结果：

1、列出student表中所有记录的sname、sex和class列。

```sql
select sname,sex,class from student;
```

2、显示教师所有的单位即不重复的depart列。

```sql
select distinct depart from teacher;
```

3、显示学生表的所有记录。

```sql
select * from student;
```

4、显示score表中成绩在60到80之间的所有记录。

```sql
select * from score where degree>=60 and degree <= 80;
```

5、显示score表中成绩为85，86或88的记录。

```sql
select * from score where degree in (85, 86, 88);
```

6、显示student表中“95031”班或性别为“女”的同学记录。

```sql
select * from student where class='95031' or sex='女';
```

7、以class降序显示student表的所有记录。

```sql
select * from student order by class DESC;
```

8、以cno升序、degree降序显示score表的所有记录。

```sql
select * from score order by cno ASC,degree DESC;
```

9、显示“98031”班的学生人数。

```sql
select count(*) from student where class='95031';
```

10、显示score表中的最高分的学生学号和课程号。

```sql
select sno,cno from score where degree = (select max(degree) from score);
```

11、显示“3-105”号课程的平均分。

```sql
select avg(degree) from score where cno = '3-105';
```

12、显示score表中至少有5名学生选修的并以3开头的课程号的平均分数。

```sql
select avg(degree) from score where cno like '3%' group by cno having count(sno)>=5;
```

13、显示最低分大于70，最高分小于90 的sno列。

```sql
select sno from score group by sno having min(degree)>70 and max(degree)<90;
```

14、显示所有学生的 sname、 cno和degree列。

```sql
select sname,cno,degree from score,student where score.sno = student.sno;
```

15、显示所有学生的 sname、 cname和degree列。

```sql
select sname,cname,degree from score,course,student where score.sno = student.sno
and course.cno = score.cno;
```

16、列出“95033”班所选课程的平均分。

```sql
select cno,avg(degree) 平均分 from score,student where student.sno = 
score.sno and student.class = '95033' group by cno;
```

17、显示选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。

```sql
select * from score where cno = '3-105' and degree > (select degree from score 
where cno ='3-105' and sno = '109');
```

18、显示score中选修多门课程的同学中分数为非最高分成绩的记录。

```sql
select a.sno,a.cno,a.degree from score a,score b where a.sno=b.sno and a.degree<b.degree;
```

19、显示成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。

```sql
select * from score where degree>(select degree from score where sno = '109' and cno = '3-105');
```

20、显示出和学号为“108”的同学同年出生的所有学生的sno、sname和 birthday列。

```sql
select sno,sname,birthday from student where year(birthday) = (select year(birthday) from student where sno='108');
```

21、显示“张旭”老师任课的学生成绩。

```sql
select * from score where cno in (select cno from course where tno in (select tno from teacher where tname = '张旭'));
```

22、显示选修某课程的同学人数多于5人的老师姓名。

```sql
select tname from teacher where tno in (select tno from course where cno in (select cno from score group by cno having count(*)>=5))
```

23、显示“95033”班和“95031”班全体学生的记录。

```sql
select * from student where class in ('95033','95031');
```

24、显示存在有85分以上成绩的课程cno。

```sql
select distinct cno from score where degree in (select degree from score where degree >85);
```

25、显示“计算机系”老师所教课程的成绩表。

```sql
select * from score where cno in (select cno from course where tno in (select tno from teacher where depart = '计算机系'))
```

26、显示“计算机系”和“电子工程系”不同职称的老师的tname和prof。

```sql
select tname,prof from teacher where prof not in 
(select prof from teacher where depart ='电子工程系') and depart = '计算机系';
```

27、显示选修编号为“3-105”课程且成绩至少高于“3-245”课程的同学的cno、sno和degree，并按degree从高到低次序排列。

```sql
select cno,sno,degree from score where cno = '3-105' and degree > any(select 
degree from score where cno = '3-245')  order by degree desc;
```

28、显示选修编号为“3-105”课程且成绩高于“3-245”课程的同学的cno、sno和degree。

```sql
select cno,sno,degree from score where cno = '3-105' and degree > all(select 
degree from score where cno = '3-245');
```

29、列出所有任课老师的tname和depart。

```sql
select tname,depart from teacher where tno in (select tno from course);
```

30、列出所有未讲课老师的tname和depart。

```sql
select tname,depart from teacher where tno not in (select tno from course);
```

31、列出所有老师和同学的 姓名、性别和生日。

```sql
select tname,sex,birthday from teacher union select sname,sex,birthday from student;
```

*32、检索所学课程包含学生“103”所学课程的学生学号。

```sql
Select distinct sno  from score x
Where not exists
    (select * from score y
        where y.sno=103 and 
           not exists
             (select * from score z
                 where z.sno=x.sno and z.cno=y.cno)); 
```

*33、检索选修所有课程的学生姓名。

```sql
select student.sname from student where not exists (select *  from  course 
     where not exists 
          ( select * from  score where
      student.sno=score.sno and cource.cno=score.cno));
```

# 三、实验三：存储过程、触发器、函数

## 3.1 实验目的

掌握存储过程、触发器、函数的创建及应用。

## 3.2 实验内容

1、创建一个查询图书库存量的存储过程“cx_tskcl_proc”，输出的内容包含类别号、图书编号、图书名称、库存数等数据内容。

```sql
create procedure cx_tskcl_proc as
	select 类别号,图书编号,图书名称,库存数 from 图书明细表
exec cx_tskcl_proc;
```

2、创建一个名为TS_CX_PROC的存储过程，它带有一个输入参数，用于接受图书编号，显示该图书的名称、作者、出版和复本数。

```sql
create procedure TS_CX_PROC
	@id char(10) 
as
	select 图书名称,作者,出版社,复本数 from 图书明细表 where @id = 图书编号
exec TS_CX_PROC '00000476';
```

3、修改存储：修改TS_CX_PROC存储过程，使之能按图书名称查询图书的相关信息。

执行修改后的TS_CX_PROC存储过程，分别查询“航海英语”、“艺海潮音”等图书的信息。

```sql
alter procedure TS_CX_PROC
	@name char(30)
as
	select 图书名称,作者,出版社,复本数 from 图书明细表 where @name = 图书名称
exec TS_CX_PROC '航海英语';
exec TS_CX_PROC '艺海潮音';
```

4、删除存储过程

```sql
drop procedure TS_CX_PROC;
```

5、图书类别表上创建一个名为tslb_insert_trigger的触发器，当执行INSERT操作时，该触发器被触发，禁止插入记录。

```sql
create trigger tslb_insert_trigger on 图书类别 for insert
as
   if exists(select * from inserted)
	rollback;
insert into 图书类别 values('a','编译原理');
```

6、在图书明细表上创建一个名为ts_delete_trigger的触发器，当执行DELETE操作时，该触发器被触发，禁止删除记录。

```sql
create trigger ts_delete_trigger on 图书明细表 for delete
as
  if exists(select * from deleted)
	rollback;
delete from 图书明细表 where 图书名称 = '艺海潮音';
```

7、在读者信息表上创建一个名为dzxx_insert_trigger的触发器，当在读者信息表中插入记录时，将该记录中的借书证号自动插入借还明细表中。

```sql
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
```

8、删除触发器

```sql
drop trigger tslb_insert_trigger;
drop trigger ts_delete_trigger;
drop trigger dzxx_insert_trigger;
```

# 四、心得体会

​		通过本次《数据库原理》实验，让我更好的了解了课上所学的关于数据表、索引、视图的创建、删除的设计及完整性约束设计，并熟悉了SQL语言的语法（包括插入、删除、更新等操作），掌握了存储过程、触发器、函数的知识，能够把课内数据库所学的内容运用到实际工程场景中，体会到数据库的重要性所在。本次实验收获颇丰，今后我将继续学习数据库的相关知识，努力提高专业能力，继续探索，继续进步。