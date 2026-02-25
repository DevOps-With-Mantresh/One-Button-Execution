## One-Button-Execution — Terraform Using Jenkins

This repository contains Terraform configurations and reusable modules to create a VPC, EKS cluster, and ECR repositories. The README was updated for clearer rendering on GitHub and to provide a quick start guide.

### Repository layout

Root contains the primary Terraform configuration files. Modules live under `modules/`.

```
terraform/
├── providers.tf
├── backend.tf          # configure backend (example: S3 + DynamoDB)
├── variables.tf
├── main.tf
├── outputs.tf
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── eks/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecr/
        ├── main.tf
        └── outputs.tf
```

### Quick start

1. Install Terraform (recommended v1.0+).
2. Configure your cloud provider credentials (e.g., AWS CLI profile / environment variables).
3. (Optional) Configure `backend.tf` with your remote backend details.

Run the standard flow from the repository root:

```bash
# initialize providers and modules
terraform init

# preview changes
terraform plan -out plan.tfplan

# apply
terraform apply "plan.tfplan"
```

If you haven't configured a backend, Terraform will use a local state file (`terraform.tfstate`). For team usage we recommend configuring an S3 backend and state locking with DynamoDB (if using AWS).

### Modules

- `modules/vpc` — network resources (VPC, subnets, route tables).
- `modules/eks` — EKS cluster and node group resources.
- `modules/ecr` — ECR repositories and lifecycle policies.

### Customization & variables

- Put sensitive or environment-specific values in a `terraform.tfvars` file (do not commit secrets).
- Use the variables defined in `variables.tf` to customize CIDRs, instance sizes, tags, etc.

Example `terraform.tfvars` (do NOT commit):

```hcl
# terraform.tfvars
region = "us-west-2"
environment = "dev"
```

### Notes & best practices

- Keep `backend.tf` out of source control if it contains environment-specific secrets; instead, provide an example or document required values.
- Add `*.tfstate` and any generated credential files to `.gitignore`.
- Consider adding a `examples/` directory with ready-to-run configurations for common environments.

### Next steps

- I updated this README to improve GitHub rendering and clarity. If you'd like, I can:
  - add example `terraform.tfvars` templates per environment,
  - add a small `examples/` folder showing a full end-to-end deployment,
  - add CI workflow for `terraform fmt`, `terraform validate`, and `tflint`.

If this looks good, I'll mark the TODO done and you can preview the README on GitHub or locally in a Markdown viewer.
