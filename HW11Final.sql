if OBJECT_ID('DBObjects') is not null begin
Drop database DBObjects
end
go

create database DBObjects
go

use DBObjects
go

Create Table Employees(
ID nvarchar(40) not null Primary Key,
BadgeNum INT NOT NULL UNIQUE,
SSN int NOT NULL,
Title varchar(20) null,
DATEHired DateTime2 not null Default GetDate()
);

create trigger dbo.EmpTitle on Employees
after insert as
update Employees
set title =
	case
	when BadgeNum >= 0 and BadgeNum <= 300 then 'Clerk'
	when BadgeNum > 300 and BadgeNum <=699 then 'Office Employee'
	when BadgeNum >= 700 and BadgeNum <=899 then 'Manager'
	when BadgeNum >= 900 and BadgeNum <= 1000 then 'Director'
END
		 
declare @Random int;
declare @GUID_ID nvarchar(40);
Declare @User_SSN int;

declare @num int = 1;
while @num <= 25
BEGIN
	set @Random = Cast(Rand()*1000 as int);
	set @User_SSN = Cast(Rand()*999999999 as int);
	set @GUID_ID = NEWID();
	insert into dbo.Employees(ID, BadgeNum, SSN, Title, DATEHired) values (@Guid_ID, @random, @User_SSN, null, GETDATE());
	set @num = @num + 1;
END

Declare @ID nvarchar;
declare @Badgenum int;
declare @SSN int;
Declare @Title varchar(20);
Declare @DateHIred Datetime2;

Declare cu_Employees Cursor FAST_FORWARD FOR 
		Select ID, BadgeNum, SSN, Title, DateHired
		from dbo.Employees;

open cu_employees;

Fetch next from cu_employees into @ID, @Badgenum, @Title;

WHILE @@FETCH_STATUS = 0 Begin
	Print @ID;
	Print @BAdgenum;
	--Print @SSN;
	Print @Title;
	--Print @DateHired;

	Fetch next from cu_employees into @ID, @Badgenum, @Title;
END

Close cu_employees;
Deallocate cu_employees;

create view vw_EmployeesView
as 
Select ID, Badgenum, Title
from dbo.Employees

Select * from vw_EmployeesView;

set ANSI_WARNINGS OFF;
