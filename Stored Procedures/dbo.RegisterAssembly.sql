SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[RegisterAssembly]
	@PackageID      int,
	@AssemblyName   nvarchar(250),
	@Version		nvarchar(20)
As
BEGIN
	DECLARE @AssemblyID int
	DECLARE @CurrentVersion nvarchar(20)
	/*	@ReturnCode Values
		0 - Assembly NOT Registered Before
		1 - Assembly Already Registered - New Version > Current Version
		2 - Assembly Already Registered - New Version = Current Version
		3 - Assembly Already Registered - New Version < Current Version
	*/
	DECLARE @CompareVersion int

	-- First check if this assembly is registered to this package
	SET @AssemblyID = (SELECT AssemblyID
							FROM dbo.Assemblies
							WHERE PackageID = @PackageID
								AND AssemblyName = @AssemblyName)

	-- but assembly may be registerd by other packages so check for Max unstalled version
	SET @CurrentVersion  = (SELECT TOP 1 a.Version
							FROM dbo.Assemblies a
							CROSS APPLY dbo.[fn_ParseVersion](a.Version) AS v
							WHERE a.AssemblyName = @AssemblyName
							ORDER BY v.Major DESC, v.Minor DESC, v.Build DESC)

	SET @CompareVersion = dbo.fn_CompareVersion(@Version, @CurrentVersion)

	IF @AssemblyID IS NULL
		BEGIN
			-- AssemblyID is null (not registered)
			-- Add an assembly regsitration for this package
			INSERT INTO dbo.Assemblies (
				PackageID,
				AssemblyName,
				Version
			)
			VALUES (
				@PackageID,
				@AssemblyName,
				@Version
			)
		END
	ELSE
		BEGIN
			-- AssemblyID is not null - Assembly is registered
			IF @CompareVersion = 1
				BEGIN
					-- Newer version - Update Assembly registration
					UPDATE dbo.Assemblies
					SET    Version = @Version
					WHERE  AssemblyID = @AssemblyID
				END
		END

	SELECT @CompareVersion
END
GO
