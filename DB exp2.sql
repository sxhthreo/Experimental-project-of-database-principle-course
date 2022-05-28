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
('108', '����','��','2009-01-07','95033'),
('105', '����','��','2010-02-05','95031'),
('107', '����','Ů','2001-03-06','95033'),
('101', '���','��','2002-10-06','95033'),
('109', '����','Ů','2002-10-05','95031'),
('103' ,'½��','��','2006-03-04','95031');

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
('804','���','��','2012-02-12','������','�����ϵ'),
('856','����','��','2003-12-23','��ʦ','���ӹ���ϵ'),
('825','��Ƽ','Ů','2005-05-12','����','�����ϵ'),
('831','����','Ů','2008-09-30','����','���ӹ���ϵ');
create table course 
(
cno char(10),
cname char(20),
tno  char(10)
)
insert into  course values
('3-105','���������','825'),
('3-245','����ϵͳ','804'),
('6-166','���ֵ�·','856'),
('9-888','�ߵ���ѧ','825');

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
select sname,sex,class from student;
select * from student where class='95031' or sex='Ů';
--1��	�г�student�������м�¼��sname��sex��class�С�
select sname,sex,class from student;
--2��	��ʾ��ʦ���еĵ�λ�����ظ���depart�С�
select distinct depart from teacher;
--3��	��ʾѧ��������м�¼��
select * from student;
--4��	��ʾscore���гɼ���60��80֮������м�¼��
select * from score where degree>=60 and degree <= 80;
--5��	��ʾscore���гɼ�Ϊ85��86��88�ļ�¼��
select * from score where degree in (85, 86, 88);
--6��	��ʾstudent���С�95031������Ա�Ϊ��Ů����ͬѧ��¼��
select * from student where class='95031' or sex='Ů';
--7����class������ʾstudent������м�¼��
select * from student order by class DESC;
--8����cno����degree������ʾscore������м�¼��
select * from score order by cno ASC,degree DESC;
--9����ʾ��98031�����ѧ��������
select count(*) from student where class='95031';
--10����ʾscore���е���߷ֵ�ѧ��ѧ�źͿγ̺š�
select sno,cno from score where degree = (select max(degree) from score);
--11����ʾ��3-105���ſγ̵�ƽ���֡�
select avg(degree) from score where cno = '3-105';
--12����ʾscore����������5��ѧ��ѡ�޵Ĳ���3��ͷ�Ŀγ̺ŵ�ƽ��������
select avg(degree) from score where cno like '3%' group by cno having count(sno)>=5;
--13����ʾ��ͷִ���70����߷�С��90 ��sno�С�
select sno from score group by sno having min(degree)>70 and max(degree)<90;
--14����ʾ����ѧ���� sname�� cno��degree�С�
select sname,cno,degree from score,student where score.sno = student.sno;
--15����ʾ����ѧ���� sname�� cname��degree�С�
select sname,cname,degree from score,course,student where score.sno = student.sno
and course.cno = score.cno;
--16���г���95033������ѡ�γ̵�ƽ���֡�
select cno,avg(degree) ƽ���� from score,student where student.sno = 
score.sno and student.class = '95033' group by cno;
--17����ʾѡ�ޡ�3-105���γ̵ĳɼ����ڡ�109����ͬѧ�ɼ�������ͬѧ�ļ�¼��
select * from score where cno = '3-105' and degree > (select degree from score 
where cno ='3-105' and sno = '109');
--18����ʾscore��ѡ�޶��ſγ̵�ͬѧ�з���Ϊ����߷ֳɼ��ļ�¼��
select a.sno,a.cno,a.degree from score a,score b where a.sno=b.sno and a.degree<b.degree;
--19����ʾ�ɼ�����ѧ��Ϊ��109�����γ̺�Ϊ��3-105���ĳɼ������м�¼��
select * from score where degree>(select degree from score where sno = '109' and cno = '3-105');
--20����ʾ����ѧ��Ϊ��108����ͬѧͬ�����������ѧ����sno��sname�� birthday�С�
select sno,sname,birthday from student where year(birthday) = (select year(birthday) from student where sno='108');
--21����ʾ��������ʦ�οε�ѧ���ɼ���
select * from score where cno in (select cno from course where tno in (select tno from teacher where tname = '����'));
--22����ʾѡ��ĳ�γ̵�ͬѧ��������5�˵���ʦ������
select tname from teacher where tno in (select tno from course where cno in (select cno from score group by cno having count(*)>=5))
--23����ʾ��95033����͡�95031����ȫ��ѧ���ļ�¼��
select * from student where class in ('95033','95031');
--24����ʾ������85�����ϳɼ��Ŀγ�cno��
select distinct cno from score where degree in (select degree from score where degree >85);
--25����ʾ�������ϵ����ʦ���̿γ̵ĳɼ���
select * from score where cno in (select cno from course where tno in (select tno from teacher where depart = '�����ϵ'))
--26����ʾ�������ϵ���͡����ӹ���ϵ����ְͬ�Ƶ���ʦ��tname��prof��
select tname,prof from teacher where prof not in 
(select prof from teacher where depart ='���ӹ���ϵ') and depart = '�����ϵ';
--27����ʾѡ�ޱ��Ϊ��3-105���γ��ҳɼ����ٸ��ڡ�3-245���γ̵�ͬѧ��cno��sno��degree������degree�Ӹߵ��ʹ������С�
select cno,sno,degree from score where cno = '3-105' and degree > any(select 
degree from score where cno = '3-245')  order by degree desc;
--28����ʾѡ�ޱ��Ϊ��3-105���γ��ҳɼ����ڡ�3-245���γ̵�ͬѧ��cno��sno��degree��
select cno,sno,degree from score where cno = '3-105' and degree > all(select 
degree from score where cno = '3-245');
--29���г������ο���ʦ��tname��depart��
select tname,depart from teacher where tno in (select tno from course);
--30���г�����δ������ʦ��tname��depart��
select tname,depart from teacher where tno not in (select tno from course);
--31���г�������ʦ��ͬѧ�� �������Ա�����ա�
select tname,sex,birthday from teacher union select sname,sex,birthday from student;
--*32��������ѧ�γ̰���ѧ����103����ѧ�γ̵�ѧ��ѧ�š�
Select distinct sno  from score x
Where not exists
    (select * from score y
        where y.sno=103 and 
           not exists
             (select * from score z
                 where z.sno=x.sno and z.cno=y.cno)); 
--*33������ѡ�����пγ̵�ѧ��������
select student.sname from student where not exists (select *  from  course 
     where not exists 
          ( select * from  score where
      student.sno=score.sno and cource.cno=score.cno));