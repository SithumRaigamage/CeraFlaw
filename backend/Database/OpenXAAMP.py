# no need to install already there
import subprocess
import webbrowser
import platform
import time

def start_xampp():
    #windows @praveen give the location of the xaamp
    if platform.system() == "Windows":
        xampp_control_path = "C:\\xampp\\xampp-control.exe"  # Update this with your XAMPP control script path
        subprocess.Popen([xampp_control_path, "start"])
    #macos
    elif platform.system() == "Darwin":  # macOS
        xampp_control_path = "/Applications/XAMPP/xamppfiles/xampp"  # Update this with your XAMPP control script path
        subprocess.Popen([xampp_control_path, "start"])

def open_phpmyadmin():
    # Wait for XAMPP to start
    time.sleep(10)  # Adjust this delay according to your system's startup time
    
    # URL to phpMyAdmin
    phpmyadmin_url = "http://localhost/phpmyadmin"
    
    # Open phpMyAdmin in default web browser
    webbrowser.open(phpmyadmin_url)

# Start XAMPP
start_xampp()

# Open phpMyAdmin
open_phpmyadmin()
