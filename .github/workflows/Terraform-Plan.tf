name: "Terraform"

on:
  push:
    branches:
      - FeatureBranch1

jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          # terraform_version: 0.13.0:
          cli_config_credentials_token: ${{ secrets.AWS_TFAPI_TOKEN }}

      - name: Terraform Format
        id: fmt
        run: terraform fmt -check

      - name: Terraform Init
        id: init
        run: terraform init

      - name: Terraform Plan
        id: plan
        if: github.event_name == 'push'
        run: terraform plan -no-color
        continue-on-error: true