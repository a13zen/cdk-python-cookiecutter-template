#!/usr/bin/env python3
import os
import aws_cdk as cdk
import cdk_nag

from {{cookiecutter.pkg_name}}.cdk_stack import CdkStack

app = cdk.App()

app_stack = CdkStack(
    app,
    "CdkStack",
    env=cdk.Environment(account=os.getenv("CDK_DEFAULT_ACCOUNT"), region=os.getenv("CDK_DEFAULT_REGION")),
)

# Runs CDK Nag on Stack
cdk.Aspects.of(app_stack).add(cdk_nag.AwsSolutionsChecks())

app.synth()
