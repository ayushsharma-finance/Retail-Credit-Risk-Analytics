/*==============================================================
Project        : ProjectSHIELD
Module         : Triggers
Developer      : Ayush Sharma
Version        : 1.0
Database       : ProjectSHIELD
Description    : Database Triggers for ProjectSHIELD
Created On     : August 2026
==============================================================*/

USE ProjectSHIELD;
GO

/*==============================================================
Trigger Name : trg_NewLoanApplication
Purpose      : Display a message whenever a new loan is added.
==============================================================*/

CREATE TRIGGER trg_NewLoanApplication
ON Loan_Applications
AFTER INSERT
AS
BEGIN
    PRINT 'New Loan Application Added Successfully.';
END;
GO


/*==============================================================
Trigger Name : trg_UpdateLoanApplication
Purpose      : Display a message whenever a loan is updated.
==============================================================*/

CREATE TRIGGER trg_UpdateLoanApplication
ON Loan_Applications
AFTER UPDATE
AS
BEGIN
    PRINT 'Loan Application Updated Successfully.';
END;
GO


/*==============================================================
Trigger Name : trg_DeleteLoanApplication
Purpose      : Display a message whenever a loan is deleted.
==============================================================*/

CREATE TRIGGER trg_DeleteLoanApplication
ON Loan_Applications
AFTER DELETE
AS
BEGIN
    PRINT 'Loan Application Deleted Successfully.';
END;
GO


/*==============================================================
Trigger Name : trg_CheckNegativeLoanAmount
Purpose      : Prevent negative loan amounts.
==============================================================*/

CREATE TRIGGER trg_CheckNegativeLoanAmount
ON Loan_Applications
INSTEAD OF INSERT
AS
BEGIN

    IF EXISTS
    (
        SELECT *
        FROM inserted
        WHERE Loan_Amount <= 0
    )
    BEGIN
        RAISERROR ('Loan Amount must be greater than zero.',16,1);
        RETURN;
    END

    INSERT INTO Loan_Applications
    SELECT *
    FROM inserted;

END;
GO


/*==============================================================
Trigger Name : trg_CheckNegativeEMI
Purpose      : Prevent negative EMI values.
==============================================================*/

CREATE TRIGGER trg_CheckNegativeEMI
ON Loan_Applications
INSTEAD OF UPDATE
AS
BEGIN

    IF EXISTS
    (
        SELECT *
        FROM inserted
        WHERE EMI < 0
    )
    BEGIN
        RAISERROR ('EMI cannot be negative.',16,1);
        RETURN;
    END

    UPDATE Loan_Applications
    SET
        Customer_ID = i.Customer_ID,
        Branch_ID = i.Branch_ID,
        Employee_ID = i.Employee_ID,
        Loan_Product = i.Loan_Product,
        Loan_Amount = i.Loan_Amount,
        Interest_Rate = i.Interest_Rate,
        Tenure_Months = i.Tenure_Months,
        EMI = i.EMI,
        Existing_EMI = i.Existing_EMI,
        FOIR = i.FOIR,
        Property_Value = i.Property_Value,
        LTV = i.LTV,
        CIBIL_Score = i.CIBIL_Score,
        Annual_Income = i.Annual_Income,
        Monthly_Income = i.Monthly_Income,
        Processing_Fee = i.Processing_Fee,
        Sanctioned_Amount = i.Sanctioned_Amount,
        Approval_Status = i.Approval_Status,
        Rejection_Reason = i.Rejection_Reason,
        Application_Date = i.Application_Date
    FROM Loan_Applications L
    INNER JOIN inserted i
        ON L.Loan_ID = i.Loan_ID;

END;
GO
