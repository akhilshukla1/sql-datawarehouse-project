# Data Warehouse Project

## 📁 Project Name: Data Warehouse 

### 👤 Author: Akhil Shukla  
### 🗓️ Date: June 10, 2025 – June 28, 2025  
### 💻 Environment: Microsoft SQL Server

## 🧱 Architecture Layers
### 🥉 1. Bronze Layer (Raw Data)
- **Purpose**: Stores raw ingested data from source systems with minimal transformation.
- **Characteristics**:
  - Schema closely resembles source structure.
  - Acts as a backup or audit layer.
### 🥈 2. Silver Layer (Cleaned & Transformed Data)

- **Purpose**: Performs cleaning, deduplication, and transformation of raw data.
- **Implementation**:
  - Standardized tables with trimmed fields, proper data types, and valid business values.
  - Loaded using stored procedures like `silver.load_silver`.

#### Key Silver Tables:
| Table Name               | Description                           |
|--------------------------|---------------------------------------|
| `silver.crm_cust_info`   | Cleaned customer information          |
| `silver.erp_cust_az12`   | Enriched customer demographics        |
| `silver.erp_loc_a101`    | Location details                      |
| `silver.crm_prd_info`    | Cleaned product details               |
| `silver.erp_px_cat_g1v2` | Product category & maintenance        |
| `silver.crm_sales_details` | Transactional sales data             |

> ✅ Stored procedures ensure repeatable and safe data loading.

---

### 🟡 3. Gold Layer (Business-Ready Views)

- **Purpose**: Provides analytics-ready dimensional views and fact tables for BI/reporting tools.
- **Features**:
  - Use of `ROW_NUMBER()` for surrogate keys
  - Dimension and fact views
  - Joins between Silver tables for enrichment
  - Filters applied for current data where needed

#### Views Created in Gold Layer:
| View Name           | Type      | Description                                 |
|---------------------|-----------|---------------------------------------------|
| `gold.dim_customers`| Dimension | Combines CRM, ERP, and demographic data      |
| `gold.dim_products` | Dimension | Product details with category & cost         |
| `gold.fact_sales`   | Fact      | Sales transactions joined with dimensions    |

> ✅ Wrapped in `TRY...CATCH` blocks for safe execution  
> ✅ View recreation uses `OBJECT_ID(..., 'V')` and proper `GO` batch separation

---



## ⚙️ Key Technical Features

- `ROW_NUMBER()` used to generate stable surrogate keys
- `LEFT JOIN` logic to enrich customer/product/sales data
- Defensive coding with `TRY...CATCH` for error handling
- Business filters (e.g. active products with `prd_end_dt IS NULL`)
- Modular loading using procedures and separate layers

---

## 📄 Files Included

| File Name          | Layer   | Description                              |
|--------------------|---------|------------------------------------------|
| `silver.load_silver.sql` | Silver  | Stored procedure to load cleaned tables |
| `dld_gold.sql`           | Gold    | Script to build gold layer views       |

---

## ⚠️ Warnings

- Running `dld_gold.sql` will **drop and recreate** views. Avoid in live reporting environments without backups.
- ensure bronze layer is loaded before using silver layer
- Ensure Silver layer is loaded **before** running Gold layer scripts.

---



## 📬 Contact

**Akhil Shukla**  
✉️ shuklaakhil328@gmail.com 
📍 India

---

## ✅ Status: Completed and Tested ✅
