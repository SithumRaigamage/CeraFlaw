import sys
from flask import Flask, jsonify, request
from flask_cors import CORS
import subprocess
import logging

app = Flask(__name__)
CORS(app) # This will enable CORS for all routes

# Configure logging (optional, adjust as needed)
logging.basicConfig(filename='myapp.log', level=logging.DEBUG)

# Define the base URL for the API
API_BASE_URL = 'http://localhost:5000' # Adjust if using a different port

script_process = None

@app.route('/', methods=['GET', 'POST'])
def run_script():
    global script_process

    try:
        if request.method == 'POST' and request.form.get('start'):
            if script_process is None or script_process.poll() is not None:
                #script_process = subprocess.Popen(['python', 'backend/predict.py'])
                # script_process = subprocess.Popen([sys.executable, 'backend/ObjectCounting/ceraflaw.py'])
                script_process = subprocess.Popen([sys.executable, 'backend/ObjectCounting/ceraflawOOP.py'])
                logging.info('Script started successfully')
                return 'Script started successfully', 200
            else:
                return 'Script is already running', 400

        elif request.method == 'GET' and request.args.get('stop'):
            # Check if the script process is running before attempting to terminate it
            if script_process and script_process.poll() is None:
                script_process.terminate()
                script_process.wait()
                script_process = None
                logging.info('Script terminated successfully')
                return 'Script terminated successfully', 200
            else:
                # If the script is not running, return a 400 error with a more descriptive message
                return 'Script is not running or already terminated', 400

        else:
            return 'Invalid request', 400

    except Exception as e:
        logging.error(f'Error executing script: {e}')
        return f'Error executing script: {e}', 500

# Variable to store the counts received from the script
count_data = {}

@app.route('/update_counts', methods=['POST'])
def update_counts():
    global count_data
    data = request.json  # Assuming the counts will be sent in JSON format
    count_data = data
    return 'Counts updated successfully', 200

@app.route('/get_counts', methods=['GET'])
def get_counts():
    global count_data
    return jsonify(count_data), 200

if __name__ == '__main__':
    port = 5000 # Change if necessary
    app.run(debug=True) # Enable debug mode for detailed error messages
