import unittest
from unittest.mock import patch
from main import fetchEnv

class TestFetchEnv(unittest.TestCase):

    @patch('socket.gethostname', return_value='mocked_hostname')
    @patch('socket.gethostbyname', return_value='mocked_ip')
    @patch('os.environ.get', side_effect=lambda x: {'LINK': 'mocked_link', 'PASSWORD': 'mocked_password'}.get(x))
    def test_fetch_env(self, mock_gethostname, mock_gethostbyname, mock_os_environ_get):
        expected_result = ('mocked_hostname', 'mocked_ip', 'mocked_link', 'mocked_password')
        result = fetchEnv()
        self.assertEqual(result, expected_result)

if __name__ == '__main__':
    unittest.main()
