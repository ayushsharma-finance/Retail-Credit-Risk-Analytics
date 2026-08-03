USE ProjectSHIELD;
GO

/*==============================================================
Project        : ProjectSHIELD
Module         : Indexes
Developer      : Ayush Sharma
Version        : 1.0
==============================================================*/

/* Primary Search Index */
CREATE INDEX IX_LoanID
ON Loan_Applications(Loan_ID);
GO

/* Customer Search */
CREATE INDEX IX_CustomerID
ON Loan_Applications(Customer_ID);
GO

/* Branch Performance */
CREATE INDEX IX_BranchID
ON Loan_Applications(Branch_ID);
GO

/* Employee Performance */
CREATE INDEX IX_EmployeeID
ON Loan_Applications(Employee_ID);
GO

/* Approval Status */
CREATE INDEX IX_ApprovalStatus
ON Loan_Applications(Approval_Status);
GO

/* Risk Analysis */
CREATE INDEX IX_CIBIL
ON Loan_Applications(CIBIL_Score);
GO

/* FOIR */
CREATE INDEX IX_FOIR
ON Loan_Applications(FOIR);
GO

/* LTV */
CREATE INDEX IX_LTV
ON Loan_Applications(LTV);
GO

/* Loan Product */
CREATE INDEX IX_LoanProduct
ON Loan_Applications(Loan_Product);
GO

/* Application Date */
CREATE INDEX IX_ApplicationDate
ON Loan_Applications(Application_Date);
GO
