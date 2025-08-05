# 🌾 Agricultural Inventory & Climate-Expectation Analysis

## 📌 Overview
This project demonstrates **Microsoft SQL Server, SMSS, T-SQL and Power BI** skills by modeling agricultural inventory, incorporating farmers’ climate expectation signals, and building both analytical and operational logic to inform decisions.

## 🛠 Skills Demonstrated
- 🗄 Schema design with primary keys & constraints  
- ✅ Data integrity enforcement (CHECK constraints, defaults)  
- 🔄 Auditability via triggers (automatic ModifiedAt updates)  
- ⚙ Stored procedure creation (`usp_GetInputsNeedingRestock`)  
- 📈 Aggregation & comparison queries  
- 📉 Statistical summary (average, volatility, coefficient of variation)  
- 🚨 Conditional alerting for inventory restock
- 📈 Dashboard visualization

## 📂 Project Structure
- **sql/**: T-SQL scripts (schema, inserts, procedures, analysis)  
- **screenshots/**: Proof-of-execution (SSMS outputs, schema design, query logic and power BI dashboard)

---

## 🧩 Key Components

### 1. Schema & Data Integrity  
Implements a relational design to manage crop inventory and farm inputs with built-in protections:  
- 🔑 Primary keys for unique identification  
- 🚫 CHECK constraints to prevent invalid values (e.g., no negative quantity)  
- 🕒 DEFAULT timestamps (`CreatedAt`, `ModifiedAt`)  
- 🔁 Triggers to keep `ModifiedAt` accurate automatically  

### 2. Database Reset Script  
Ensures a clean start before schema creation:  
- `USE [checkpoint]` selects the target database  
- Conditional `DROP TABLE` avoids errors on reruns  
- `GO` batches ensure proper execution order  

### 3. CropInventory Table  
Holds crop harvest details, climate expectation flag, and expected sell price—enabling downstream price analysis and segmentation.

### 4. FarmInput Table  
Tracks essential inputs (fertilizer, seed, tools) with stock levels and reorder thresholds for operational alerts.

### 5. Trigger Automation  
Automatically updates `ModifiedAt` on updates to maintain auditability without manual intervention.

### 6. Stored Procedure: Restock Alerts  
`usp_GetInputsNeedingRestock` flags inputs at or below their reorder threshold to support proactive replenishment.

### 7. Climate Expectation Price Analysis  
Compares expected crop prices between farmers expecting climate extremes versus those who do not, surfacing behavioral pricing signals.

### 8. Synthetic Data Generation  
Generates 500 realistic `CropInventory` records to scale analysis and simulate variability in crop type, harvest timing, climate expectation, and pricing.

### 9. Temporal & Volatility Analysis  
- Weekly trend of average expected price segmented by climate flag  
- Price volatility and coefficient of variation to assess stability of expectations  

---

## 🔍 Key Insights
- Farmers expecting climate extremes show slightly more uncertainty in price expectations.  
- Mean expected prices remain similar, but volatility is marginally higher when climate extremes are anticipated.  
- Restock alerts operationalize inventory health, preventing stockouts.

---

## 🖼 Snapshot of Scripts & Outputs

### 1. Schema Design  
![Schema Design](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(853).png)  
Defines table structures, constraints, defaults, and triggers for data integrity and auditability.

### 2. Database Reset Script  
![Database reset script](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(844).png)  
Safe drop-and-create logic to ensure reproducible schema setup.

### 3. CropInventory Table Creation  
![Crop Inventory Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(845).png)  
Stores harvested crop details, climate expectation, and pricing.

### 4. Farm Input Table  
![Farm Input Data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(846).png)  
Tracks inputs, quantities, and reorder thresholds.

### 5. Trigger Logic  
![Trigger](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(847).png)  
Auto-updates `ModifiedAt` for audit trails.

### 6. Stored Procedure / Restock Alert  
![Stored Procedure Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(849).png)  
Executes low-stock detection logic.

### 7. Climate Expectation Price Analysis  
![Climate expectation price](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(850).png)  
Compares average expected prices by climate flag.

### 8. Farm Input Sample Data  
![Farm input data](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(851).png)  
Sample inventory used for restock logic.

### 9. Analytical Summary & Restock Alert Execution  
![Summary Restock Alert](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(852).png)  
Combined output for price comparison and alerting.

### 10. Synthetic Data Generation  
![Synthetic Data Generation for CropInventory](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(857).png)  
Bulk data generation to enable robust analytics.

### 11. Price Comparison by Crop & Climate  
![Analysis Query](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(859).png)  
Breaks down expected prices by crop type and climate expectation.

### 12. Weekly Price Trends  
![Weekly Price Trends by Climate Expectation](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(862).png)  
Time series comparison of expected prices.


---

## 📌 Results Table:


### 1. Weekly Price Trends by Climate Expectation 
![Price Volatility by Climate Expectation](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(869).png)  
Shows Weekly Price Trends by Climate Expectation 



### 2. Price Volatility & Stability by Climate Expectation 

| ClimateExpFlag | N   | AvgPrice | Price StdDev | Coefficient of Variation |
|----------------|-----|----------|--------------|--------------------------|
| 0              | 248 | 114.09   | 14.28        | 0.1251                   |
| 1              | 262 | 114.13   | 14.83        | 0.1300                   |

**What the numbers mean:**  
- **AvgPrice**: Nearly same expected price regardless of climate expectation.  
- **Price StdDev**: Slightly higher spread when extremes are expected.  
- **Coefficient of Variation**: Relative uncertainty is marginally larger for those expecting extremes.

**Interpretation:**  
Pricing expectations are stable, but climate concern introduces a bit more variability—suggesting uncertainty rather than a consistent shift in valuation.


### 3. Power BI Dashboard Visualization:

![PowerBI Dashboard Visualization](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(878).png)  



---

## 🧪 Schema Design Script

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
