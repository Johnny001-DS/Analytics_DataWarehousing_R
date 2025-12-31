# Part A
# Author: Karan Badlani
# Program - SandBox Script to test connection with the Instance on AWS

# Install required packages (run below if not installed)
packages <- c("DBI", "RMySQL")
installed <- rownames(installed.packages())
for (p in packages) {
  if (!(p %in% installed)) install.packages(p)
}

# Load Libraries
library(DBI)
library(RMySQL)

# Connect to AWS RDS MySQL Database
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "media_analytics",
                 host = "cs5200-practicumii.c2lek0cq872j.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "admin",
                 password = "admin999"
)

# Test connection
dbListTables(con)

# Drop if exists
dbExecute(con, "DROP TABLE IF EXISTS test_table")

# Create a simple test table
dbExecute(con, "
  CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  )
")

# Insert rows
dbExecute(con, "
  INSERT INTO test_table (name)
  VALUES ('Alice'), ('Bob'), ('Charlie')
")

# Fetch rows
result <- dbGetQuery(con, "SELECT * FROM test_table")
print(result)


# Disconnect
dbDisconnect(con)
