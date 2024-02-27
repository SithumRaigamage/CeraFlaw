### CeraFlaw - FrameExtract.py

import os

# OpenCv lib
import cv2

# Capture obj
vidCam = cv2.VideoCapture(0)

# Variables
currentFrame = 0

# Savedata directory
savedata_dir = "backend//TileFrames"
#savedata_dir = os.path.expanduser("~\\Desktop\\FrameExtract\\Frames")
os.makedirs(savedata_dir, exist_ok=True)