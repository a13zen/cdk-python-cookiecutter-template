from aws_cdk import (
    # Duration,
    Stack,
    # aws_sqs as sqs,
)
from constructs import Construct
from cdk_nag import NagSuppressions


class CdkStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here

        # example resource
        # queue = sqs.Queue(
        #     self, "CdkQueue",
        #     visibility_timeout=Duration.seconds(300),
        # )

        # NagSuppressions.add_stack_suppressions(
        #     self,
        #     [
        #         {
        #             "id": "AwsSolutions-IAM5",
        #             "reason": "Resource access restriced describe only",
        #         },
        #     ],
        # )
