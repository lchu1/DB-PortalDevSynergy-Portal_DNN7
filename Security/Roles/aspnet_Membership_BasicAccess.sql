CREATE ROLE [aspnet_Membership_BasicAccess]
AUTHORIZATION [DNN_USER_OLD]
GO
EXEC sp_addrolemember N'aspnet_Membership_BasicAccess', N'aspnet_Membership_FullAccess'
GO
