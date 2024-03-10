import mysql.connector
from datetime import datetime

# Connect to MySQL database
#replace this praveen
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="CeramicTile"
)
cursor = conn.cursor()

# Create a table to store detection results if it doesn't exist
create_table_query = """
CREATE TABLE IF NOT EXISTS detection_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_path VARCHAR(255),
    result VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
"""
cursor.execute(create_table_query)

# Sample function to save detection result
def save_detection_result(image_path, result):
    # Insert the detection result into the table with the current timestamp
    insert_query = "INSERT INTO detection_results (image_path, result) VALUES (%s, %s)"
    cursor.execute(insert_query, (image_path, result))
    conn.commit()

# Example usage:
image_path = "path/to/your/image.jpg" #should include the file path from yolo
result = "no detections" #  should include the result from the yolo
save_detection_result(image_path, result)

# Close cursor and connection
cursor.close()
conn.close()
