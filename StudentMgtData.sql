USE [master]
GO
/****** Object:  Database stmgt    Script Date: 01/04/2019 15:13:51 ******/
CREATE DATABASE stmgt
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'stmgt', FILENAME = N'D:\Temp\stmgt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'stmgt_log', FILENAME = N'D:\Temp\stmgt_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE stmgt SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC stmgt.[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE stmgt SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE stmgt SET ANSI_NULLS OFF 
GO
ALTER DATABASE stmgt SET ANSI_PADDING OFF 
GO
ALTER DATABASE stmgt SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE stmgt SET ARITHABORT OFF 
GO
ALTER DATABASE stmgt SET AUTO_CLOSE OFF 
GO
ALTER DATABASE stmgt SET AUTO_SHRINK OFF 
GO
ALTER DATABASE stmgt SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE stmgt SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE stmgt SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE stmgt SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE stmgt SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE stmgt SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE stmgt SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE stmgt SET  DISABLE_BROKER 
GO
ALTER DATABASE stmgt SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE stmgt SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE stmgt SET TRUSTWORTHY OFF 
GO
ALTER DATABASE stmgt SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE stmgt SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE stmgt SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE stmgt SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE stmgt SET RECOVERY SIMPLE 
GO
ALTER DATABASE stmgt SET  MULTI_USER 
GO
ALTER DATABASE stmgt SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE stmgt SET DB_CHAINING OFF 
GO
ALTER DATABASE stmgt SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE stmgt SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE stmgt SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE stmgt SET QUERY_STORE = OFF
GO
USE stmgt
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE stmgt
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 01/04/2019 15:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[idClass] [int] NOT NULL,
	[idLecturer] [int] NOT NULL,
	[idSubject] [int] NOT NULL,
	[TaughtYear] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[idClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 01/04/2019 15:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[idDept] [int] NOT NULL,
	[DeptName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[idDept] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrolment]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrolment](
	[idClass] [int] NOT NULL,
	[idStudent] [int] NOT NULL,
	[idStatus] [int] NULL,
	[GradePoint] [real] NULL,
 CONSTRAINT [PK_Enrolment] PRIMARY KEY CLUSTERED 
(
	[idClass] ASC,
	[idStudent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[idGender] [int] NOT NULL,
	[Sex] [nvarchar](50) NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[idGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturers](
	[idLecturer] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Lecturers] PRIMARY KEY CLUSTERED 
(
	[idLecturer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StdTitles]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StdTitles](
	[idTitle] [int] NOT NULL,
	[Year] [int] NULL,
	[StudentTitle] [nvarchar](50) NULL,
 CONSTRAINT [PK_StdTitles] PRIMARY KEY CLUSTERED 
(
	[idTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[idStudent] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[idGender] [int] NULL,
	[idDept] [int] NULL,
	[idTitle] [int] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[idStudent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[idSubject] [int] NOT NULL,
	[SubjectName] [nvarchar](50) NULL,
	[idDept] [int] NULL,
	[idTitle] [int] NULL,
	[Credits] [int] NULL,
 CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED 
(
	[idSubject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheSchool]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheSchool](
	[SchoolName] [nchar](250) NOT NULL,
	[BaseYear] [int] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_TheSchool] PRIMARY KEY CLUSTERED 
(
	[SchoolName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Lecturers] FOREIGN KEY([idLecturer])
REFERENCES [dbo].[Lecturers] ([idLecturer])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Lecturers]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Subjects] FOREIGN KEY([idSubject])
REFERENCES [dbo].[Subjects] ([idSubject])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Subjects]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Departments] FOREIGN KEY([idDept])
REFERENCES [dbo].[Departments] ([idDept])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Departments]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Genders] FOREIGN KEY([idGender])
REFERENCES [dbo].[Genders] ([idGender])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Genders]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_StdTitles] FOREIGN KEY([idTitle])
REFERENCES [dbo].[StdTitles] ([idTitle])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_StdTitles]
GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Subjects_Departments] FOREIGN KEY([idDept])
REFERENCES [dbo].[Departments] ([idDept])
GO
ALTER TABLE [dbo].[Subjects] CHECK CONSTRAINT [FK_Subjects_Departments]
GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Subjects_StdTitles] FOREIGN KEY([idTitle])
REFERENCES [dbo].[StdTitles] ([idTitle])
GO
ALTER TABLE [dbo].[Subjects] CHECK CONSTRAINT [FK_Subjects_StdTitles]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateDepartmentData]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_CreateDepartmentData] 
	@MaxDept int
as
	declare @id int
	declare @idStr varchar(50)

	set @id = 1

	while @id <= @MaxDept
	begin
		set @idStr = cast(@id as varchar)
		insert into dbo.Departments
		values (@id, 'Dept ' + @idStr)
		set @id = @id + 1
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateStudentData]    Script Date: 01/04/2019 15:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_CreateStudentData]
	@MaxStudent int
as
	/*
	begin
		execute ('delete dbo.Students');
	end
	*/

	declare @id int
	declare @idStr varchar(50)
	declare @idDept int
	declare @maxDept int
	
	set @idDept = 1
	
	set @maxDept = (select count(*) from dbo.Departments)
	while @idDept <= @maxDept
	begin
		set @id = 1
		while @id <= @MaxStudent 
		begin
			set @idStr = cast(@id as varchar)
			insert into stmgt.dbo.Students
			values ((@idDept-1)*1500 + @id, 'First ' + @idStr, 'Middle ' + @idStr, 'Last ' + @idStr, 1, @idDept)
			set @id = @id + 1
		end
	
		set @idDept = @idDept + 1
	end
GO
USE [master]
GO
ALTER DATABASE stmgt SET  READ_WRITE 
GO
