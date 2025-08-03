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




