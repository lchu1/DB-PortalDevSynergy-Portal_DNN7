SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE     procedure [dbo].[CHCNWEB_GetUserDownloads]


as

SELECT DISTINCT C.Company, U.FirstName, U.LastName, UL.ClickDate, F.FileName, F.Extension
FROM         UrlTracking UT INNER JOIN
                      UrlLog UL ON UT.UrlTrackingID = UL.UrlTrackingID INNER JOIN
                      Users U ON UL.UserID = U.UserID INNER JOIN
                      Files F ON REPLACE(UT.Url, 'FILEID=', '') = F.FileId INNER JOIN
                      _CHCN_COMPANY_VS C ON U.UserID = C.UserID
WHERE     (C.Company <> N'DEMO') and (UT.Url like 'FILEID%')
ORDER BY UL.ClickDate




GO
