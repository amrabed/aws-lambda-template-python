from unittest import TestCase, main

from src import app


class IntegrationTest(TestCase):
    def test_given_valid_event_return_valid_response(self):
        self.assertEqual(app.main({}, None), {})


if __name__ == "__main__":
    main()
