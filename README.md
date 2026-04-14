# SQL-Based Agricultural Inventory Management & Restock Automation System

## Overview
This project demonstrates the use of **Microsoft SQL Server (SSMS), T-SQL, and Power BI** to model agricultural inventory systems, simulate climate expectation signals, and build operational analytics for decision support.

It focuses on:
- Relational database design
- Inventory monitoring and restock automation
- Behavioral analysis of climate expectation signals
- Dashboard-based decision support using Power BI

> ⚠️ **Note on Data**:  
> The climate expectation and price data used in this project is **synthetically generated** to demonstrate database design, SQL logic, and analytical workflows.  
> The results are therefore **illustrative and not intended to represent real-world agricultural price behavior**.

---

## Skills Demonstrated
- SQL Server schema design (Primary Keys, constraints, defaults)
- Data integrity enforcement (CHECK constraints, triggers)
- Stored procedures for operational decision-making
- Automated auditability (ModifiedAt triggers)
- Aggregation and statistical analysis (mean, standard deviation, coefficient of variation)
- Conditional inventory alerting
- Power BI dashboard development

---

## Project Structure
- `sql/` → Schema, procedures, inserts, and analysis scripts  
- `screenshots/` → SSMS execution outputs and Power BI dashboard  
- `README.md` → Project documentation  

---

## Database Design

### Schema & Data Integrity
The database is designed to ensure:
- Unique identification via primary keys
- Prevention of invalid data (e.g., negative quantities)
- Automatic timestamp tracking (`CreatedAt`, `ModifiedAt`)
- Trigger-based audit updates for record changes

---

### Core Tables

#### CropInventory
Stores harvested crop data and pricing assumptions:
- Crop type and variety
- Harvest quantities
- Climate expectation flag
- Expected selling price per kg

#### FarmInput
Tracks agricultural inputs used in production:
- Fertilizers, seeds, and tools
- Stock levels
- Reorder thresholds for operational alerts

---

## Stored Procedure: Restock Alerts

This procedure identifies inputs that require replenishment.

```sql
CREATE OR ALTER PROCEDURE dbo.usp_GetInputsNeedingRestock
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        InputID,
        InputName,
        QuantityUnits,
        ReorderThreshold
    FROM dbo.FarmInput
    WHERE QuantityUnits <= ReorderThreshold;
END;
GO
```

## Stored Procedure: Restock Alerts

### Purpose:
- Enables proactive inventory management  
- Flags low-stock inputs for procurement decisions  
- Supports operational efficiency in farm management systems  

---

## Trigger Logic

Automatically updates modification timestamps:

- Ensures every update is tracked  
- Removes reliance on manual timestamp handling  
- Improves data reliability for auditing  

---

## Analytical Components

### Climate Expectation Price Analysis
Compares expected crop prices between farmers:
- With climate extreme expectations  
- Without climate extreme expectations  

---

### Price Volatility Analysis

| ClimateExpFlag | N   | AvgPrice | StdDev | Coefficient of Variation |
|----------------|-----|----------|--------|--------------------------|
| 0              | 248 | 114.09   | 14.28  | 0.1251                   |
| 1              | 262 | 114.13   | 14.83  | 0.1300                   |

**Interpretation:**
- Average prices are nearly identical across groups  
- Climate expectations introduce slightly higher uncertainty  
- Suggests behavioral variability rather than systematic price shifts  

---

## Power BI Dashboard

![PowerBI Dashboard Visualization](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(878).png)  


The Power BI dashboard consolidates:
- Crop inventory levels  
- Price comparisons by climate expectation  
- Temporal trends in expected prices  
- Restock alerts from SQL stored procedure outputs  

### Dashboard Features:
- Interactive filtering by crop type and climate flag  
- Time-based trend visualization (weekly aggregation)  
- Comparative price distribution views  
- Operational view of low-stock farm inputs  

**Business Value:**
- Supports procurement planning  
- Highlights inventory risk exposure  
- Enables monitoring of pricing behavior under uncertainty  

---

## Visual Outputs

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

### 13. Weekly Price Trends by Climate Expectation 
![Price Volatility by Climate Expectation](https://raw.githubusercontent.com/Lauren-Akhidenor/agro-inventory-climate-analysis/main/Screenshot%20(869).png)  
Shows Weekly Price Trends by Climate Expectation 

---

## Key Takeaways

- Strong relational database design with operational logic  
- Effective use of SQL automation (triggers + stored procedures)  
- Demonstrates ability to build end-to-end analytical systems  
- Bridges operational data (inventory) with behavioral signals (climate expectation)  

---

## Future Improvements

- Introduce foreign key relationships (e.g., linking crops to input usage or farmer entities)  
- Replace synthetic dataset with real agricultural survey or market data  
- Expand Power BI dashboard into a multi-role decision system  
- Add forecasting model for price or demand prediction  

---

## 👤 Author
Lauren Akhidenor


