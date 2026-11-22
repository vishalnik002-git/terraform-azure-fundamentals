# 🚀 Foundational Azure Resource Group Lab with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Lab](https://img.shields.io/badge/Lab-Foundational-green)](https://developer.hashicorp.com/terraform/intro)

---

## 📌 Project Overview

This is the **foundational lab** for Infrastructure as Code (IaC) with Terraform and Microsoft Azure.

It establishes hands-on understanding of the core Terraform lifecycle:
* **`terraform init`** — Initializing working directory and downloading the `azurerm` provider plugin.
* **`terraform plan`** — Performing a dry run to generate an execution plan against Azure APIs.
* **`terraform apply`** — Provisioning the live Azure Resource Group.
* **`terraform destroy`** — Tearing down cloud resources safely.

---

## 🏗️ Resources Provisioned

```text
Microsoft Azure (Subscription)
  └── Resource Group: rg-sack (East US)
```

* **Resource Block:** `azurerm_resource_group.rg_dev`
* **Region:** `East US`
* **Purpose:** Acts as the logical container for all subsequent Azure resources.

---

## 💡 Foundational Concepts Learned

1. **Provider Configuration:** Declaring `azurerm` with required features block in `provider.tf`.
2. **Terraform State File (`terraform.tfstate`):** Observing how Terraform records the mapping of declared HCL code to real Azure cloud resource IDs.
3. **Idempotency:** Re-running `terraform apply` when no code has changed results in zero modifications, demonstrating Terraform's declarative idempotency.

---

## 📁 Repository Structure

```text
.
├── main.tf              # Resource Group definition
├── provider.tf          # Azure provider configuration
├── .gitignore           # Git ignore rules for state files
└── README.md            # Project documentation
```

---

## 🚀 How to Run

```bash
# 1. Clone repository
git clone https://github.com/vishalnik002-git/terraform-hardcoded-rg.git
cd terraform-hardcoded-rg

# 2. Authenticate to Azure
az login

# 3. Initialize working directory
terraform init

# 4. Preview execution plan
terraform plan

# 5. Provision resource
terraform apply -auto-approve

# 6. Destroy resource when lab is finished
terraform destroy -auto-approve
```

---

## 👤 Author
* **Vishal Yadav** — [GitHub Profile](https://github.com/vishalnik002-git) | [LinkedIn](https://www.linkedin.com/in/vishal-yadav002)
