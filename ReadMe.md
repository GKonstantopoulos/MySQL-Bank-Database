# 🏦 Banking System Database Management
A comprehensive MySQL database project designed to manage core banking operations, including branch management, customer accounts, and credit card transaction processing

# 📌 Project Overview
This project implements a relational database schema for a banking environment. It features data integrity through constraints, normalized tables (3NF), and automated business logic using SQL Triggers.


## 📈 Entity-Relationship Diagram
![ERD Diagram](images/ERD_GlobalBank.png)

## 📝 Scripts Overview
1. [Database Schema](sql_scripts/01_schema.sql)
2. [Triggers](sql_scripts/02_triggers.sql)
3. [Indexes](sql_scripts/03_indexes.sql)
4. [Views](sql_scripts/04_views.sql)
5. [Stored Procedures](sql_scripts/05_stored_procedures.sql)
6. [Data Insertion](sql_scripts/06_data_insertion.sql)
7. [Analytical Queries](sql_scripts/07_analytical_queries.sql)
8. [Transactions](sql_scripts/08_transactions.sql)


## 🛠️ Key Features
- **Relational Mapping**: Implements 1:N and M:N relationships (e.g., Joint Accounts between multiple customers).

- **Lookup Tables**: Enforce referential integrity and follow 3rd Normal Form.

- **Transaction Automation**: BEFORE INSERT trigger to validate credit card transactions.

- **Data Integrity**: Foreign Keys with ON DELETE SET NULL/CASCADE and CHECK constraints for financial amounts.

- **Scalable Design**: Separate lookup tables for cities, branch types, and employee roles.


## 📊 Database Schema (Conceptual Model)
Based on Chen Notation. Key entities & relationships:

### Entities & Attributes
- **Customer**: Stores personal details with a unique Tax ID (cust_tax_no).

- **Account**: Handles balances and overdraft limits.

- **Credit Card**: Tracks balances, credit limits, and cash withdrawal limits.

- **Employee/Branch**: Manages the bank's organizational structure.


### Relationships
1. **Bank → Branch (1:N)**: Each bank operates multiple branches.

2. **Customer → Account (N:M)**: Via tbl_cust_account junction table for multiple owners.

3. **Customer → Credit Card (1:N)**: Single customer can hold multiple credit cards.

4. **Credit Card → Transaction (1:N)**: Every transaction linked to a specific card.


## 🚦 SQL Triggers
- **before_transaction_insert**: Checks if credit card has sufficient balance before purchase. If insufficient, raises a "SIGNAL SQLSTATE '45000'" and cancels the transaction.

