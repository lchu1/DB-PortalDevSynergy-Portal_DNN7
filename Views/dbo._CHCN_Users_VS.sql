SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[_CHCN_Users_VS]
AS
SELECT        dbo._CHCN_COMPANY_VS.CompanyID, dbo._CHCN_COMPANY_VS.Company, dbo.Users.Username, dbo.Users.LastName, dbo.Users.FirstName, dbo.Users.Email, 
                         dbo.UserPortals.CreatedDate AS CreateDate, CONVERT(char(10), dbo.aspnet_Users.LastActivityDate, 101) AS LastLoginDate, 
                         CASE WHEN UserPortals.Authorised = '1' THEN 'YES' ELSE 'NO' END AS Authorized, CASE WHEN Claims.RoleID IS NULL THEN '' ELSE 'X' END AS Claims, 
                         CASE WHEN Auths.RoleID IS NULL THEN '' ELSE 'X' END AS Auths, CASE WHEN Elig.RoleID IS NULL THEN '' ELSE 'X' END AS Elig, 
                         CASE WHEN EOB.RoleID IS NULL THEN '' ELSE 'X' END AS EOB, CASE WHEN CapDown.RoleID IS NULL THEN '' ELSE 'X' END AS Cap, 
                         CASE WHEN Edown.RoleID IS NULL THEN '' ELSE 'X' END AS EligDownload, CASE WHEN AuthReq.RoleID IS NULL THEN '' ELSE 'X' END AS AuthReq,
                             (SELECT        COUNT(UserID) AS Expr1
                               FROM            dbo.UrlLog
                               WHERE        (UserID = dbo.Users.UserID)) AS Views
FROM            dbo.Users LEFT OUTER JOIN
                         dbo.UserRoles AS CapDown ON dbo.Users.UserID = CapDown.UserID AND CapDown.RoleID = '116' LEFT OUTER JOIN
                         dbo.UserRoles AS EDown ON dbo.Users.UserID = EDown.UserID AND EDown.RoleID = '85' LEFT OUTER JOIN
                         dbo.UserRoles AS Elig ON dbo.Users.UserID = Elig.UserID AND Elig.RoleID = '91' LEFT OUTER JOIN
                         dbo.UserRoles AS Claims ON dbo.Users.UserID = Claims.UserID AND Claims.RoleID = '90' LEFT OUTER JOIN
                         dbo.UserRoles AS Auths ON dbo.Users.UserID = Auths.UserID AND Auths.RoleID = '88' LEFT OUTER JOIN
                         dbo.UserRoles AS EOB ON dbo.Users.UserID = EOB.UserID AND EOB.RoleID = '86' LEFT OUTER JOIN
                         dbo.UserRoles AS AuthReq ON dbo.Users.UserID = AuthReq.UserID AND AuthReq.RoleID = '89' LEFT OUTER JOIN
                         dbo.UserPortals ON dbo.Users.UserID = dbo.UserPortals.UserId LEFT OUTER JOIN
                         dbo._CHCN_COMPANY_VS ON dbo.Users.UserID = dbo._CHCN_COMPANY_VS.UserID LEFT OUTER JOIN
                         dbo.aspnet_Users ON dbo.Users.Username = dbo.aspnet_Users.UserName
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[7] 2[46] 3) )"
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
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CapDown"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 121
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EDown"
            Begin Extent = 
               Top = 6
               Left = 486
               Bottom = 121
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Elig"
            Begin Extent = 
               Top = 6
               Left = 710
               Bottom = 121
               Right = 896
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Claims"
            Begin Extent = 
               Top = 6
               Left = 934
               Bottom = 121
               Right = 1120
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Auths"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EOB"
            Begin Extent = 
               Top = 126
               Left = 262
               Bottom = 241
               Right = 448
            End
            DisplayFlags = 280
            TopCol', 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_Users_VS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'umn = 0
         End
         Begin Table = "AuthReq"
            Begin Extent = 
               Top = 126
               Left = 486
               Bottom = 241
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserPortals"
            Begin Extent = 
               Top = 126
               Left = 710
               Bottom = 241
               Right = 862
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "_CHCN_COMPANY_VS"
            Begin Extent = 
               Top = 126
               Left = 900
               Bottom = 226
               Right = 1052
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aspnet_Users"
            Begin Extent = 
               Top = 228
               Left = 900
               Bottom = 343
               Right = 1071
            End
            DisplayFlags = 280
            TopColumn = 0
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
         Column = 2190
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_Users_VS', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'_CHCN_Users_VS', NULL, NULL
GO
