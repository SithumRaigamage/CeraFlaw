import subprocess

# Runing the remove background process on tile frames
subprocess.run(['python', 'backend//RemoveBg.py'])

# Runing the patch creating process on the tile frames with no background
subprocess.run(['python', 'backend//CreatePatch.py'])