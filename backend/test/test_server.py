import unittest
import json
import sys
import os
# append path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from server import app

class TestFlaskApp(unittest.TestCase):
    
    def setUp(self):
        # set testing mode 
        app.testing = True
        # set a test client
        self.app = app.test_client()

    def test_run_script(self):
        # testing starting the script
        response = self.app.post('/', data={'start': True})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b'Script started successfully')

        # trying to start the script when it's already running
        response = self.app.post('/', data={'start': True})
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data, b'Script is already running')

        # testing stopping the script
        response = self.app.get('/?stop=True')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b'Script terminated successfully')

        # trying to stop the script when it's not running
        response = self.app.get('/?stop=True')
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data, b'Script is not running or already terminated')

    def test_update_counts(self):
        # test updating counts
        response = self.app.post('/update_counts', json={'count': 10})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b'Counts updated successfully')

        # test getting counts
        response = self.app.get('/get_counts')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.data), {'count': 10})

if __name__ == '__main__':
    unittest.main()
