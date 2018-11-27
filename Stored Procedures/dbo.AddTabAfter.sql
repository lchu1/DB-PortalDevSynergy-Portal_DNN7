SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddTabAfter]
    @AfterTabID             Int,
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
    DECLARE @TabId    Int
    DECLARE @TabOrder Int = (SELECT TabOrder FROM dbo.Tabs WHERE TabID = @AfterTabID)

    -- Update TabOrders for all Tabs higher than @TabOrder
    UPDATE dbo.Tabs
       SET TabOrder = TabOrder + 2
     WHERE (ParentId = @ParentID OR (ParentId IS NULL AND @ParentID IS NULL))
       AND TabOrder > @TabOrder
       AND (PortalId = @PortalID OR (PortalId IS NULL AND @PortalID IS NULL))

    -- Create Tab
    SET @TabOrder = @TabOrder + 2
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
                        @ParentID,
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
