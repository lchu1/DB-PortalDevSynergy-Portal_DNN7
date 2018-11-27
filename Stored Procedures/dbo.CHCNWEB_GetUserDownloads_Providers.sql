SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Updated to remove hypen in the list of company IDs since we removed all hypens in UserProfile table SK.6/9/2016

CREATE    procedure [dbo].[CHCNWEB_GetUserDownloads_Providers]

@FromDate datetime,
@ToDate datetime

as

SELECT DISTINCT C.CompanyID, C.Company, U.FirstName, U.LastName, UL.ClickDate, F.FileName, F.Extension
FROM         UrlTracking UT INNER JOIN
                      UrlLog UL ON UT.UrlTrackingID = UL.UrlTrackingID INNER JOIN
                      Users U ON UL.UserID = U.UserID INNER JOIN
                      Files F ON REPLACE(UT.Url, 'FILEID=', '') = F.FileId INNER JOIN
                      _CHCN_COMPANY_VS C ON U.UserID = C.UserID
WHERE (UT.Url like 'FILEID%') 
--and   (C.CompanyID not in ('CHCNCHC','94-2232394','94-2235908','94-1744108','94-2502308','23-7135928','23-7255435','23-7118361','94-1667294')) 
and   (C.CompanyID not in ('CHCNCHC','942232394','942235908','941744108','942502308','237135928','237255435','237118361','941667294')) 
and (UL.ClickDate between @FromDate and @ToDate)
order by C.CompanyID, ClickDate asc


GO
