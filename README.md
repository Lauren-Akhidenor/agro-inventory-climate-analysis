# Agricultural Inventory & Climate-Expectation Analysis

## Overview
This project demonstrates Microsoft SQL Server / T-SQL skills by modeling agricultural inventory, incorporating farmers’ climate expectation signals, and building both analytical and operational logic to inform decisions.

## Skills Demonstrated
- Schema design with primary keys and constraints  
- Data integrity enforcement (CHECK constraints, defaults)  
- Auditability via triggers (tracking updates)  
- Stored procedure creation for business logic (`usp_GetInputsNeedingRestock`)  
- Aggregation and comparison queries  
- Statistical summary (average, volatility, coefficient of variation)  
- Conditional logic for alerts  

## Project Structure
- **sql/**: T-SQL scripts (schema creation, sample inserts, stored procedure, analysis queries)  
- **sample_data/**: Example CSVs for easy import  
- **screenshots/**: Proof-of-execution (SSMS outputs, schema design, procedure code)


## Key Components

### 1. Schema & Data Integrity  
This project implements a relational database design for tracking crop inventory and farm inputs, with **constraints** to maintain data accuracy and prevent invalid entries.

Key measures include:
- **Primary Keys** to uniquely identify each crop or farm input.
- **CHECK Constraints** to ensure that no negative quantities or prices are recorded.
- **DEFAULT Values** to auto-populate fields like `CreatedAt` and `ModifiedAt`.
- **Triggers** to automatically update timestamps when records are modified.




---

### **2. Link to the actual file**
You can also provide a direct link to the file so people can view/download it:
```markdown
[View `create_schema.sql` here](https://github.com/Lauren-Akhidenor/agro-inventory-climate-analysis/blob/main/sql/create_schema.sql)





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








---------
## Example Outputs

### 1. Schema Design


![Schema Design](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(853).png)



### 2. Database Reset Script Explanation
![Database reset script](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(844).png)

This section ensures a clean starting point before creating new tables.  
- `USE [checkpoint]`: Switches to the correct database.  
- `IF OBJECT_ID ... DROP TABLE`: Checks if the table exists, and if so, deletes it to avoid duplication errors.  
- `GO`: Marks the end of each batch so commands execute in the correct order.  

This approach allows the script to be re-run safely during development without manual table removal.


### 2. Crop Inventory Table Data
![Crop Inventory Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(845).png)

### 3. Farm Input Table Data
![Farm Input Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(846).png)

### 4. Stored Procedure Definition
![Stored Procedure Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(847).png)

### 5. Running Stored Procedure
![Stored Procedure Execution](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(848).png)

### 6. Climate Expectation Price Analysis
![Climate Price Analysis](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(849).png)

### 7. Price Volatility Analysis
![Price Volatility](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(850).png)

### 8. Full Query Results
![Full Query Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(851).png)

### 9. Code for Schema Creation
![Create Schema Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(852).png)

### 10. Code for Inserts


### 11. Trigger Definition
![Trigger Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(857).png)

### 12. Query to Compare Climate Flags
![Analysis Query](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(859).png)

### 13. Query Output – Restock Alerts
![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(862).png)

### 14. Query Output – Climate Price Averages
![Climate Price Averages](https://raw.githubuserc)




