/*
Project     : SQL Hackathon 2026
Title       : Discovering Sales Performance Root Cause Analysis
Author      : Tantri Silaen

Description
This project detects abnormal sales transactions (outliers) by calculating
the Average, Population Standard Deviation (STDDEV_POP), and Z-Score for
each Level-2 Sales Manager.

Business Background
PT XYZ observed that purchase orders appeared healthy, but actual sales
performance stagnated. One possible cause was an uneven distribution of
orders among field sales representatives.

Instead of evaluating all transactions together, each transaction is
compared only with other transactions belonging to the same Level-2
Sales Manager.

Methodology
1. Map each sales transaction to its corresponding Level-2 Sales Manager.
2. Calculate Average and Population Standard Deviation for each group.
3. Compute the Z-Score of every transaction.
4. Detect transactions outside Mean ± (3 × Standard Deviation).
5. Generate both summary and detailed anomaly reports.

Output
1. Summary of detected anomalies by Level-2 Sales Manager.
2. Detailed list of outlier transactions with statistical information.

Limitations
This solution follows the MySQL 5.7 constraints used in the SQL Hackathon:
- No Common Table Expressions (CTE)
- No Window Functions
- No Recursive Queries
- Temporary tables are used to simplify the implementation.
*/


/*
STEP 0
Clean up any existing temporary tables from previous executions.
*/
DROP TEMPORARY TABLE IF EXISTS tmp_leaf_l2;
DROP TEMPORARY TABLE IF EXISTS tmp_stats;
DROP TEMPORARY TABLE IF EXISTS tmp_outliers;
DROP TEMPORARY TABLE IF EXISTS tmp_summary;

/* 
STEP 1
Map each sales transaction to its corresponding Level-2 Sales Manager.

Business Rule:
Each sales transaction originates from a leaf node. The organization
hierarchy is traversed upward until the first node directly below ROOT
(Level-2 Sales Manager) is identified.

This mapping ensures that every transaction is compared only with
transactions within the same managerial group.
*/

CREATE TEMPORARY TABLE tmp_leaf_l2 AS
SELECT
    o.node_id AS leaf_id,
    o.nilai_order,
    
    /* Traverse the hierarchy until the Level-2 Sales Manager is found */
    CASE
        WHEN n1.parent_id = 'ROOT' THEN n1.id
        WHEN n2.parent_id = 'ROOT' THEN n2.id
        WHEN n3.parent_id = 'ROOT' THEN n3.id
        WHEN n4.parent_id = 'ROOT' THEN n4.id
        WHEN n5.parent_id = 'ROOT' THEN n5.id
    END AS level2
FROM orders o

/* Traverse hierarchy upward */
LEFT JOIN nodes AS n1 
	ON n1.id = o.node_id

LEFT JOIN nodes AS n2 
	ON n2.id = n1.parent_id

LEFT JOIN nodes AS n3 
	ON n3.id = n2.parent_id

LEFT JOIN nodes AS n4 
	ON n4.id = n3.parent_id

LEFT JOIN nodes AS n5 
	ON n5.id = n4.parent_id;

/*
STEP 2
Calculate statistical metrics for each Level-2 Sales Manager.

Business Rule:
Each transaction is evaluated only against other transactions
within the same Level-2 Sales Manager group.

The calculated statistics are:
- Average (Mean)
- Population Standard Deviation (STDDEV_POP)

These values are used to calculate the Z-Score in the next step.
*/
CREATE TEMPORARY TABLE tmp_stats AS

SELECT
    level2,

    /* Mean order value */
    AVG(nilai_order) AS average,

    /* Population standard deviation */
    STDDEV_POP(nilai_order) AS stdev

FROM tmp_leaf_l2

GROUP BY
    level2;

/*
STEP 3
Detect outlier transactions using the Z-Score method.

Business Rule:
A transaction is classified as an outlier when its value falls
outside the range:

    Mean ± (3 × Standard Deviation)

For every detected outlier, the following information is stored:
- Transaction value
- Group average
- Group standard deviation
- Distance from the average
- Z-Score
*/
CREATE TEMPORARY TABLE tmp_outliers AS

SELECT
    leaf.level2,
    leaf.leaf_id AS id,
    leaf.nilai_order,

    stat.average,
    stat.stdev,

    /* Distance from the group average */
    leaf.nilai_order - stat.average AS jarak_average,

    /* Z-Score = (X - Mean) / Standard Deviation */
    (leaf.nilai_order - stat.average) / stat.stdev AS z_score

FROM tmp_leaf_l2 AS leaf

INNER JOIN tmp_stats AS stat
    ON stat.level2 = leaf.level2

/* Detect values outside Mean ± (3 × Standard Deviation) */
WHERE
       leaf.nilai_order > stat.average + (3 * stat.stdev)
    OR leaf.nilai_order < stat.average - (3 * stat.stdev);
     
     
/*
STEP 4
Generate a summary report of detected anomalies.

Business Rule:
Count the total number of outlier transactions
for each Level-2 Sales Manager.
*/
CREATE TEMPORARY TABLE tmp_summary AS

SELECT
    level2,

    /* Number of detected outlier transactions */
    COUNT(*) AS jumlah_anomali

FROM tmp_outliers

GROUP BY
    level2;

/*
STEP 5
Generate the final output.

Output Format:
1. Summary rows
2. Detailed outlier records

UNION ALL is used to combine both outputs into
a single result set, following the hackathon specification.
*/

SELECT
    level2,
    jumlah_anomali,

    NULL AS id,
    NULL AS nilai_order,
    NULL AS average,
    NULL AS stdev,
    NULL AS jarak_average,
    NULL AS z_score

FROM tmp_summary

UNION ALL

SELECT
    level2,

    NULL AS jumlah_anomali,

    id,
    nilai_order,
    average,
    stdev,
    jarak_average,
    z_score

FROM tmp_outliers

ORDER BY
    level2,
    jumlah_anomali DESC,
    id;

SELECT *
FROM tmp_summary
ORDER BY level2;

SELECT *
FROM tmp_outliers
ORDER BY level2, ABS(z_score) DESC;
