SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE        procedure [dbo].[CHCNWEB_AddUrlTracking]

@PortalID     int,
@Url          nvarchar(255),
@UrlType      char(1),
@LogActivity  bit,
@TrackClicks  bit,
@ModuleId     int,
@NewWindow    bit,
@URLID	      int OUTPUT

as

insert into UrlTracking (
  PortalID,
  Url,
  UrlType,
  Clicks,
  LastClick,
  CreatedDate,
  LogActivity,
  TrackClicks,
  ModuleId,
  NewWindow
)
values (
  @PortalID,
  'FileID='+@Url,
  @UrlType,
  0,
  getdate(),
  getdate(),
  @LogActivity,
  @TrackClicks,
  @ModuleId,
  @NewWindow
)

SELECT @URLID = SCOPE_IDENTITY()

RETURN (1)














GO
