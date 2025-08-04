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


---------
## Snapshot of Scripts

### 1. Schema Design


![Schema Design](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(853).png)

This section defines the database structure for managing agricultural crop inventory and farm inputs.  
- **Primary Keys**: Ensure each record is uniquely identifiable (`CropID` for crops, `InputID` for inputs).  
- **CHECK Constraints**: Prevent invalid values, such as negative quantities.  
- **DEFAULT Values**: Automatically fill timestamps (`CreatedAt` and `ModifiedAt`) without manual input.  
- **Triggers**: Automatically update the `ModifiedAt` field whenever a record is changed, ensuring accurate audit tracking.  

This design enforces **data integrity**, supports reliable analytics, and allows for automated operational updates without manual intervention.




### 2. Database Reset Script Explanation

![Database reset script](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(844).png)


This section ensures a clean starting point before creating new tables.  
- `USE [checkpoint]`: Switches to the correct database.  
- `IF OBJECT_ID ... DROP TABLE`: Checks if the table exists, and if so, deletes it to avoid duplication errors.  
- `GO`: Marks the end of each batch so commands execute in the correct order.  
This approach allows the script to be re-run safely during development without manual table removal.


### 3. CropInventory Table Creation

![Crop Inventory Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(845).png)


This script creates the `CropInventory` table, which stores detailed information about harvested crops and expected market prices. The table provides a structured and validated way to store crop production data, enabling reliable analytics on harvest volumes, price expectations, and the influence of climate perceptions.



### 4. Farm Input Table Data

![Farm Input Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(846).png)


This script creates the `FarmInput` table, which tracks critical agricultural inputs and their stock status. It provides a validated inventory of farm inputs with automatic tracking of stock levels and built-in thresholds to support proactive restocking and operational continuity.



### 5. Trigger

![Trigger](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(847).png)


This trigger automatically updates the `ModifiedAt` timestamp in the `CropInventory` table whenever a record is updated. It helps maintain an accurate “last modified” timestamp for each crop record without requiring manual updates, supporting data audit trails and record version tracking.

**Key features:**
- **`AFTER UPDATE`**: Ensures the trigger runs only after a record in `CropInventory` has been modified.  
- **`SET NOCOUNT ON;`**: Improves performance by stopping extra “rows affected” messages from being sent.  
- **Update logic**:  
  - Joins the updated rows with the target table (`CropInventory`).  
  - Sets the `ModifiedAt` column to the current UTC date/time using `SYSUTCDATETIME()`.  



### 6. Stored Procedure

![Climate Price Analysis](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(849).png)


This procedure identifies farm inputs that are at or below their configured reorder threshold, flagging them for replenishment. It provides an operational alert mechanism to proactively manage input inventory and prevent stockouts by surfacing items needing restock.



### 7. Climate Expectation Price Analysis

![Climate expectation price](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(850).png)


This section first populates the `CropInventory` table with synthetic sample data, then performs an analytical comparison of expected crop prices based on farmers’ climate expectations. 
Then, inserts of crop inventory records with attributes such as crop type, variety, quantity harvested, whether the farmer expected climate extremes (`ClimateExpFlag`), and the expected sell price per kilogram. This makes the dataset usable for downstream analysis.
Grouping of the inserted crop records by `ClimateExpFlag` and computes:
- **Average Expected Price per Kg** (`AvgExpectedPricePerKg`) for each group, showing how price expectations differ between those who do and do not anticipate climate extremes.
- **CropCount**, the number of records in each group, to give context to the averages.

Comparing the two groups reveals whether climate expectation influences farmers to set higher or lower expected prices, indicating behavioral responses to perceived climate risk.




### 8. Farm Input Data Insertion

![Farm input data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(851).png)


This section inserts sample data into the `FarmInput` table to represent key agricultural inputs and their current stock levels relative to reorder thresholds.
**Key aspects:**
- Each row represents an input (e.g., fertilizer, seed, tools) with a unique `InputID` and descriptive `InputName`.  
- `QuantityUnits` shows current stock; constraints prevent negative values.  
- `UnitType` clarifies the measurement (e.g., Bag, Litre, Unit).  
- `ReorderThreshold` defines the level at or below which the input is considered for restocking.  
- This dataset is used by the stored procedure `usp_GetInputsNeedingRestock` to flag inputs that require attention, enabling proactive inventory management.



### 9. Analytical Summary & Restock Alert Execution

![Summary Restock Alert](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(852).png)


This section runs the core analytics and operational alert logic. The query groups crop inventory records by whether farmers expected climate extremes (`ClimateExpFlag`) and calculates:
- **Average Expected Price per Kg** (`AvgExpectedPricePerKg`): Shows the mean price farmers anticipate getting, segmented by climate expectation.  
- **CropCount**: Number of records in each group, providing context to the averages.



### 10. Synthetic Data Generation for CropInventory

![Synthetic Data Generation for CropInventory](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(857).png)


This script generates 500 synthetic `CropInventory` records to simulate realistic variability in crop types, varieties, quantities, harvest dates, climate expectations, and expected prices. It enables scaling the analysis beyond a few hand-entered rows. It provides a large, varied dataset so downstream analytical queries (e.g., price comparison and volatility) are meaningful and robust, demonstrating ability to simulate and work with real-world-like data without needing proprietary sources.

**What it does:**
- Loops from 1 to 500, creating unique `CropID`s like `CROP001`, `CROP002`, etc.  
- Cycles crop types among Maize, Rice, and Sorghum to diversify the dataset.  
- Alternates variety between "Hybrid" and "Local".  
- Assigns a random quantity between ~100kg and ~1600kg.  
- Picks a random recent harvest date within the last ~60 days.  
- Randomly sets `ClimateExpFlag` to 0 or 1 to simulate different farmer expectations.  
- Generates an expected sell price per kg between ~90 and 140 with randomness.



### 11. Price Comparison by Crop and Climate Expectation

![Analysis Query](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(859).png)


This query breaks down average expected sell prices and record counts by both crop type and whether the farmer anticipated climate extremes (`ClimateExpFlag`).

**What it shows:**
- How pricing expectations vary across different crops (e.g., Maize vs Rice) conditioned on climate expectation.
- The number of observations (N) underlying each average, giving context to reliability.



### 12. Weekly Price Trends by Climate Expectation

![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(862).png)


This query computes the average expected sell price per kilogram on a weekly basis, segmented by whether the farmer anticipated climate extremes (`ClimateExpFlag`).  
- `WeekStart` normalizes harvest dates into week buckets.  
- Allows observing temporal patterns or divergence in price expectations between the two groups over time.



 ### 13. Price Volatility by Climate Expectation

 ![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(862).png)



The second part of this query calculates the sample standard deviation of expected prices for each `ClimateExpFlag` group, measuring variability (volatility) in farmers' price expectations depending on whether they anticipate climate extremes.



### 14. Query Output – Climate Price Averages

![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(866).png)





### 13. Query Output – Climate Price Averages

![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(869).png)



### 13. Query Output – Climate Price Averages

![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(870).png)








## Schema Design Script

Below is the complete `create_schema.sql` used to set up the database schema for this project.


```sql
-- =====================================================
-- Agricultural Inventory & Climate-Expectation Database
-- Schema Design Script
-- Author: Lauren Akhidenor
-- Description: Creates core tables, constraints, and triggers
-- =====================================================

USE [checkpoint];
GO

IF OBJECT_ID(N'dbo.CropInventory', N'U') IS NOT NULL
    DROP TABLE dbo.CropInventory;
GO

IF OBJECT_ID(N'dbo.FarmInput', N'U') IS NOT NULL
    DROP TABLE dbo.FarmInput;
GO

CREATE TABLE dbo.CropInventory (
    CropID                 VARCHAR(50)      NOT NULL,
    CropName               NVARCHAR(100)    NOT NULL,
    Variety                NVARCHAR(100)    NULL,
    QuantityKg             DECIMAL(12,2)    NOT NULL
        CONSTRAINT CK_CropInventory_Quantity_NonNegative CHECK (QuantityKg >= 0),
    HarvestDate            DATE             NOT NULL,
    ClimateExpFlag         BIT              NOT NULL DEFAULT 0,
    ExpectedSellPricePerKg DECIMAL(12,2)    NULL,
    CreatedAt              DATETIME2        NOT NULL DEFAULT SYSUTCDATETIME(),
    ModifiedAt             DATETIME2        NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_CropInventory PRIMARY KEY (CropID)
);
GO

CREATE TABLE dbo.FarmInput (
    InputID          VARCHAR(50)     NOT NULL,
    InputName        NVARCHAR(100)   NOT NULL,
    QuantityUnits    INT             NOT NULL
        CONSTRAINT CK_FarmInput_Quantity_NonNegative CHECK (QuantityUnits >= 0),
    UnitType         NVARCHAR(50)    NOT NULL,
    ReorderThreshold INT             NOT NULL DEFAULT 10,
    CreatedAt        DATETIME2       NOT NULL DEFAULT SYSUTCDATETIME(),
    ModifiedAt       DATETIME2       NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_FarmInput PRIMARY KEY (InputID)
);
GO

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












