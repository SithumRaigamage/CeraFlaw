import os
import cv2

savedata_dir = "backend//Frames"
os.makedirs(savedata_dir, exist_ok=True)

def extractFrames(videoPath=None, maxFrames=None):
    """
    change maxFrames to None when calling to indefinite run
    """

    if videoPath is None or videoPath == "":
        videoPath = 0  # default camera index

    vidCam = cv2.VideoCapture(videoPath)  # initializing videocapture obj
    currentFrame = 0  # init frame counter

    # Video Capture Loop
    while maxFrames is None or currentFrame < maxFrames:
        progress, frame = vidCam.read()  # read frames from 
        if not progress:
            print("No frame captured")
            break
        
        # cv2.imshow("VideoStream", frame)  # video stream
        
        # save frames
        path = os.path.join(savedata_dir, f"frame{currentFrame}.jpg")
        cv2.imwrite(path, frame)
        # print(f"Saved frame: {currentFrame}")
        # print(f"Saved frame {currentFrame} to {path}")
        
        currentFrame += 1  # frame counting
        
        # manual exit (press q)
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

    vidCam.release()  # Release the video capture object
    cv2.destroyAllWindows()  # Close all OpenCV windows

## testing purposes ##
def testExtractFrames():
    extractFrames(videoPath="backend//test//test_frame_video.mp4",maxFrames=50)

# Only runs is ran directly
if __name__ == "__main__":
    extractFrames()
