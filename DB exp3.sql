--1������һ����ѯͼ�������Ĵ洢���̡�cx_tskcl_proc������������ݰ������š�ͼ���š�ͼ�����ơ���������������ݡ�
create procedure cx_tskcl_proc as
	select ����,ͼ����,ͼ������,����� from ͼ����ϸ��
exec cx_tskcl_proc;
--2������һ����ΪTS_CX_PROC�Ĵ洢���̣�������һ��������������ڽ���ͼ���ţ���ʾ��ͼ������ơ����ߡ�����͸�������
create procedure TS_CX_PROC
	@id char(10) 
as
	select ͼ������,����,������,������ from ͼ����ϸ�� where @id = ͼ����
exec TS_CX_PROC '00000476';
--3���޸Ĵ洢
--�޸�TS_CX_PROC�洢���̣�ʹ֮�ܰ�ͼ�����Ʋ�ѯͼ��������Ϣ��
alter procedure TS_CX_PROC
	@name char(30)
as
	select ͼ������,����,������,������ from ͼ����ϸ�� where @name = ͼ������
--ִ���޸ĺ��TS_CX_PROC�洢���̣��ֱ��ѯ������Ӣ������պ���������ͼ�����Ϣ��
exec TS_CX_PROC '����Ӣ��';
exec TS_CX_PROC '�պ�����';
--4��ɾ���洢����
drop procedure TS_CX_PROC;
--5��ͼ�������ϴ���һ����Ϊtslb_insert_trigger�Ĵ���������ִ��INSERT����ʱ���ô���������������ֹ�����¼��
create trigger tslb_insert_trigger on ͼ����� for insert
as
   if exists(select * from inserted)
	rollback;
insert into ͼ����� values('a','����ԭ��');
--6����ͼ����ϸ���ϴ���һ����Ϊts_delete_trigger�Ĵ���������ִ��DELETE����ʱ���ô���������������ֹɾ����¼��
create trigger ts_delete_trigger on ͼ����ϸ�� for delete
as
  if exists(select * from deleted)
	rollback;
delete from ͼ����ϸ�� where ͼ������ = '�պ�����';
--7���ڶ�����Ϣ���ϴ���һ����Ϊdzxx_insert_trigger�Ĵ����������ڶ�����Ϣ���в����¼ʱ�����ü�¼�еĽ���֤���Զ�����軹��ϸ���С�
create trigger dzxx_insert_trigger on ������Ϣ�� for insert
as
	declare @borrow char(10);
	if exists(select * from inserted)
	begin
		select @borrow = ����֤�� from inserted;
		insert into �軹��ϸ��(����֤��) values (@borrow);
	end
insert into ������Ϣ�� values('1','Ǯ����','��','2001-11-30',1,'����ռ䰲ȫϵ','13080519036','828@csu.edu.cn');
select * from ������Ϣ�� where ���� = 'Ǯ����';
select * from �軹��ϸ��;
--8��ɾ��������
drop trigger tslb_insert_trigger;
drop trigger ts_delete_trigger;
drop trigger dzxx_insert_trigger;