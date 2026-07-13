# SQL Sales Performance Analysis: Detecting Sales Order Outliers

## Overview

This project was developed as part of the **DQLab SQL Hackathon 2026**.

The objective is to identify abnormal sales transactions (outliers) using statistical analysis with SQL. Rather than comparing all transactions together, each transaction is evaluated within its corresponding **Level-2 Sales Manager** group, ensuring a more accurate and meaningful comparison.

This project demonstrates SQL skills, statistical analysis, and business problem-solving using **MySQL 5.7**.

---

## Business Problem

PT XYZ observed that purchase orders appeared healthy, yet overall sales performance remained stagnant.

One possible cause was an uneven distribution of sales transactions among field sales representatives.

To investigate this issue, sales transactions were analyzed to detect unusually high or low order values that may indicate abnormal sales behavior.

---

## Objectives

- Map each sales transaction to its corresponding Level-2 Sales Manager.
- Calculate Average (Mean) for each manager group.
- Calculate Population Standard Deviation (`STDDEV_POP`).
- Compute the Z-Score of each transaction.
- Detect outlier transactions using the **3-Sigma Rule**.
- Generate both summary and detailed anomaly reports.

---

## Dataset

The hackathon dataset consists of two tables.

### `nodes`

Stores the organizational hierarchy.

| Column | Description |
|---------|-------------|
| id | Employee ID |
| parent_id | Parent node |

### `orders`

Stores sales order transactions.

| Column | Description |
|---------|-------------|
| no_urut | Transaction ID |
| node_id | Sales ID |
| nilai_order | Order Value |

---

## SQL Techniques Used

- Temporary Tables
- Self Join
- LEFT JOIN
- INNER JOIN
- CASE WHEN
- Aggregate Functions
- GROUP BY
- UNION ALL
- Population Standard Deviation (`STDDEV_POP`)
- Z-Score Calculation

---

## Statistical Formula

### Z-Score

```text
Z = (X − μ) / σ
```

Where:

- **X** = Transaction value
- **μ** = Average order value
- **σ** = Population Standard Deviation

Transactions outside

```text
Mean ± (3 × Standard Deviation)
```

are classified as outliers.

---

## Project Structure

```
sql-sales-performance-analysis/
│
├── sql/
│   └── jawaban.sql
│
├── images/
│
├── README.md
└── LICENSE
```

---

## Skills Demonstrated

- SQL
- MySQL
- Data Analysis
- Statistical Analysis
- Business Analytics
- Root Cause Analysis
- Hierarchical Data Processing

---

## Hackathon Achievement

**DQLab SQL Hackathon 2026**

- Top 100 Finalist
- Rank **#39 of 194 Participants**
- Score **100 (Honors)**

---

## Author

**Tantri Silaen**

Bachelor of Applied Software Engineering

Aspiring Data Analyst | Data Scientist
