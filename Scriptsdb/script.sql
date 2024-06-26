USE [master]
GO
/****** Object:  Database [EMPLEADOS_DB]    Script Date: 13/12/2021 1:12:47 ******/
CREATE DATABASE [EMPLEADOS_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EMPLEADOS_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EMPLEADOS_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EMPLEADOS_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EMPLEADOS_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EMPLEADOS_DB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EMPLEADOS_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EMPLEADOS_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EMPLEADOS_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EMPLEADOS_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EMPLEADOS_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EMPLEADOS_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EMPLEADOS_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EMPLEADOS_DB] SET  MULTI_USER 
GO
ALTER DATABASE [EMPLEADOS_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EMPLEADOS_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EMPLEADOS_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EMPLEADOS_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EMPLEADOS_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EMPLEADOS_DB] SET QUERY_STORE = OFF
GO
USE [EMPLEADOS_DB]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[Dni] [char](8) NOT NULL,
	[Apellido] [varchar](25) NULL,
	[Nombre] [varchar](25) NULL,
	[Calle] [varchar](50) NULL,
	[CalleNro] [varchar](6) NULL,
	[Depto] [varchar](15) NULL,
	[Piso] [varchar](8) NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[Dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteEmpleado]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernán Lazarte>
-- Create date: <13/12/2021>
-- Description:	<Borra un empleado>
-- =============================================
create procedure [dbo].[SP_DeleteEmpleado](@dni char(8))
as 
begin
	delete from Empleados where Dni=@dni
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllEmpleados]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernán Lazarte>
-- Create date: <13/12/2021>
-- Description:	<Trae todos los empleados de la tabla>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllEmpleados] 
AS
BEGIN
	SELECT * from Empleados
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmpleadosBusqueda]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernán Lazarte>
-- Create date: <13/12/2021>
-- Description:	<Filtra los empleados por Apellido, Nombre o Dni>
-- =============================================
CREATE procedure [dbo].[SP_GetEmpleadosBusqueda](@busqueda varchar(50))
AS
BEGIN
	select * from Empleados where
	trim(Dni) like '%'+trim(@busqueda)+'%' or
	trim(upper(Nombre)) like '%'+trim(upper(@busqueda))+'%' or 
	trim(upper(Apellido)) like '%'+trim(upper(@busqueda))+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertEmpleado]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernán Lazarte>
-- Create date: <13/12/2021>
-- Description:	<Inserta un empleado>
-- =============================================
create procedure [dbo].[SP_InsertEmpleado]
(@dni char(8), @apellido varchar(25), 
@nombre varchar(25), @calle varchar(50),
@callenro varchar(6), @depto varchar(15),
@piso varchar(8))
as 
begin
insert into Empleados (Dni, Apellido, Nombre, Calle, 
CalleNro, Depto, Piso)
values
(@dni, @apellido, @nombre, @calle, @callenro, @depto,
@piso)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateEmpleado]    Script Date: 13/12/2021 1:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernán Lazarte>
-- Create date: <13/12/2021>
-- Description:	<Modifica un empleado>
-- =============================================
CREATE procedure [dbo].[SP_UpdateEmpleado]
	(@apellido varchar(25), 
	@nombre varchar(25), @calle varchar(50),
	@callenro varchar(6), @depto varchar(15),
	@piso varchar(8), @dni char(8))
AS
BEGIN
	update Empleados set Apellido=@apellido,
	Nombre=@nombre, Calle=@calle, 
	CalleNro=@callenro, Depto=@depto, Piso=@piso where Dni=@dni
END
GO
USE [master]
GO
ALTER DATABASE [EMPLEADOS_DB] SET  READ_WRITE 
GO
