 --1
 
-- A) Elements
SELECT * FROM HumanResources.Employee
FOR XML RAW('Employee'), ELEMENTS, ROOT('Employees')

-- B) Attributes
SELECT * FROM HumanResources.Employee
FOR XML AUTO, ROOT('Employees')

--2
--XML Row
select e.Ins_Name,d.Dept_Name
from Instructor e join Department d on e.Dept_Id=d.Dept_Id
for xml raw('manger')  , ELEMENTS  , Root('Instructor_mangers') 

--xml path
select  d.Dept_Id "department/@id",
	   d.Dept_Name "department/name",
	   i.Ins_Name "department/manger_name"
from Department d join Instructor i on d.Dept_Id=i.Dept_Id 
for xml path('instructor_manger')




--3 
CREATE TABLE [dbo].[ahmeds20](
	[firstname] [varchar](50) NULL,
	[zip_code] int NULL,
	[order] [varchar](50) NULL,
	[id] int NULL
) ON [PRIMARY]
GO

declare @docs xml =
'<customers>
<customer FirstName="Bob" Zipcode="91126">
<order ID="12221">Laptop</order>
</customer>
<customer FirstName="Judy" Zipcode="23235">
<order ID="12221">Workstation</order>
</customer>
<customer FirstName="Howard" Zipcode="20009">
<order ID="3331122">Laptop</order>
</customer>
<customer FirstName="Mary" Zipcode="12345">
<order ID="555555">Server</order>
</customer>
</customers> '
declare @hdocs INT
Exec sp_xml_preparedocument @hdocs output, @docs;
insert into ahmeds20(firstname,zip_code,id,[order])
select * from OPENXML (@hdocs, '//customer')  
WITH (
        first_name varchar(50) '@FirstName',
	     zip_code int '@Zipcode',
	         id int 'order/@ID'  ,
	         orderr varchar(30) 'order' 
	  )
	
	  
--4
create   clustered index c10 on [HumanResources].[EmployeeDepartmentHistory] (StartDate)


--5
create unique index c20 on [dbo].[Student] ([St_Age])
--6
create nonclustered index c30 on[dbo].[Department]([Manager_hiredate])

--7

DECLARE c1 cursor 
for 
  select St_Id , St_Fname
  from Student 
for READ ONLY
declare @id int , @name varchar(200),@curent int ,@count int 
OPEN c1
FETCH c1 into @id , @name
set @count=0
while @@fetch_status = 0 
begin 
if(@name='ahmed')
set @curent=@id
if(@name='khalid' and @curent=@id-1)
set @count+=1
FETCH c1 into @id , @name
end 
select @count as 'ahmed after khalid'
close c1
DEALLOCATE c1