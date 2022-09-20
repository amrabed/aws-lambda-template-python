import os

from aws_lambda_powertools import Logger
from aws_lambda_powertools.logging.formatter import LambdaPowertoolsFormatter


def get_logger(name: str) -> Logger:
    return Logger(
        service=name,
        level=os.environ.get("LOG_LEVEL", "INFO"),
        logger_formatter=LambdaPowertoolsFormatter(log_record_order=["message"]),
    )
