SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_CompareVersion]
(
	@Version		nvarchar(20),
	@CurrentVersion nvarchar(20)
)
RETURNS int

AS
	BEGIN

		DECLARE @MajorVersion int
		DECLARE @MajorCurrentVersion int
		DECLARE @MinorVersion int
		DECLARE @MinorCurrentVersion int
		DECLARE @BuildVersion int
		DECLARE @BuildCurrentVersion int

		SELECT @MajorVersion = Major, @MinorVersion = Minor, @BuildVersion = Build
		FROM dbo.[fn_ParseVersion](@Version)
		SELECT @MajorCurrentVersion = Major, @MinorCurrentVersion = Minor, @BuildCurrentVersion = Build
		FROM dbo.[fn_ParseVersion](@CurrentVersion)

		IF @CurrentVersion IS NULL
			-- Assembly Not Registered -  Set ReturnCode = 0, so assembly is copied
			RETURN 0
		ELSE
			IF @Version = @CurrentVersion
				-- Same Version - Set ReturnCode = 2, so assembly is only copied on repair
				RETURN 2
			ELSE
				-- Different Version
				-- Compare Major, Minor, Revision
				IF @MajorVersion > @MajorCurrentVersion
					OR (@MajorVersion = @MajorCurrentVersion AND @MinorVersion > @MinorCurrentVersion)
						OR (@MajorVersion = @MajorCurrentVersion AND @MinorVersion = @MinorCurrentVersion AND @BuildVersion > @BuildCurrentVersion)
					-- Newer version - at least on of Major, Minor, Revision is larger - Set ReturnCode = 1, so assembly is copied
					RETURN 1
				ELSE
					-- Older Version - Set ReturnCode = 3, so assembly is not copied
					RETURN 3

		RETURN 3
	END
GO
