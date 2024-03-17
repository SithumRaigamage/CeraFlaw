#download the pip install
import mysql.connector

# Establishing a connection to the MySQL database
try:
    connection = mysql.connector.connect(
    host="localhost",#praveen dont changed this
    user="root",#do not change this if u have a user add this
    password="",#add password if has or keep it like this
    database="CeramicTile"# add databaseName not tablename
)

    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to the database: ", record)

except mysql.connector.Error as e:
    print("Error while connecting to MySQL", e)

# Closing the database connection
finally:
    if 'connection' in locals() and connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")