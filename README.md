# SQL Sales Performance Analysis: Detecting Sales Order Outliers

This project was developed as part of the **DQLab SQL Hackathon 2026**.

The objective is to identify abnormal sales transactions (outliers) using the **Z-Score** method with **MySQL 5.7**. Instead of comparing all transactions together, each transaction is evaluated within its corresponding **Level-2 Sales Manager** group, ensuring a more meaningful statistical comparison.

---

## Business Problem

PT XYZ observed that purchase orders appeared healthy, yet overall sales performance remained stagnant.

One possible explanation was an uneven distribution of sales transactions across different sales teams. To investigate this issue, statistical analysis was performed to identify unusually high or low sales transactions that may require further investigation.

---

## Objectives

- Map each sales transaction to its corresponding **Level-2 Sales Manager**.
- Calculate the **Average (Mean)** and **Population Standard Deviation** for each group.
- Compute the **Z-Score** of every transaction.
- Detect outliers using the **3-Sigma Rule**.
- Produce summary and detailed anomaly reports.

---

## Dataset

The analysis uses two tables provided in the SQL Hackathon dataset.

| Table | Description |
|--------|-------------|
| `nodes` | Organizational hierarchy of sales employees |
| `orders` | Sales order transactions |

---

## SQL Techniques Used

- Self Join
- LEFT JOIN
- INNER JOIN
- CASE WHEN
- Temporary Tables
- Aggregate Functions (`AVG`, `STDDEV_POP`, `COUNT`)
- GROUP BY
- UNION ALL
- Z-Score Calculation

---

## Analysis Results

The analysis successfully detected **20 abnormal sales transactions** across **4 Level-2 Sales Manager groups**.

| Level-2 Sales Manager | Number of Outliers |
|-----------------------|-------------------:|
| N0548 | 5 |
| N0549 | 3 |
| N0550 | 3 |
| N0551 | 9 |

### Key Findings

- **N0551** recorded the highest number of detected outliers (**9 transactions**).
- Both unusually high and unusually low sales transactions were identified.
- Transactions were compared only within the same managerial group, making the analysis fair despite differences in sales volume.

---

## Business Impact

This analysis helps management quickly identify abnormal sales transactions that deserve further investigation.

Potential business insights include:

- Exceptional sales performance
- Unusually large customer orders
- Data quality issues
- Irregular sales patterns

Instead of reviewing every transaction manually, management can focus on statistically significant anomalies.

---

## 📄 Results

The complete analysis results are available in the **`results/`** folder:

| File | Description |
|------|-------------|
| `summary.csv` | Summary of detected outliers for each Level-2 Sales Manager |
| `outliers.csv` | Detailed outlier transactions, including Average, Standard Deviation, Distance from Mean, and Z-Score |
| `output.csv` | Final output combining both summary and detailed anomaly reports |

---

## Hackathon Achievement

**DQLab SQL Hackathon 2026**

- Top 100 Finalist
- Rank **#39 of 194 Participants**
- Score **100 (Honors)**

### Certificate

![Certificate](images/certificate-DQLABHCK100V3UNLQJM.pdf)

---

## 👩‍💻 Author

**Tantri Silaen**

Bachelor of Applied Software Engineering

Aspiring Data Analyst | Data Scientist
