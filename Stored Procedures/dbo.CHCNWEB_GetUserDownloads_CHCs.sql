SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Updated to remove hypen in the list of company IDs since we removed all hypens in UserProfile table SK.6/9/2016


CREATE    procedure [dbo].[CHCNWEB_GetUserDownloads_CHCs]

@FromDate datetime,
@ToDate datetime

as

SELECT DISTINCT C.CompanyID, C.Company, U.FirstName, U.LastName, UL.ClickDate,CASE WHEN UL.UrlTrackingID='41' THEN 'AAH_Active' WHEN UL.UrlTrackingID='42' THEN 'AAH_Termed' WHEN UL.UrlTrackingID='43' THEN 'AAH_Combo' WHEN UL.UrlTrackingID='44' THEN 'BC_Active' WHEN UL.UrlTrackingID='45' THEN 'BC_Termed' WHEN UL.UrlTrackingID='46' THEN 'BC_COMBO' WHEN UL.UrlTrackingID='47' THEN 'HN_Active' WHEN UL.UrlTrackingID='48' THEN 'HN_Termed' WHEN UL.UrlTrackingID='49' THEN 'HN_Combo' ELSE F.FileName  END AS FileName, F.Extension
FROM      UrlLog UL  left JOIN
          UrlTracking UT  ON UT.UrlTrackingID = UL.UrlTrackingID left JOIN
          Users U ON UL.UserID = U.UserID left JOIN
          Files F ON REPLACE(UT.Url, 'FILEID=', '') = F.FileId AND UT.URL like 'FILEID%' INNER JOIN
                      _CHCN_COMPANY_VS C ON U.UserID = C.UserID AND (C.Company not like '%DEMO')
WHERE  (UT.Url like 'FILEID%') 
--and  (C.CompanyID in ('94-2232394','94-2235908','94-1744108','94-2502308','23-7135928','23-7255435','23-7118361', '94-1667294')) 
and  (C.CompanyID in ('942232394','942235908','941744108','942502308','237135928','237255435','237118361', '941667294')) 
and (UL.ClickDate between @FromDate and @ToDate) 
order by C.CompanyID, ClickDate asc








GO
