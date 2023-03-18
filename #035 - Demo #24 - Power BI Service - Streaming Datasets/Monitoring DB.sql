USE [master]
GO
CREATE DATABASE [Monitoring]
GO
USE [Monitoring]
GO
CREATE TABLE [dbo].[Resources](
	[LogDate] [datetime] NULL,
	[DomainName] [nvarchar](30) NULL,
	[ComputerName] [nvarchar](30) NULL,
	[IPAddress] [nvarchar](30) NULL,
	[CPU] [float] NULL,
	[TotalMemory] [float] NULL,
	[FreeMemory] [float] NULL,
	[Memory] [float] NULL,
	[Drives] [nvarchar](max) NULL
)
