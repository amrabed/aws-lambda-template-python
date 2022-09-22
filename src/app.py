from aws_lambda_powertools import Tracer, Metrics
from aws_lambda_powertools.utilities.typing import LambdaContext

from src.logging import get_logger


APP_NAME = "Template"  # change me

tracer = Tracer(APP_NAME)
metrics = Metrics(APP_NAME)
logger = get_logger(__name__)


@tracer.capture_lambda_handler
@metrics.log_metrics
def main(event: dict, context: LambdaContext):
    """
    Main Lambda handler
    :param event: Triggering event
    :param context: Lambda context
    """
    return {}


if __name__ == "__main__":
    main({}, LambdaContext())
