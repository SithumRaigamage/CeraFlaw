import subprocess

# Runing the remove background process on tile frames
subprocess.run(['python', 'RemoveBg.py'])

# Runing the patch creating process on the tile frames with no background
subprocess.run(['python', 'patch.py'])