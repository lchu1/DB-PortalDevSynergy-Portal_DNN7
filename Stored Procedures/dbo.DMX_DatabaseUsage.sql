SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DatabaseUsage]
AS

SELECT
 o.name,
 SUM(s.reserved_page_count) * 8.0 / 1024 reserved,
 SUM(s.row_count) [rows]
FROM
 sys.dm_db_partition_stats s
 INNER JOIN sys.objects o ON s.object_id = o.object_id
GROUP BY o.name
ORDER BY reserved DESC
GO
