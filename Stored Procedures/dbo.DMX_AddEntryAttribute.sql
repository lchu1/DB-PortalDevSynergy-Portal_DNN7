SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddEntryAttribute]
 @AttributeId INT, 
 @EntryId INT, 
 @Value NVARCHAR (2000)
AS
INSERT INTO dbo.DMX_EntryAttributes (
 [AttributeId],
 [EntryId],
 [Value])
VALUES (
 @AttributeId,
 @EntryId,
 @Value)
GO
