from flask import Flask
import subprocess

app = Flask(__name__)

# Define a route '/run-script' that responds to both GET and POST requests
@app.route('/run-script', methods=['GET', 'POST'])
def run_script():
    try:
        # Replace 'your_script.py' with the name of your Python script
        subprocess.run(['python', 'backend/predict.py'])
        return 'Script executed successfully', 200
    except Exception as e:
        return f'Error executing script: {e}', 500

if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=True)
