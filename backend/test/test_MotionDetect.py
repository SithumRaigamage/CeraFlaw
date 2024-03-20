import cv2
import os
import sys
import unittest

# append path to import FrameExtract.py
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# import function
from FrameExtractMotion import detectMotion

class TestDetectMotion(unittest.TestCase):
    def test_detectMotion_with_motion(self):
        dir_path = os.path.dirname(os.path.realpath(__file__))
        # sample frames
        frame = cv2.imread(os.path.join(dir_path, "frame0.jpg"))
        prevFrame = cv2.imread(os.path.join(dir_path, "frame1.jpg"))

        # test motion detection
        motion_detected = detectMotion(frame, prevFrame)

        # assert that motion is detected
        self.assertTrue(motion_detected)

    def test_detectMotion_without_motion(self):
        dir_path = os.path.dirname(os.path.realpath(__file__))
        # Create sample frames without motion
        staticFrame = cv2.imread(os.path.join(dir_path, "frame1.jpg"))
        prevFrame = cv2.imread(os.path.join(dir_path, "frame1.jpg"))

        # Test motion detection
        motion_detected = detectMotion(staticFrame, prevFrame)

        # Assert that motion is not detected
        self.assertFalse(motion_detected)

if __name__ == '__main__':
    unittest.main()
