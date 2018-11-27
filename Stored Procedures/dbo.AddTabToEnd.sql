SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddTabToEnd]
    @ContentItemID          Int,
    @PortalID               Int,
    @UniqueID               UniqueIdentifier,
    @VersionGuid            UniqueIdentifier,
    @DefaultLanguageGuid    UniqueIdentifier,
    @LocalizedVersionGuid   UniqueIdentifier,
    @TabName                nVarChar(200),
    @IsVisible              Bit,
    @DisableLink            Bit,
    @ParentID               Int,
    @IconFile               nVarChar(255),
    @IconFileLarge          nVarChar(255),
    @Title                  nVarChar(200),
    @Description            nVarChar(500),
    @KeyWords               nVarChar(500),
    @Url                    nVarChar(255),
    @SkinSrc                nVarChar(200),
    @ContainerSrc           nVarChar(200),
    @StartDate              DateTime,
    @EndDate                DateTime,
    @RefreshInterval        Int,
    @PageHeadText           nVarChar(max),
    @IsSecure               Bit,
    @PermanentRedirect      Bit,
    @SiteMapPriority        Float,
    @CreatedByUserID        Int,
    @CultureCode            nVarChar( 10),
    @IsSystem               Bit
AS
BEGIN
    DECLARE @TabId Int
    DECLARE @TabOrder Int
    SET @TabOrder = (SELECT MAX(TabOrder) FROM dbo.Tabs
                     WHERE (PortalId = @PortalID OR (PortalID IS NULL AND @PortalID IS NULL))
                       AND (ParentId = @ParentID OR (ParentID IS NULL AND @ParentID IS NULL))
                    )
    IF @TabOrder IS NULL
        SET @TabOrder = 1
    ELSE
        SET @TabOrder = @TabOrder + 2

    -- Create Tab
    EXECUTE @TabId = dbo.AddTab
                        @ContentItemID,
                        @PortalID,
                        @TabOrder,
                        @UniqueId,
                        @VersionGuid,
                        @DefaultLanguageGuid,
                        @LocalizedVersionGuid,
                        @TabName,
                        @IsVisible,
                        @DisableLink,
                        @ParentId,
                        @IconFile,
                        @IconFileLarge,
                        @Title,
                        @Description,
                        @KeyWords,
                        @Url,
                        @SkinSrc,
                        @ContainerSrc,
                        @StartDate,
                        @EndDate,
                        @RefreshInterval,
                        @PageHeadText,
                        @IsSecure,
                        @PermanentRedirect,
                        @SiteMapPriority,
                        @CreatedByUserID,
                        @CultureCode,
                        @IsSystem;

    -- Update Content Item
    UPDATE dbo.ContentItems
       SET TabID = @TabId
     WHERE ContentItemID = @ContentItemID;

    SELECT @TabId;
END /* Procedure */
GO
