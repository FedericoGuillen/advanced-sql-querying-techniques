# Advanced SQL Querying Techniques

![SQL](https://img.shields.io/badge/SQL-Advanced-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Compatible-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Compatible-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-2E8B57?style=for-the-badge)

## Overview

This repository documents my work from the **SQL for Data Analysis: Advanced SQL Querying Techniques** course by **Maven Analytics** on Udemy.

The project focuses on advanced SQL techniques used in data analysis and business intelligence, including multi-table analysis, subqueries, Common Table Expressions, window functions, data-type functions, rolling calculations, and analytical problem-solving.

The course concludes with a practical **Major League Baseball (MLB) analysis project**, using historical player and salary data to examine how player attributes and compensation changed across teams and over time.

> This repository is part of my Data Analytics portfolio and demonstrates my ability to work with relational datasets, write structured analytical queries, and translate business questions into SQL solutions.

---

## Table of Contents

- [Skills Demonstrated](#skills-demonstrated)
- [Course Topics](#course-topics)
- [Final Project](#final-project)
- [Datasets](#datasets)
- [Repository Structure](#repository-structure)
- [Example SQL Patterns](#example-sql-patterns)
- [How to Use This Repository](#how-to-use-this-repository)
- [Key Learning Outcomes](#key-learning-outcomes)
- [Tools and Technologies](#tools-and-technologies)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

---

## Skills Demonstrated

- Advanced SQL querying
- Multi-table analysis
- Relational database analysis
- Data cleaning and transformation
- Business-oriented data exploration
- Trend and time-series analysis
- Ranking and segmentation
- Running totals and rolling calculations
- Duplicate detection
- Query organization and readability
- Analytical problem-solving

---

## Course Topics

### 1. SQL Fundamentals Review

Review of the main SQL query clauses and commonly used keywords:

- `SELECT`
- `FROM`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `DISTINCT`
- `LIMIT`

### 2. Multi-Table Analysis

Combining and comparing data stored across multiple tables using:

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- Self joins
- `CROSS JOIN`
- `UNION` and `UNION ALL`

### 3. Subqueries and Common Table Expressions

Using nested queries and reusable query blocks to simplify complex analysis:

- Subqueries in `SELECT`, `FROM`, `WHERE`, and `HAVING`
- Correlated subqueries
- Standard CTEs
- Multiple CTEs
- Recursive CTEs
- Comparison of CTEs, temporary tables, and views

### 4. Window Functions

Performing calculations across related rows without reducing the result set:

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `FIRST_VALUE()`
- `LEAD()`
- `LAG()`
- `PARTITION BY`
- Window ordering and frames

### 5. Functions by Data Type

Applying SQL functions to different types of data:

- Numeric functions
- Date and time functions
- String functions
- NULL-handling functions
- Type conversion and formatting

### 6. Data Analysis Applications

Applying advanced SQL techniques to realistic analytical scenarios:

- Pivoting and reshaping data
- Duplicate detection and removal
- Special-value filtering
- Running totals
- Rolling calculations
- Period-over-period comparisons
- Ranking and trend analysis

---

## Final Project

### Major League Baseball Analysis

The capstone project uses historical MLB data to analyze how player statistics changed over time and across teams.

### Main analytical objectives

- Track player salary trends over time
- Compare player compensation across teams and seasons
- Analyze changes in player height and weight
- Rank players within specific years or groups
- Compare current records with previous or following periods
- Combine player, salary, school, and team-related information
- Produce clear analytical outputs using advanced SQL techniques

### SQL concepts applied

- Multi-table joins
- Subqueries
- Common Table Expressions
- Window functions
- Aggregate functions
- Date calculations
- Ranking functions
- Historical comparisons using `LEAD()` and `LAG()`

---

## Datasets

The course materials include datasets covering topics such as:

- MLB players
- Player salaries
- Schools and school details
- Customers
- Orders
- Products
- Country statistics
- Happiness scores
- Inflation rates

The repository also includes database creation scripts for PostgreSQL and MySQL where available.

> Dataset names and availability may vary by course section. Course-provided data is included only for educational and portfolio demonstration purposes.

---

## Repository Structure

```text
advanced-sql-querying-techniques/
|
|-- Advanced+SQL+Querying/
|   |-- Course Materials/
|       |-- Assignments/
|       |-- Data/
|       |-- Demos/
|
|-- README.md
```

Important SQL setup files within the course materials include:

```text
create_statements.sql
create_statements_mysql.sql
create_statements_final_project.sql
create_statements_final_project_mysql.sql
```

---


---

## How to Use This Repository

### PostgreSQL

1. Clone the repository:

```bash
git clone https://github.com/FedericoGuillen/advanced-sql-querying-techniques.git
```

2. Open **pgAdmin** or **psql**.
3. Create a new database for the project.
4. Run the appropriate PostgreSQL creation script:

```text
create_statements.sql
```

For the final project, use:

```text
create_statements_final_project.sql
```

5. Open the demo or assignment SQL files and execute the queries section by section.

### MySQL

Use the corresponding MySQL scripts:

```text
create_statements_mysql.sql
create_statements_final_project_mysql.sql
```

The exact import process may vary depending on whether MySQL Workbench or another SQL client is used.

---

## Key Learning Outcomes

By completing this project, I strengthened my ability to:

- Write complex SQL queries for analytical use cases
- Combine information from multiple relational tables
- Break complex logic into readable CTEs
- Use subqueries in different parts of a SQL statement
- Apply window functions for rankings and historical comparisons
- Perform rolling and period-over-period calculations
- Explore datasets and answer business-oriented questions
- Organize SQL code for readability and maintainability
- Work with PostgreSQL and MySQL-compatible scripts

---

## Tools and Technologies

- SQL
- PostgreSQL
- pgAdmin
- MySQL
- MySQL Workbench
- Git
- GitHub
- Relational databases
- Data analysis
- Business intelligence concepts

---

## Future Improvements

- Reorganize completed queries into dedicated topic folders
- Add screenshots of important query results
- Document the main findings from the MLB final project
- Add an entity-relationship diagram for the final-project database
- Include separate PostgreSQL and MySQL execution notes
- Add a portfolio-ready case study summarizing the business questions, methods, and insights

---

## Author

**Federico Guillen D'Auri**  
Associate Business Intelligence Analyst

- [GitHub](https://github.com/FedericoGuillen)

---

## Acknowledgments

Course: **SQL for Data Analysis: Advanced SQL Querying Techniques**  
Provider: **Maven Analytics**  
Platform: **Udemy**

The course content and original datasets belong to their respective owners. This repository is maintained as a personal educational project and portfolio demonstration.
