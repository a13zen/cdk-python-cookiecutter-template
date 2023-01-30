from aws_cdk import Duration, Stack
from aws_cdk import aws_sqs as sqs
from cdk_nag import NagSuppressions
from constructs import Construct

from {{cookiecutter.pkg_name}}.utils import LabelGenerator


class CdkStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        lg = LabelGenerator(prefix="{{cookiecutter.project_infra_prefix}}", stage=kwargs["stage"], aws_env=kwargs["env"])

        dlq_name = lg.get_label("dlq-queue", include_region=True)
        dl_queue = sqs.Queue(
            self,
            id=dlq_name,
            queue_name=dlq_name,
            encryption=sqs.QueueEncryption.KMS_MANAGED,
        )

        queue_name = lg.get_label("sqs-queue")
        sqs.Queue(
            self,
            id=queue_name,
            queue_name=queue_name,
            visibility_timeout=Duration.seconds(300),
            encryption=sqs.QueueEncryption.KMS_MANAGED,
            dead_letter_queue=sqs.DeadLetterQueue(max_receive_count=1, queue=dl_queue),
        )

        NagSuppressions.add_stack_suppressions(
            self,
            [
                {
                    "id": "AwsSolutions-SQS3",
                    "reason": "Example only - Don't suppress",
                },
                {
                    "id": "AwsSolutions-SQS4",
                    "reason": "Example only - Don't suppress",
                },
            ],
        )
