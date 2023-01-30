class LabelGenerator:
    def __init__(self, *, prefix, aws_env, stage, delim="-"):
        self.region = aws_env.region
        self.account = aws_env.account
        self.stage = stage  # e.g. dev/int/prod
        self.prefix = prefix
        self.delim = delim

    def get_label(self, component_name, delim=None, include_stage=True, include_region=False):
        if delim is None:
            delim = self.delim
        parts = [self.prefix]
        if include_stage is True:
            parts.append(self.stage)
        if include_region is True:
            parts.append(self.region)
        parts.append(component_name)

        # Format prefix-[stage]-[region]-component
        return self.delim.join(parts).replace("_", self.delim)
