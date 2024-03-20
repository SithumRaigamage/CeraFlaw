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

# Motion Detection
def detectMotion(frame, prevFrame):
    # Checking if theres capture issues
    if frame is None or prevFrame is None:
        return False

    # Convert frames to grayscale if not already in grayscale
    if len(frame.shape) == 3:  # check if already greyscale
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    else:
        gray = frame

    if len(prevFrame.shape) == 3: 
        prevGray = cv2.cvtColor(prevFrame, cv2.COLOR_BGR2GRAY)
    else:
        prevGray = prevFrame

    # Absolute difference
    frameDiff = cv2.absdiff(prevGray, gray)
    # Converting grayscale img to binary (Sensitivity)
    _, binaryImg = cv2.threshold(frameDiff, 30, 255, cv2.THRESH_BINARY)
    # _ to ignore status from status and thresholded imaged returned from .threshold() 

    """
    # Note
    30 - Lower to high sensitivity
    255 - Maximum intensity to pass threshold test
    """
    # Find outlines of objects/motion
    contours ,_ = cv2.findContours(binaryImg, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Check if theres motion
    motionDetected = False
    for contour in contours:
        if cv2.contourArea(contour) > 100:  # Adjust Sensitivity
            motionDetected = True
            break
    """
    # Note
    threshold for the minimum contour area considered significant enough to be classified as motion.
    lower to high sensitivity
    """   
    return motionDetected

# Only runs is ran directly
if __name__ == "__main__":
    ## Capture First Frame
    progress, prevFrame = vidCam.read()

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

        if detectMotion(frame, prevFrame):
            # Saving Frames
            path = os.path.join(savedata_dir, f"frame{currentFrame}.jpg")
            cv2.imwrite(path, frame)
            print(f"Saved frame: {currentFrame}")
            print(f"Saved frame {currentFrame} to {path}")
            currentFrame += 1
        prevFrame = frame.copy()

        # Manual Exit Option
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break
    # end
    vidCam.release()
    cv2.destroyAllWindows()


