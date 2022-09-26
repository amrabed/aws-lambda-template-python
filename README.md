# AWS Lambda Template - Python
![](coverage.svg)
![Python](https://img.shields.io/badge/python-3.8%20|%203.9-blue.svg?logo=python)
[![Code style: black](https://img.shields.io/badge/code%20style-black-black.svg)](https://github.com/psf/black)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=amrabed_python-lambda-template&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=amrabed_python-lambda-template)

A template for developing an AWS Lambda function in Python

### Running tests

To run the unit tests defined in [tests/unit](tests/unit) with coverage, use:

```bash
make unit-test
```

To run the integration tests defined in [tests/integration](tests/integration) on local [infra](infra) using [LocalStack](https://docs.localstack.cloud), use:
```bash
make integration-test
```

To run both unit and integration tests, use:
```bash
make test
```

To clean local infra after running integration test, use:
```
make clean
```
