# CP2: Baseline Query Timings

## 1. Objective

This benchmark establishes the baseline execution performance of the 30-query Instagram database workload before query and index optimization.

## 2. Benchmark Environment

- Database: PostgreSQL
- Server version: 18.4
- Client version: 18.3
- Database name: `instagram`
- Workload: `queries/workload_30.sql`
- Number of executions: 3 per query
- Measurement: `EXPLAIN (ANALYZE, BUFFERS)`
- Dataset: 1,308,446 rows across 9 tables

## 3. Methodology

The benchmark script executed all 30 workload queries three times each. Execution times were extracted from PostgreSQL's `Execution Time` reported by `EXPLAIN ANALYZE`. The average is calculated from the three measured executions. Read queries were executed normally. Write queries were wrapped in transactions and rolled back so that benchmark runs did not permanently modify the dataset.

## 4. Baseline Timings

All execution times are reported in milliseconds (ms).

| Query | Type | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) |
|---|---|---:|---:|---:|---:|
| R01 | READ | 9.761 | 8.720 | 9.452 | 9.311 |
| R02 | READ | 5.808 | 5.433 | 5.740 | 5.660 |
| R03 | READ | 0.093 | 0.074 | 0.060 | 0.076 |
| R04 | READ | 17.409 | 15.758 | 16.334 | 16.500 |
| R05 | READ | 19.935 | 21.401 | 19.539 | 20.292 |
| R06 | READ | 37.015 | 38.351 | 36.277 | 37.214 |
| R07 | READ | 15.700 | 13.953 | 13.604 | 14.419 |
| R08 | READ | 0.302 | 0.251 | 0.347 | 0.300 |
| R09 | READ | 5.594 | 4.661 | 6.432 | 5.562 |
| R10 | READ | 5.034 | 5.053 | 4.501 | 4.863 |
| R11 | READ | 10.763 | 10.753 | 10.970 | 10.829 |
| R12 | READ | 6.145 | 5.958 | 6.109 | 6.071 |
| R13 | READ | 44.546 | 47.456 | 50.849 | 47.617 |
| R14 | READ | 4.619 | 4.475 | 4.581 | 4.558 |
| R15 | READ | 65.266 | 58.734 | 61.412 | 61.804 |
| R16 | READ | 14.879 | 14.515 | 14.906 | 14.767 |
| R17 | READ | 17.939 | 17.217 | 18.635 | 17.930 |
| R18 | READ | 9.186 | 9.163 | 9.314 | 9.221 |
| R19 | READ | 11125.999 | 11475.650 | 11416.674 | 11339.441 |
| R20 | READ | 25.143 | 25.526 | 27.960 | 26.210 |
| R21 | READ | 7.910 | 7.492 | 7.968 | 7.790 |
| R22 | READ | 10.891 | 10.653 | 11.062 | 10.869 |
| R23 | READ | 0.059 | 0.056 | 0.055 | 0.057 |
| R24 | READ | 3.270 | 3.245 | 3.447 | 3.321 |
| W01 | WRITE | 1.253 | 0.976 | 0.865 | 1.031 |
| W02 | WRITE | 1.044 | 1.075 | 1.068 | 1.062 |
| W03 | WRITE | 0.847 | 0.221 | 0.236 | 0.435 |
| W04 | WRITE | 144.605 | 133.156 | 136.589 | 138.117 |
| W05 | WRITE | 24.436 | 29.704 | 15.438 | 23.193 |
| W06 | WRITE | 5.236 | 4.967 | 4.899 | 5.034 |

## 5. Performance Observations

- The slowest read query was **R19**, with an average execution time of **11339.441 ms**.
- The slowest write query was **W04**, with an average execution time of **138.117 ms**.
- Execution times vary across queries depending on the amount of data scanned, joins, sorting, filtering, and index usage.
- Sequential scans appear in several query plans. Their presence is not automatically inefficient; PostgreSQL may choose them when scanning a large portion of a table is cheaper than using an index.

## 6. Result Files

- `benchmarks/results/baseline/summary.csv`: aggregated timing results.
- `benchmarks/results/baseline/R01.txt` through `R24.txt`: raw read-query plans.
- `benchmarks/results/baseline/W01.txt` through `W06.txt`: raw write-query plans.

## 7. Conclusion

The baseline benchmark completed successfully for all 30 workload queries, with three executions per query. These measurements provide a reference point for evaluating the performance impact of subsequent database optimizations.
