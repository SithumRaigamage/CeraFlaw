import cv2
import unittest
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))  # added parent directory to the python path

from FrameExtract import testExtractFrames, savedata_dir

class TestFrameExtract(unittest.TestCase):
    def test_frame_extraction(self):
        # save dirct creation
        os.makedirs(savedata_dir, exist_ok=True)

        # simulate frame capturing
        testExtractFrames()

        # checking if frames were saved
        self.assertTrue(os.path.exists(savedata_dir))

        # checking if atleast one frame saved
        frames = os.listdir(savedata_dir)
        self.assertTrue(len(frames) > 0)

        # checking if the files saved was .jpg
        self.assertTrue(all(file.endswith('.jpg') for file in frames))

        # checking if files can be read as images
        for file in frames:
            filepath = os.path.join(savedata_dir, file)
            img = cv2.imread(filepath)
            self.assertIsNotNone(img)
            self.assertTrue(img.shape[0] > 0)
            self.assertTrue(img.shape[1] > 0)

        # clean up (remove directory and content)
        for file in frames:
            os.remove(os.path.join(savedata_dir, file))
        os.rmdir(savedata_dir)

if __name__ == '__main__':
    unittest.main()
