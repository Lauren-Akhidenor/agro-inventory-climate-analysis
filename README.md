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
[View create_schema.sql here](https://github.com/Lauren-Akhidenor/agro-inventory-climate-analysis/blob/main/sql/create_schema.sql)










