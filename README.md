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
Crop and input inventories are modeled with constraints to prevent invalid states.  
```sql
CONSTRAINT CK_CropInventory_Quantity_NonNegative CHECK (QuantityKg >= 0)

### 2. Climate Expectation Price Analysis
Aggregates expected sell price by whether farmers anticipate climate extremes:

sql
Copy
Edit
SELECT 
    ClimateExpFlag,
    AVG(ExpectedSellPricePerKg) AS AvgPrice,
    STDEV(ExpectedSellPricePerKg) AS SampleStdDev,
    CASE 
        WHEN AVG(ExpectedSellPricePerKg) = 0 THEN NULL 
        ELSE STDEV(ExpectedSellPricePerKg) / AVG(ExpectedSellPricePerKg) 
    END AS CoefficientOfVariation
FROM dbo.CropInventory
GROUP BY ClimateExpFlag;

### 3. Operational Alerting
Stored procedure flags farm inputs needing restock:

sql
Copy
Edit
EXEC dbo.usp_GetInputsNeedingRestock;


