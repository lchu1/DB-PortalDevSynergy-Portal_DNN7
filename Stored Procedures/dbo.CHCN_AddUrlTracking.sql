SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



create procedure [dbo].[CHCN_AddUrlTracking]

@PortalID     int,
@Url          nvarchar(255),
@UrlType      char(1),
@LogActivity  bit,
@TrackClicks  bit,
@ModuleId     int,
@NewWindow    bit

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
  @Url,
  @UrlType,
  0,
  null,
  getdate(),
  @LogActivity,
  @TrackClicks,
  @ModuleId,
  @NewWindow
)

select SCOPE_IDENTITY()








GO
