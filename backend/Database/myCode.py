from ultralytics import YOLO
import os
import mysql.connector
from datetime import datetime

# Establish a connection to your MySQL database
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="CeramicTile"
)

# Get a cursor object
cursor = mydb.cursor()

# Load a model
model = YOLO("best.pt")  # Assuming you have the YAML configuration file

# Set the input folder
input_folder = 'tile'

# loop through all files in input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.JPG') or filename.endswith('.png'):
        # Define input file path
        input_path = os.path.join(input_folder, filename)

        # Predict using YOLO model
        results = model.predict(source="tile/" + filename)

        # Extract relevant information from prediction results
        if 'name' in results[0]:  # If detections are present
            image_path = results[0]['name']
            detections = results.xyxy[0]  # Assuming 'xyxy' format is used

            # Insert data into MySQL database
            for detection in detections:
                label = detection[0]
                confidence = detection[5]
                timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

                sql = "INSERT INTO detections (image_path, label, confidence, timestamp) VALUES (%s, %s, %s, %s)"
                val = (image_path, label, confidence, timestamp)
                cursor.execute(sql, val)
                mydb.commit()  # Commit the transaction

            sql = "INSERT INTO detections (image_path, label, confidence, timestamp) VALUES (%s, %s, %s, %s)"
            val = (image_path, label, confidence, timestamp)
            cursor.execute(sql, val)
            mydb.commit()  # Commit the transaction

# Close cursor and database connection
cursor.close()
mydb.close()
