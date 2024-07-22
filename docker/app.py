import mysql.connector
from mysql.connector import errorcode
import os
import time

# Wait for the MySQL server to be available
time.sleep(10)

# MySQL connection parameters
db_config = {
    'user': 'root',
    'password': os.environ.get('MYSQL_ROOT_PASSWORD'),  # get password from environment variable
    'host': os.environ.get('MYSQL_HOST'),  # get host from environment variable
}

print("Python container running")

# Create connection to MySQL
try:
    conn = mysql.connector.connect(**db_config)
    conn.autocommit = True
    mycursor = conn.cursor()
    print("Creating database...")
    response = mycursor.execute("CREATE DATABASE IF NOT EXISTS test_database ;")
    time.sleep(10)
    mycursor.execute("USE test_database ;")
    mycursor.execute("SELECT DATABASE() ;")
    record = mycursor.fetchone()
    print("You are connected to database" , record)
    mycursor.close()
    conn.close()
except mysql.connector.Error as err:
    print(f"Error is : {err}")
    