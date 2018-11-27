SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateTab]
    @TabId                  Int,
    @ContentItemID          Int,
    @PortalId               Int,
    @VersionGuid            UniqueIdentifier,
    @DefaultLanguageGuid    UniqueIdentifier,
    @LocalizedVersionGuid   UniqueIdentifier,
    @TabName                nVarChar(200),
    @IsVisible              Bit,
    @DisableLink            Bit,
    @ParentId               Int,
    @IconFile               nVarChar(255),
    @IconFileLarge          nVarChar(255),
    @Title                  nVarChar(200),
    @Description            nVarChar(500),
    @KeyWords               nVarChar(500),
    @IsDeleted              Bit,
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
    @LastModifiedByUserID   Int,
    @CultureCode            nVarChar( 10),
    @IsSystem               Bit
AS
BEGIN
    DECLARE @OldParentId Int
    SET @OldParentId = (SELECT ParentId FROM dbo.[Tabs] WHERE TabID = @TabId)

    DECLARE @TabOrder Int
    SET @TabOrder = (SELECT TabOrder FROM dbo.[Tabs] WHERE TabID = @TabId)

    -- Get New TabOrder
    DECLARE @NewTabOrder Int
    SET @NewTabOrder = (SELECT MAX(TabOrder) FROM dbo.[Tabs] WHERE (ParentId = @ParentId OR (ParentId IS NULL AND @ParentId IS NULL)))
    IF @NewTabOrder IS NULL
        SET @NewTabOrder = 1
    ELSE
        SET @NewTabOrder = @NewTabOrder + 2

    UPDATE dbo.[Tabs]
        SET
            ContentItemID           = @ContentItemID,
            PortalId                = @PortalId,
            VersionGuid             = @VersionGuid,
            DefaultLanguageGuid     = @DefaultLanguageGuid,
            LocalizedVersionGuid    = @LocalizedVersionGuid,
            TabName                 = @TabName,
            IsVisible               = @IsVisible,
            DisableLink             = @DisableLink,
            ParentId                = @ParentId,
            IconFile                = @IconFile,
            IconFileLarge           = @IconFileLarge,
            Title                   = @Title,
            Description             = @Description,
            KeyWords                = @KeyWords,
            IsDeleted               = @IsDeleted,
            Url                     = @Url,
            SkinSrc                 = @SkinSrc,
            ContainerSrc            = @ContainerSrc,
            StartDate               = @StartDate,
            EndDate                 = @EndDate,
            RefreshInterval         = @RefreshInterval,
            PageHeadText            = @PageHeadText,
            IsSecure                = @IsSecure,
            PermanentRedirect       = @PermanentRedirect,
            SiteMapPriority         = @SiteMapPriority,
            LastModifiedByUserID    = @LastModifiedByUserID,
            LastModifiedOnDate      = getdate(),
            CultureCode             = @CultureCode,
            IsSystem                = @IsSystem
    WHERE  TabId = @TabId;

    IF (@OldParentId <> @ParentId) BEGIN
        -- update TabOrder of Tabs with same original Parent
        UPDATE dbo.[Tabs]
           SET TabOrder = TabOrder - 2
         WHERE (ParentId = @OldParentId)
           AND TabOrder > @TabOrder

        -- Update Tab with new TabOrder
        UPDATE dbo.[Tabs]
           SET TabOrder = @NewTabOrder
         WHERE TabID = @TabId
    END /* IF */

    EXEC dbo.BuildTabLevelAndPath @TabId, 1
END /* Procedure */
GO
