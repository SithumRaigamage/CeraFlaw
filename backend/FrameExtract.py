### CeraFlaw - FrameExtract.py

import os

# OpenCv lib
import cv2

# Capture obj
vidCam = cv2.VideoCapture(0)

# Variables
currentFrame = 0

# Savedata directory
savedata_dir = "backend//Frames"
#savedata_dir = os.path.expanduser("~\\Desktop\\FrameExtract\\Frames")
os.makedirs(savedata_dir, exist_ok=True)

## Video Capture Loop
while True:
    # Video Information
    progress, frame = vidCam.read()
    #.read() extracts frame by frame information from a video which is a combination of frames and fps

    ## For Dev
    if not progress:
        print("No frame captured")
        break
    ##
    # Video Stream
    cv2.imshow("VideoStream", frame)

    # Saving Frames
    path = os.path.join(savedata_dir, f"frame{currentFrame}.jpg")
    cv2.imwrite(path, frame)
    ## For Dev
    print(f"Saved frame: {currentFrame}")
    print(f"Saved frame {currentFrame} to {path}")
    ##
    currentFrame += 1

    # Manual Exit Option
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break