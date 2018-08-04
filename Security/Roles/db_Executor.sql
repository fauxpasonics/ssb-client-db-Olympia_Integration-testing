CREATE ROLE [db_Executor]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'db_Executor', N'svcLogi'
GO
GRANT EXECUTE TO [db_Executor]
