from flask import Flask, request
import subprocess
import logging

app = Flask(__name__)
script_process = None

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/run-script', methods=['GET', 'POST'])
def run_script():
    global script_process

    try:
        if request.method == 'POST' and request.form.get('start'):
            if script_process is None or script_process.poll() is not None:
                script_process = subprocess.Popen(['python', 'backend/predict.py'])
                logger.info('Script started successfully')
                return 'Script started successfully', 200
            else:
                return 'Script is already running', 400
        
        elif request.method == 'GET' and request.args.get('stop'):
            if script_process and script_process.poll() is None:
                script_process.terminate()
                script_process.wait()
                script_process = None
                logger.info('Script terminated successfully')
                return 'Script terminated successfully', 200
            else:
                return 'Script is not running', 400
            
        else:
            return 'Invalid request', 400

    except Exception as e:
        logger.error(f'Error executing script: {e}')
        return f'Error executing script: {e}', 500

if __name__ == '__main__':
    app.run(debug=True)
