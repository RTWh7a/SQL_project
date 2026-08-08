# SQL_project
# 📊 Tech Layoffs Data Cleaning & Exploratory Data Analysis (SQL)

## 📌 Project Overview
This project presents an end-to-end data cleaning and exploratory data analysis (EDA) pipeline built in **MySQL** using raw tech layoff data. The goal of this project was to transform messy, unorganized raw data into a structured, clean dataset ready for analytical insights and reporting.

---

## 🛠️ Key SQL Techniques & Concepts Used
* **Data Staging & Preservation:** Created staging tables (`layoffs_staging`, `layoffs_staging2`) to ensure raw data integrity.
* **Window Functions & CTEs:** Used `ROW_NUMBER() OVER(PARTITION BY ...)` inside Common Table Expressions (CTEs) to detect and purge duplicate records.
* **Data Standardization:** 
  * Cleaned whitespace issues using `TRIM()`.
  * Normalized inconsistent category names (e.g., standardizing variations of `Crypto`).
  * Fixed trailing syntax issues (`TRIM(TRAILING '_' FROM country)`).
  * Converted string formatted dates into standard MySQL `DATE` format using `STR_TO_DATE()` and `ALTER TABLE`.
* **Handling Missing Values:** Applied self-joins (`JOIN`) to populate missing `industry` data using non-null entries from identical companies.
* **Database Optimization:** Dropped temporary auxiliary columns (`row_num`) and removed unusable records lacking critical metrics.
* **Exploratory Data Analysis (EDA):** Aggregated metrics using `GROUP BY`, `ORDER BY`, `SUM()`, `MIN()`, and `MAX()` to identify top affected companies, industries, and overall timelines.

---

## 🚀 Key Insights & Findings
1. **Top Impacted Industries:** Identified key sectors with the highest total headcount reductions.
2. **Geographic Trends:** Ranked total layoffs across countries to pinpoint regional impacts.
3. **Company Highlights:** Uncovered specific firms with 100% workforce layoffs (`percentage_laid_off = 1`).

---

## 📁 Repository Structure
* `layoffs.csv` — Raw input dataset
* `layoffs_data_cleaning.sql` — MySQL script containing full data transformation logic and EDA queries
* `README.md` — Project overview and documentation
