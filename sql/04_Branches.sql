USE projectSHIELD;
GO
CREATE TABLE BRANCHES
(
BRANCH_ID VARCHAR(15) PRIMARY KEY,
BRANCH_CODE VARCHAR(10) NOT NULL UNIQUE,
BRANCH_NAME VARCHAR(100) NOT NULL,
IFSC_CODE VARCHAR(11) NOT NULL UNIQUE,
BRANC_ADDRESS VARCHAR(255) NOT NULL,
City               VARCHAR(50)     NOT NULL,

    District           VARCHAR(50)     NOT NULL,

    State              VARCHAR(50)     NOT NULL,

    PIN_Code           VARCHAR(6)      NOT NULL,

    Branch_Manager     VARCHAR(100)    NOT NULL,

    Contact_Number     VARCHAR(15)     NOT NULL,

    Email_ID           VARCHAR(100),

    Branch_Status      VARCHAR(20)     DEFAULT 'Active',

    Created_Date       DATETIME        DEFAULT GETDATE()
);
GO
