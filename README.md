# Analysis of Film and Music Sales for Media Distributors, Inc.

**Author:** Karan Badlani
**Semester:** Spring 2025
**Prepared for:** Media Distributors, Inc.
**Prepared by:** Oakland Partners

## Project Overview

This project implements an analytical datamart to analyze sales performance for Media Distributors, Inc. It integrates data from two operational systems: a film rental system and a music sales system. The goal is to provide data-driven insights through a Star Schema design in a MySQL database, enabling efficient querying and reporting on revenue, units sold, and customer metrics across different dimensions (time, country, media type).

## Repository Contents

*   **`createStarSchema.PractII.BadlaniK.R`**: R script that connects to the MySQL database and initializes the Star Schema tables (`dim_date`, `dim_country`, `dim_type`, `fact_sales`). It drops existing tables before creating new ones.
*   **`loadAnalyticsDB.PractII.BadlaniK.R`**: R script that performs ETL (Extract, Transform, Load) operations. It extracts data from the SQLite databases (`film-sales.db`, `music-sales.db`), transforms it (e.g., date normalization), and loads it into the MySQL Star Schema tables.
*   **`BusinessAnalysis.PractII.BadlaniK.Rmd`**: R Markdown file that connects to the populated MySQL datamart and generates an analytical report. It includes queries for yearly revenue, top countries by units/customers, and summary statistics.
*   **`film-sales.db`**: SQLite database containing operational data for film rentals (tables: `rental`, `payment`, `customer`, `address`, `city`, `country`).
*   **`music-sales.db`**: SQLite database containing operational data for music sales (tables: `invoices`, `customers`, `invoice_items`).
*   **`PracticumII.Rproj`**: RStudio Project file.
*   **`SandBoxScript_BadlaniK.R`**: A sandbox script for testing code snippets.

## Prerequisites

To run this project, you need the following:

1.  **R and RStudio** installed.
2.  **MySQL Database**: Access to a MySQL database server.
    *   *Note: The scripts currently contain hardcoded credentials for an AWS RDS instance. You may need to update the connection details in the scripts to point to your own MySQL instance.*
3.  **R Packages**: The following R libraries are required:
    *   `DBI`
    *   `RMySQL`
    *   `RSQLite`
    *   `lubridate`
    *   `knitr`
    *   `kableExtra`

## Setup and Usage Instructions

Follow these steps to set up the datamart and generate the analysis:

1.  **Install Dependencies**: Ensure all required R packages are installed.
    ```R
    install.packages(c("DBI", "RMySQL", "RSQLite", "lubridate", "knitr", "kableExtra"))
    ```

2.  **Create the Schema**:
    Run the `createStarSchema.PractII.BadlaniK.R` script. This will connect to the MySQL database and create the necessary empty tables for the Star Schema.
    ```R
    source("createStarSchema.PractII.BadlaniK.R")
    ```

3.  **Load the Data**:
    Run the `loadAnalyticsDB.PractII.BadlaniK.R` script. This will extract data from the local SQLite databases (`film-sales.db` and `music-sales.db`) and populate the MySQL datamart.
    ```R
    source("loadAnalyticsDB.PractII.BadlaniK.R")
    ```

4.  **Generate the Report**:
    Open `BusinessAnalysis.PractII.BadlaniK.Rmd` in RStudio and click "Knit" to generate the HTML report. This report will query the live MySQL datamart and present the findings.

## Schema Design

The datamart uses a **Star Schema** architecture:

*   **Fact Table**:
    *   `fact_sales`: Contains the metrics (facts) for analysis, including:
        *   `total_units`, `avg_units`, `min_units`, `max_units`
        *   `total_revenue`, `avg_revenue`, `min_revenue`, `max_revenue`
        *   `customer_count`
    *   Foreign keys linking to dimension tables: `date_id`, `country_id`, `type_id`.

*   **Dimension Tables**:
    *   `dim_date`: Time dimension with `date_id`, `month`, `quarter`, `year`.
    *   `dim_country`: Geography dimension with `country_id` and `country_name`.
    *   `dim_type`: Media type dimension distinguishing between 'film' and 'music'.
