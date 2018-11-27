SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE      procedure [dbo].[CHCNWEB_AddFile]

@PortalId    int,
@FileName    nvarchar(100),
@Extension   nvarchar(100),
@Size        int,
@WIdth       int,
@Height      int,
@ContentType nvarchar(200),
@Folder		 nvarchar(200),
@FolderID    int,
@FileID      int OUTPUT

as

insert into Files ( 
  PortalId,
  FileName,
  Extension,
  Size,
  WIdth,
  Height,
  ContentType,
  FolderID
)
values (
  @PortalId,
  @FileName,
  @Extension,
  @Size,
  @WIdth,
  @Height,
  @ContentType,
  @FolderID
)

SELECT @FileID =  SCOPE_IDENTITY()

RETURN (1)






GO
