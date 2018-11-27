SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE  [dbo].[AddEventLog] 
	@LogGUID varchar(36),
	@LogTypeKey nvarchar(35),
	@LogUserID int,
	@LogUserName nvarchar(50),
	@LogPortalID int,
	@LogPortalName nvarchar(100),
	@LogCreateDate datetime,
	@LogServerName nvarchar(50),
	@LogProperties ntext,
	@LogConfigID int,
	@ExceptionHash varchar(100) = NULL,
	@NotificationActive bit = 0
AS
BEGIN
	DECLARE @LogEventID bigint

	INSERT INTO  dbo.[EventLog]
		(LogGUID,
		LogTypeKey,
		LogUserID,
		LogUserName,
		LogPortalID,
		LogPortalName,
		LogCreateDate,
		LogServerName,
		LogProperties,
		LogConfigID,
		ExceptionHash)
	VALUES
		(@LogGUID,
		@LogTypeKey,
		@LogUserID,
		@LogUserName,
		@LogPortalID,
		@LogPortalName,
		@LogCreateDate,
		@LogServerName,
		@LogProperties,
		@LogConfigID,
		@ExceptionHash)

	SELECT @LogEventID = SCOPE_IDENTITY()

	IF @NotificationActive=1
	BEGIN

		DECLARE @NotificationThreshold int
		DECLARE @ThresholdQueue int
		DECLARE @NotificationThresholdTime int
		DECLARE @NotificationThresholdTimeType int
		DECLARE @MinDateTime smalldatetime
		DECLARE @CurrentDateTime smalldatetime

		SET @CurrentDateTime = getDate()
		
		SELECT TOP 1 @NotificationThreshold = NotificationThreshold,
			@NotificationThresholdTime = NotificationThresholdTime,
			@NotificationThresholdTimeType = NotificationThresholdTimeType,
			@MinDateTime = 
				CASE
					 --seconds
					WHEN NotificationThresholdTimeType=1 THEN DateAdd(second, NotificationThresholdTime * -1, @CurrentDateTime)
					--minutes
					WHEN NotificationThresholdTimeType=2  THEN DateAdd(minute, NotificationThresholdTime * -1, @CurrentDateTime)
					--hours
					WHEN NotificationThresholdTimeType=3  THEN DateAdd(Hour, NotificationThresholdTime * -1, @CurrentDateTime)
					--days
					WHEN NotificationThresholdTimeType=4  THEN DateAdd(Day, NotificationThresholdTime * -1, @CurrentDateTime)
				END
		FROM  dbo.[EventLogConfig]
		WHERE ID = @LogConfigID

		SELECT @ThresholdQueue = COUNT(*)
		FROM  dbo.[EventLog] el
			INNER JOIN  dbo.[EventLogConfig] elc
				ON  el.LogConfigID =  elc.ID
		WHERE LogCreateDate > @MinDateTime 
			  AND el.LogNotificationPending IS NULL 
			  AND elc.ID = @LogConfigID

		IF @ThresholdQueue >= @NotificationThreshold
		BEGIN
			UPDATE  dbo.[EventLog]
			SET LogNotificationPending = 1 
			WHERE LogConfigID = @LogConfigID
				AND LogNotificationPending IS NULL		
				AND LogCreateDate > @MinDateTime
		END

	END
 
	SELECT @LogEventID
END
GO
