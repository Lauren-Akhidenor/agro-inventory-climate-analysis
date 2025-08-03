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

## Example Outputs

### 1. Schema Design
![Schema Design](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(844).png)

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
![Insert Data Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(853).png)

### 11. Trigger Definition
![Trigger Code](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(857).png)

### 12. Query to Compare Climate Flags
![Analysis Query](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(859).png)

### 13. Query Output – Restock Alerts
![Restock Alert Output](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(862).png)

### 14. Query Output – Climate Price Averages
![Climate Price Averages](https://raw.githubuserc)


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


