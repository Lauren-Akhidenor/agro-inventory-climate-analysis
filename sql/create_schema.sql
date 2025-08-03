-- =====================================================
-- Agricultural Inventory & Climate-Expectation Database
-- Schema Design Script
-- Author: Lauren Akhidenor
-- Description: Creates core tables, constraints, and triggers
-- =====================================================

-- 1. Ensure we are in the correct database
USE [checkpoint];
GO

-- 2. Drop existing tables if they exist (safe re-run)
IF OBJECT_ID(N'dbo.CropInventory', N'U') IS NOT NULL
    DROP TABLE dbo.CropInventory;
GO

IF OBJECT_ID(N'dbo.FarmInput', N'U') IS NOT NULL
    DROP TABLE dbo.FarmInput;
GO

-- 3. Create CropInventory table
CREATE TABLE dbo.CropInventory (
    CropID                 VARCHAR(50)      NOT NULL,  -- Unique crop identifier (e.g., MAIZE001)
    CropName               NVARCHAR(100)    NOT NULL,  -- Crop type (e.g., Maize, Rice)
    Variety                NVARCHAR(100)    NULL,      -- Variety name (e.g., Hybrid, Local)
    QuantityKg             DECIMAL(12,2)    NOT NULL
        CONSTRAINT CK_CropInventory_Quantity_NonNegative CHECK (QuantityKg >= 0), -- No negative stock
    HarvestDate            DATE             NOT NULL,  -- Date of harvest
    ClimateExpFlag         BIT              NOT NULL DEFAULT 0,  -- 1 if climate extremes expected
    ExpectedSellPricePerKg DECIMAL(12,2)    NULL,      -- Projected price per kg
    CreatedAt              DATETIME2        NOT NULL DEFAULT SYSUTCDATETIME(),  -- Creation timestamp
    ModifiedAt             DATETIME2        NOT NULL DEFAULT SYSUTCDATETIME(),  -- Last modification timestamp
    CONSTRAINT PK_CropInventory PRIMARY KEY (CropID)
);
GO

-- 4. Create FarmInput table
CREATE TABLE dbo.FarmInput (
    InputID          VARCHAR(50)     NOT NULL,  -- Unique input identifier (e.g., FERT_NPK)
    InputName        NVARCHAR(100)   NOT NULL,  -- Input name (e.g., NPK Fertilizer)
    QuantityUnits    INT             NOT NULL
        CONSTRAINT CK_FarmInput_Quantity_NonNegative CHECK (QuantityUnits >= 0), -- No negative quantity
    UnitType         NVARCHAR(50)    NOT NULL,  -- Measurement unit (e.g., Bag, Litre)
    ReorderThreshold INT             NOT NULL DEFAULT 10,  -- Restock trigger point
    CreatedAt        DATETIME2       NOT NULL DEFAULT SYSUTCDATETIME(),
    ModifiedAt       DATETIME2       NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_FarmInput PRIMARY KEY (InputID)
);
GO

-- 5. Trigger: Update ModifiedAt when CropInventory is updated
CREATE OR ALTER TRIGGER dbo.trg_UpdateModifiedAt_CropInventory
ON dbo.CropInventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ci
    SET ModifiedAt = SYSUTCDATETIME()
    FROM dbo.CropInventory ci
    JOIN inserted i ON ci.CropID = i.CropID;
END;
GO

-- 6. Trigger: Update ModifiedAt when FarmInput is updated
CREATE OR ALTER TRIGGER dbo.trg_UpdateModifiedAt_FarmInput
ON dbo.FarmInput
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE fi
    SET ModifiedAt = SYSUTCDATETIME()
    FROM dbo.FarmInput fi
    JOIN inserted i ON fi.InputID = i.InputID;
END;
GO

-- =====================================================
-- End of Schema Design Script
-- =====================================================
