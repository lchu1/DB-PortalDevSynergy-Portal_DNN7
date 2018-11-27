SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddPortalLanguage]
    @PortalId			int,
    @LanguageId			int,
    @IsPublished		bit,
    @CreatedByUserID	int

AS
    DECLARE @PortalLanguageId INT
    DECLARE @CultureCode NVARCHAR(50)

    INSERT INTO dbo.PortalLanguages (
        PortalId,
        LanguageId,
        IsPublished,
        [CreatedByUserID],
        [CreatedOnDate],
        [LastModifiedByUserID],
        [LastModifiedOnDate]
    )
    VALUES (
        @PortalId,
        @LanguageId,
        @IsPublished,
        @CreatedByUserID,
        getdate(),
        @CreatedByUserID,
        getdate()
    )

    SELECT @PortalLanguageId = SCOPE_IDENTITY()

	SELECT @CultureCode = CultureCode FROM dbo.Languages WHERE LanguageID = @LanguageId

    SELECT @PortalLanguageId

	EXEC dbo.EnsureLocalizationExists @PortalID = @PortalId, @CultureCode = @CultureCode
GO
