SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddAttributeEntrytype]
 @AttributeId INT, 
 @EntryType NVARCHAR (50)
AS
INSERT INTO dbo.DMX_AttributeEntrytypes (
 [AttributeId],
 [EntryType])
VALUES (
 @AttributeId,
 @EntryType)
GO
