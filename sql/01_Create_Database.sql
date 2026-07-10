-- ==========================================
-- Project SHIELD
-- Database Creation Script
-- Version 1.0
-- ==========================================

IF DB_ID('ProjectSHIELD') IS NOT NULL
BEGIN
    DROP DATABASE ProjectSHIELD;
END;
GO

CREATE DATABASE ProjectSHIELD;
GO

USE ProjectSHIELD;
GO

PRINT 'ProjectSHIELD Database Created Successfully!';
