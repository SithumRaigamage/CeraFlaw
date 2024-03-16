import mysql.connector
from datetime import datetime, timedelta
import subprocess
import webbrowser
import platform
import time

def start_xampp():
    if platform.system() == "Windows":
        xampp_control_path = "C:\\xampp\\xampp-control.exe"
        subprocess.Popen([xampp_control_path, "start"])
    elif platform.system() == "Darwin":  # macOS
        xampp_control_path = "/Applications/XAMPP/xamppfiles/xampp"
        subprocess.Popen([xampp_control_path, "start"])

def open_phpmyadmin():
    time.sleep(10)  # Adjust this delay according to your system's startup time
    phpmyadmin_url = "http://localhost/phpmyadmin"
    webbrowser.open(phpmyadmin_url)

# Start XAMPP
start_xampp()

# Open phpMyAdmin
open_phpmyadmin()

# Establishing MySQL connection
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",  # Put your MySQL password here if it's set
    database="CeramicTile"
)

# Creating a cursor object
mycursor = mydb.cursor()

# Create a table to store detection results if it doesn't exist
create_table_query = """
CREATE TABLE IF NOT EXISTS Table1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    detection VARCHAR(255),
    description VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
"""
mycursor.execute(create_table_query)

# Generating more sample data from 50 to 100
for i in range(50, 101):
    detection = f"New Detection {i}"
    description = f"New Description {i}"
    timestamp = datetime.now() - timedelta(days=i)
    
    # SQL query to insert data into the table
    sql = "INSERT INTO Table1 (detection, description, timestamp) VALUES (%s, %s, %s)"
    val = (detection, description, timestamp)

    try:
        # Executing the SQL query
        mycursor.execute(sql, val)

        # Committing the changes
        mydb.commit()

        
    except Exception as e:
        # Rolling back the changes in case of error
        print("Error:", e)
        mydb.rollback()
print("Data inserted successfully.")

# Closing the cursor and database connection
mycursor.close()
mydb.close()
