terraform/
│
├── providers.tf
├── backend.tf   (you configure)
├── variables.tf
├── main.tf
├── outputs.tf
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │
│   ├── ecr/
│   │   ├── main.tf
│   │   ├── outputs.tf
