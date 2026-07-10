-- ==========================================
-- Project SHIELD
-- Table: Customers
-- Version 1.0
-- ==========================================

USE ProjectSHIELD;
GO

CREATE TABLE Customers
(
    Customer_ID                 VARCHAR(15)     PRIMARY KEY,

    First_Name                  VARCHAR(50)     NOT NULL,
    Last_Name                   VARCHAR(50)     NOT NULL,
    Full_Name                   AS (First_Name + ' ' + Last_Name),

    Date_of_Birth               DATE            NOT NULL,
    Gender                      VARCHAR(10)     NOT NULL,

    Mobile_Number               VARCHAR(15)     NOT NULL,
    Email                       VARCHAR(100),

    Aadhaar_Number              VARCHAR(12)     UNIQUE,
    PAN_Number                  VARCHAR(10)     UNIQUE,

    Marital_Status              VARCHAR(20),
    Occupation                  VARCHAR(50),
    Employment_Type             VARCHAR(30),

    Annual_Income               DECIMAL(12,2),
    Net_Monthly_Income          DECIMAL(12,2),

    Address_Line1               VARCHAR(150),
    Address_Line2               VARCHAR(150),
    City                        VARCHAR(50),
    State                       VARCHAR(50),
    PIN_Code                    VARCHAR(10),

    Customer_Status             VARCHAR(20)     DEFAULT 'Active',

    Created_Date                DATETIME        DEFAULT GETDATE(),
    Updated_Date                DATETIME
);
GO

PRINT 'Customers table created successfully!';
GO
