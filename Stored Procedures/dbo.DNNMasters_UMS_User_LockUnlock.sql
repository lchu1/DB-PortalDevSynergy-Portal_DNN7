SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DNNMasters_UMS_User_LockUnlock]
  @P_username nvarchar(256),
  @P_LOCK BIT
AS
DECLARE
  @ERRNO                INT,
  @ERRMSG               VARCHAR(255),
  @ERRPOM               VARCHAR(255)
BEGIN
  SET NOCOUNT ON
  SET @P_LOCK = ISNULL(@P_LOCK, 0)
  --
  SET @ERRPOM = ''
  IF (@P_username IS NULL) SET @ERRPOM = @ERRPOM + '@P_username '
  --
  IF @ERRPOM <> ''
  BEGIN
    SET @ERRNO = 70001
    SET @ERRMSG = 'PARAMETR: ' + @ERRPOM + 'IS REQUIRED'
    GOTO ERROR
  END
  --
  update am 
     set am.IsLockedOut = @P_LOCK,
         am.LastLockoutDate = case when @P_LOCK = 1 then GETDATE()
                                   else am.LastLockoutDate
                              end
    from aspnet_Users AU
    JOIN aspnet_Membership AM ON AM.UserId = au.UserId
   where au.username = @P_username
  --  
OK:
  RETURN 0
ERROR:
  SET @ERRMSG='[' + CAST(@ERRNO as VARCHAR(10)) + ']'+@ERRMSG
  SET @ERRMSG = @ERRMSG + CHAR(13) + CHAR(10) +' ^' + OBJECT_NAME(@@PROCID)
  RAISERROR (@ERRMSG, 16, 1)
  RETURN -1
END
GO
