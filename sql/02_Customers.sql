USE ProjectSHIELD;
GO

CREATE TABLE Loan_Products
(
    Loan_Product_ID        VARCHAR(15)     NOT NULL PRIMARY KEY,
    Loan_Product_Name      VARCHAR(50)     NOT NULL,
    Loan_Type              VARCHAR(30)     NOT NULL,
    Interest_Rate          DECIMAL(5,2)    NOT NULL,
    Minimum_Loan_Amount    DECIMAL(15,2)   NOT NULL,
    Maximum_Loan_Amount    DECIMAL(15,2)   NOT NULL,
    Minimum_Tenure_Months  INT             NOT NULL,
    Maximum_Tenure_Months  INT             NOT NULL,
    Processing_Fee         DECIMAL(10,2)   DEFAULT 0,
    Product_Status         VARCHAR(20)     DEFAULT 'Active',
    Created_Date           DATETIME        DEFAULT GETDATE()
);
GO
