from flask import Flask, request
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
                script_process = subprocess.Popen(['python', 'backend/predict.py'])
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

if __name__ == '__main__':
    port = 5000 # Change if necessary
    app.run(debug=True) # Enable debug mode for detailed error messages
