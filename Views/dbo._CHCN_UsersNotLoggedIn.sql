SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[_CHCN_UsersNotLoggedIn]
AS
SELECT     dbo.vw_aspnet_Users.UserId AS UserID1, dbo.UserPortals.UserId AS UserID2, dbo.vw_aspnet_Users.UserName, dbo.Users.FirstName, 
                      dbo.Users.LastName, dbo.Users.Email, dbo._CHCN_COMPANY_VS.Company, dbo._CHCN_COMPANY_VS.CompanyID, 
                      dbo.vw_aspnet_MembershipUsers.CreateDate, dbo.vw_aspnet_MembershipUsers.LastLoginDate, dbo.vw_aspnet_Users.LastActivityDate, 
                      dbo.UserPortals.Authorised
FROM         dbo.vw_aspnet_Users RIGHT OUTER JOIN
                      dbo.Users INNER JOIN
                      dbo.UserPortals ON dbo.Users.UserID = dbo.UserPortals.UserId LEFT OUTER JOIN
                      dbo._CHCN_COMPANY_VS ON dbo.Users.UserID = dbo._CHCN_COMPANY_VS.UserID ON 
                      dbo.vw_aspnet_Users.UserName = dbo.Users.Username LEFT OUTER JOIN
                      dbo.vw_aspnet_MembershipUsers ON dbo.vw_aspnet_Users.UserName = dbo.vw_aspnet_MembershipUsers.UserName
WHERE     (dbo.UserPortals.Authorised = 1) AND (dbo.vw_aspnet_MembershipUsers.CreateDate = dbo.vw_aspnet_MembershipUsers.LastLoginDate)

GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[32] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vw_aspnet_Users"
            Begin Extent = 
               Top = 7
               Left = 411
               Bottom = 122
               Right = 582
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 16
               Left = 661
               Bottom = 207
               Right = 823
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "UserPortals"
            Begin Extent = 
               Top = 157
               Left = 205
               Bottom = 272
               Right = 357
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "_CHCN_COMPANY_VS"
            Begin Extent = 
               Top = 127
               Left = 433
               Bottom = 238
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_aspnet_MembershipUsers"
            Begin Extent = 
               Top = 2
               Left = 0
               Bottom = 146
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1845
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
', 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_UsersNotLoggedIn', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_UsersNotLoggedIn', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_UsersNotLoggedIn', NULL, NULL
GO
