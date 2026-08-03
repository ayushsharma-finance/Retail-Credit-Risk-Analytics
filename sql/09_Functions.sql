USE ProjectSHIELD;
GO

/*==============================================================
Project        : ProjectSHIELD
Module         : SQL Functions
Developer      : Ayush Sharma
Version        : 1.0
Database       : ProjectSHIELD
Description    : User Defined Functions used for banking
                 credit risk analytics.
Created On     : July 2026
==============================================================*/

/*==============================================================
Function Name : fn_GetRiskScore
Purpose       : Calculate risk score based on CIBIL, FOIR and LTV.
Returns       : Risk Score
==============================================================*/

CREATE FUNCTION fn_GetRiskScore
(
    @CIBIL INT,
    @FOIR DECIMAL(10,2),
    @LTV DECIMAL(10,2)
)
RETURNS INT
AS
BEGIN

    DECLARE @RiskScore INT = 0;

    IF @CIBIL < 680
        SET @RiskScore = @RiskScore + 1;

    IF @FOIR > 60
        SET @RiskScore = @RiskScore + 1;

    IF @LTV > 80
        SET @RiskScore = @RiskScore + 1;

    RETURN @RiskScore;

END;
GO

/*==============================================================
Function Name : fn_GetRiskScore
Purpose       : Calculate risk score based on CIBIL, FOIR and LTV.
Returns       : Risk Score
==============================================================*/

CREATE FUNCTION fn_GetRiskScore
(
    @CIBIL INT,
    @FOIR DECIMAL(10,2),
    @LTV DECIMAL(10,2)
)
RETURNS INT
AS
BEGIN

    DECLARE @RiskScore INT = 0;

    IF @CIBIL < 680
        SET @RiskScore = @RiskScore + 1;

    IF @FOIR > 60
        SET @RiskScore = @RiskScore + 1;

    IF @LTV > 80
        SET @RiskScore = @RiskScore + 1;

    RETURN @RiskScore;

END;
GO

/*==============================================================
Function Name : fn_GetRiskLevel
Purpose       : Convert Risk Score into Risk Level.
Returns       : Low, Medium or High Risk
==============================================================*/

CREATE FUNCTION fn_GetRiskLevel
(
    @RiskScore INT
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @RiskLevel VARCHAR(20);

    IF @RiskScore >= 2
        SET @RiskLevel = 'High Risk';

    ELSE IF @RiskScore = 1
        SET @RiskLevel = 'Medium Risk';

    ELSE
        SET @RiskLevel = 'Low Risk';

    RETURN @RiskLevel;

END;
GO

/*==============================================================
Function Name : fn_AnnualIncome
Purpose       : Convert Monthly Income into Annual Income.
Returns       : Annual Income
==============================================================*/

CREATE FUNCTION fn_AnnualIncome
(
    @MonthlyIncome DECIMAL(18,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN

    RETURN @MonthlyIncome * 12;

END;
GO

/*==============================================================
Function Name : fn_LoanEligibility
Purpose       : Check loan eligibility based on CIBIL Score.
Returns       : Eligible / Review Required / Not Eligible
==============================================================*/

CREATE FUNCTION dbo.fn_LoanEligibility
(
    @CIBIL INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Result VARCHAR(20);

    IF @CIBIL >= 750
        SET @Result = 'Eligible';

    ELSE IF @CIBIL >= 680
        SET @Result = 'Review Required';

    ELSE
        SET @Result = 'Not Eligible';

    RETURN @Result;
END;
GO
