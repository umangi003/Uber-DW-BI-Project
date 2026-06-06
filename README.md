# 🚕 Uber Rides Data Warehouse & BI Project

## Overview
End-to-end Data Warehousing and Business Intelligence 
solution built using Uber ride data from Saint Petersburg, 
Russia (2015-2018).

**Module:** IT3021 - Data Warehousing & Business Intelligence  
**Institution:** Sri Lanka Institute of Information Technology (SLIIT)  
**Student:** Devagiri D.M.U.A | IT23537842

---

## 📊 Dataset
- **Source:** Uber personal ride history (Kaggle)
- **Records:** 7,678 trips (extended from 678 using Python)
- **Period:** 2015 - 2018
- **Location:** Saint Petersburg, Russia

---

## 🏗️ Architecture
### Data Sources
| Source | Format | Content |
|--------|--------|---------|
| uber-rides-extended.csv | CSV | Trip data |
| driver_data.xlsx | Excel | Driver details |
| weather_data | SQL Server | Weather conditions |

---

## ⭐ Star Schema
- **Fact Table:** Fact_Trip (7,678 rows)
- **Dimensions:** 
  - Dim_Date
  - Dim_Driver (SCD Type 2)
  - Dim_Vehicle
  - Dim_Location
  - Dim_Weather
  - Dim_Rider

---

## 🔧 Technologies Used
- Microsoft SQL Server
- SQL Server Integration Services (SSIS)
- SQL Server Management Studio (SSMS)
- Visual Studio Data Tools (SSDT)
- Python (data generation)
- Microsoft Excel

---

## 📦 Project Structure
---

## 🚀 How to Run

### Prerequisites
- SQL Server 2016 or higher
- Visual Studio with SSIS extension
- SQL Server Management Studio

### Steps
1. Run `SQL-Scripts/01_Create_Tables.sql`
2. Run `SQL-Scripts/02_Stored_Procedures.sql`
3. Execute `Uber_Load_Staging.dtsx`
4. Execute `Uber_Load_DW_Dims.dtsx`
5. Execute `Uber_Load_DW_Fact.dtsx`
6. Execute `Update_Accumulating_Fact.dtsx`

---

## 📈 Results

| Metric | Value |
|--------|-------|
| Total trips loaded | 7,678 |
| Completed trips | 7,570 |
| Cancelled trips | 108 |
| Unique drivers | 628+ |
| Cities covered | 3 |
| Date range | 2015-2018 |

---

## 🌟 Key Features

✅ Star Schema dimensional model  
✅ SCD Type 2 on Driver dimension  
✅ Accumulating fact table  
✅ Data profiling  
✅ 3 different source types (CSV, Excel, SQL)  
✅ Stored procedures for upsert logic  
✅ Foreign key constraints  
✅ ETL validation with row counts
