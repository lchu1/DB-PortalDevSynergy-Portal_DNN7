SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsPPErrorLogAdd ***/

CREATE PROCEDURE [dbo].[EventsPPErrorLogAdd]
    (
      @SignupID INT
    , @PayPalStatus NVARCHAR(50)
    , @PayPalReason NVARCHAR(100)
    , @PayPalTransID NVARCHAR(50)
    , @PayPalPayerID NVARCHAR(50)
    , @PayPalPayerStatus NVARCHAR(50)
    , @PayPalRecieverEmail NVARCHAR(100)
    , @PayPalUserEmail NVARCHAR(100)
    , @PayPalPayerEmail NVARCHAR(100)
    , @PayPalFirstName NVARCHAR(50)
    , @PayPalLastName NVARCHAR(50)
    , @PayPalAddress NVARCHAR(100)
    , @PayPalCity NVARCHAR(25)
    , @PayPalState NVARCHAR(25)
    , @PayPalZip NVARCHAR(25)
    , @PayPalCountry NVARCHAR(25)
    , @PayPalCurrency NVARCHAR(25)
    , @PayPalPaymentDate DATETIME
    , @PayPalAmount MONEY
    , @PayPalFee MONEY
    )
AS 
    SET DATEFORMAT mdy
    INSERT  dbo.[EventsPPErrorLog]
            ( SignupID
            , PayPalStatus
            , PayPalReason
            , PayPalTransID
            , PayPalPayerID
            , PayPalPayerStatus
            , PayPalRecieverEmail
            , PayPalUserEmail
            , PayPalPayerEmail
            , PayPalFirstName
            , PayPalLastName
            , PayPalAddress
            , PayPalCity
            , PayPalState
            , PayPalZip
            , PayPalCountry
            , PayPalCurrency
            , PayPalPaymentDate
            , PayPalAmount
            , PayPalFee
            )
    VALUES  ( @SignupID
            , @PayPalStatus
            , @PayPalReason
            , @PayPalTransID
            , @PayPalPayerID
            , @PayPalPayerStatus
            , @PayPalRecieverEmail
            , @PayPalUserEmail
            , @PayPalPayerEmail
            , @PayPalFirstName
            , @PayPalLastName
            , @PayPalAddress
            , @PayPalCity
            , @PayPalState
            , @PayPalZip
            , @PayPalCountry
            , @PayPalCurrency
            , @PayPalPaymentDate
            , @PayPalAmount
            , @PayPalFee
            )

    SELECT  s.PayPalID
          , s.SignupID
          , CreateDate
          , PayPalStatus
          , PayPalReason
          , PayPalTransID
          , PayPalPayerID
          , PayPalPayerStatus
          , PayPalRecieverEmail
          , PayPalUserEmail
          , PayPalPayerEmail
          , PayPalFirstName
          , PayPalLastName
          , PayPalAddress
          , PayPalCity
          , PayPalState
          , PayPalZip
          , PayPalCountry
          , PayPalCurrency
          , PayPalPaymentDate
          , PayPalAmount
          , PayPalFee
    FROM    dbo.[EventsPPErrorLog] s
    WHERE   s.PayPalID = @@Identity
GO
