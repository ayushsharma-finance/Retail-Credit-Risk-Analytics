USE ProjectSHIELD;
GO

/*==============================================================
Project        : ProjectSHIELD
Module         : Stored Procedures
Developer      : Ayush Sharma
Version        : 1.0
Database       : ProjectSHIELD
Description    : Stored Procedures for loan processing,
                 reporting, and banking operations.
Created On     : July 2026
==============================================================*/


/*==============================================================
Procedure Name : sp_SearchLoanByID
Purpose        : Retrieve complete loan details using Loan ID.
Used By        : Loan Officers, Credit Managers
==============================================================*/

CREATE PROCEDURE sp_SearchLoanByID
    @LoanID VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Loan_Applications
    WHERE Loan_ID = @LoanID;
END;
GO


/*==============================================================
Procedure Name : sp_SearchCustomer
Purpose        : Retrieve all loan applications for a customer.
Used By        : Loan Officers, Relationship Managers
==============================================================*/

CREATE PROCEDURE sp_SearchCustomer
    @CustomerID VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Loan_Applications
    WHERE Customer_ID = @CustomerID;
END;
GO


/*==============================================================
Procedure Name : sp_GetBranchPerformance
Purpose        : Generate branch-wise loan performance summary.
Used By        : Branch Managers, Regional Managers, Power BI
==============================================================*/

CREATE PROCEDURE sp_GetBranchPerformance
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Branch_ID,
        COUNT(*) AS Total_Loans,
        SUM(Loan_Amount) AS Total_Loan_Amount,
        AVG(Loan_Amount) AS Average_Loan_Amount
    FROM Loan_Applications
    GROUP BY Branch_ID
    ORDER BY Total_Loan_Amount DESC;
END;
GO


/*==============================================================
Procedure Name : sp_GetEmployeePerformance
Purpose        : Generate employee-wise loan performance summary.
Used By        : Branch Managers, Regional Managers, Power BI
==============================================================*/

CREATE PROCEDURE sp_GetEmployeePerformance
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Employee_ID,

        COUNT(*) AS Total_Applications,

        SUM(CASE
                WHEN Approval_Status = 'Approved'
                THEN 1
                ELSE 0
            END) AS Approved_Loans,

        SUM(CASE
                WHEN Approval_Status = 'Rejected'
                THEN 1
                ELSE 0
            END) AS Rejected_Loans,

        SUM(Loan_Amount) AS Total_Loan_Amount,

        AVG(Loan_Amount) AS Average_Loan_Amount

    FROM Loan_Applications

    GROUP BY Employee_ID

    ORDER BY Total_Applications DESC;
END;
GO


/*==============================================================
Procedure Name : sp_GetRiskClassification
Purpose        : Classify loan applications into Low, Medium,
                 and High Risk categories.
Used By        : Credit Managers, Risk Officers, Power BI
==============================================================*/

CREATE PROCEDURE sp_GetRiskClassification
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Loan_ID,
        Customer_ID,
        Branch_ID,
        Employee_ID,
        Loan_Product,
        Loan_Amount,
        EMI,
        FOIR,
        LTV,
        CIBIL_Score,
        Approval_Status,

        CASE
            WHEN
                (CASE WHEN CIBIL_Score < 680 THEN 1 ELSE 0 END) +
                (CASE WHEN FOIR > 60 THEN 1 ELSE 0 END) +
                (CASE WHEN LTV > 80 THEN 1 ELSE 0 END) >= 2
                THEN 'High Risk'

            WHEN
                (CASE WHEN CIBIL_Score < 680 THEN 1 ELSE 0 END) +
                (CASE WHEN FOIR > 60 THEN 1 ELSE 0 END) +
                (CASE WHEN LTV > 80 THEN 1 ELSE 0 END) = 1
                THEN 'Medium Risk'

            ELSE 'Low Risk'
        END AS Risk_Level

    FROM Loan_Applications

    ORDER BY
        CIBIL_Score ASC,
        FOIR DESC,
        LTV DESC;
END;
GO


/*==============================================================
Procedure Name : sp_GetHighRiskLoans
Purpose        : Display all high-risk loan applications.
Used By        : Credit Managers, Risk Officers, Power BI
==============================================================*/

CREATE PROCEDURE sp_GetHighRiskLoans
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Loan_ID,
        Customer_ID,
        Branch_ID,
        Employee_ID,
        Loan_Product,
        Loan_Amount,
        EMI,
        FOIR,
        LTV,
        CIBIL_Score,
        Approval_Status,
        Application_Date,

        CASE
            WHEN
                (CASE WHEN CIBIL_Score < 680 THEN 1 ELSE 0 END) +
                (CASE WHEN FOIR > 60 THEN 1 ELSE 0 END) +
                (CASE WHEN LTV > 80 THEN 1 ELSE 0 END) >= 2
                THEN 'High Risk'

            WHEN
                (CASE WHEN CIBIL_Score < 680 THEN 1 ELSE 0 END) +
                (CASE WHEN FOIR > 60 THEN 1 ELSE 0 END) +
                (CASE WHEN LTV > 80 THEN 1 ELSE 0 END) = 1
                THEN 'Medium Risk'

            ELSE 'Low Risk'
        END AS Risk_Level

    FROM Loan_Applications

    WHERE
        CIBIL_Score < 680
        OR FOIR > 60
        OR LTV > 80

    ORDER BY
        CIBIL_Score ASC,
        FOIR DESC,
        LTV DESC;
END;
GO
