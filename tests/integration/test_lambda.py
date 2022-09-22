from json import loads, dumps, load
from unittest import TestCase, main
import localstack_client.session as boto3


class BaseTest(TestCase):
    def setUp(self) -> None:
        self.lambda_client = boto3.client("lambda")

    @staticmethod
    def _read_event_from_file(file_path: str):
        with open(file_path) as file:
            return load(file)

    def _get_response(self, event) -> dict:
        return loads(self.lambda_client.invoke(FunctionName="main", Payload=dumps(event))["Payload"].read())

    def test_given_empty_event_then_return_empty_result(self):
        event = self._read_event_from_file("resources/event.json")
        self.assertEqual(self._get_response(event), {})


if __name__ == '__main__':
    main()
