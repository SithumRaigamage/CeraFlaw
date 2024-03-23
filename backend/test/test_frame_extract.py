import os
import cv2
import sys
import unittest

# Append parent directory to the Python path to import FrameExtract.py
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Import the function to be tested
from FrameExtract import extractFrames, savedata_dir

class TestFrameExtract(unittest.TestCase):
    def test_extractFrames(self):
        # Create savedata directory
        os.makedirs(savedata_dir, exist_ok=True)

        # Extract frames from test video
        extractFrames(videoPath=os.path.join(os.path.dirname(__file__), "test_frame_video.mp4"), maxFrames=50)

        # Check if savedata directory exists
        self.assertTrue(os.path.exists(savedata_dir))

        # Check if at least one frame is saved
        frames = os.listdir(savedata_dir)
        self.assertTrue(len(frames) > 0)

        # Check if the saved files are .jpg
        self.assertTrue(all(file.endswith('.jpg') for file in frames))

        # Check if files can be read as images
        for file in frames:
            filepath = os.path.join(savedata_dir, file)
            img = cv2.imread(filepath)
            self.assertIsNotNone(img)
            self.assertTrue(img.shape[0] > 0)
            self.assertTrue(img.shape[1] > 0)

        # Clean up (remove directory and content)
        for file in frames:
            os.remove(os.path.join(savedata_dir, file))
        os.rmdir(savedata_dir)

if __name__ == '__main__':
    unittest.main()
