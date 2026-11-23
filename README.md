# 🚀 Terraform & Microsoft Azure Fundamentals

![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue.svg?logo=terraform)
![Azure Provider](https://img.shields.io/badge/AzureRM-3.100%2B-0078D4.svg?logo=microsoft-azure)
![IaC](https://img.shields.io/badge/IaC-HCL-623CE4.svg)
![Validation](https://img.shields.io/badge/Validation-Pass-success.svg)

> **Repository 01 of 08 in the Terraform + Microsoft Azure Professional Learning Series**

---

## 📌 Navigation
| ⏪ Previous Repository | 📚 Current Repository | ⏩ Next Repository |
| :--- | :---: | :--- |
| *None (Start of Series)* | **01. terraform-azure-fundamentals** | [02. terraform-azure-resource-provisioning →](https://github.com/vishalnik002-git/terraform-azure-resource-provisioning) |

---

## 📖 Project Overview

This repository introduces the core foundations of **Infrastructure as Code (IaC)** using **HashiCorp Terraform** and the **Microsoft Azure** cloud provider (`azurerm`).

Infrastructure as Code allows software engineers and DevOps practitioners to define, provision, and manage cloud infrastructure using declarative configuration files rather than manual clicks in the Azure Portal.

> ℹ️ **Learning Note**: This repository contains learning configurations and documentation. Automated validation checks verify HCL syntax without provisioning live Azure cloud resources.

---

## 🎯 Learning Objectives

By exploring this repository, you will understand:
1. What Infrastructure as Code is and why Terraform is used across modern engineering teams.
2. The role of the **AzureRM Provider** and the required `features {}` block.
3. The anatomy of Terraform blocks: `terraform`, `provider`, `resource`, `variable`, `output`, `locals`, and `data`.
4. The structure of a clean Terraform project layout (`versions.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf`).
5. The complete Terraform lifecycle: `fmt`, `init`, `validate`, `plan`, `apply`, and `destroy`.
6. How provider plugins are discovered, downloaded, and recorded in `.terraform.lock.hcl`.

---

## 🏗️ Architecture & Workflow Diagram

```
+-------------------------------------------------------------------------+
|                       Terraform Execution Flow                          |
+-------------------------------------------------------------------------+
       |
       v
 [ terraform fmt ]       --> Checks and formats HCL code style
       |
       v
 [ terraform init ]      --> Downloads AzureRM provider plugin
       |
       v
 [ terraform validate ]  --> Validates syntax and configuration parameters
       |
       v
 [ terraform plan ]      --> Generates execution plan (Desired vs Actual State)
       |
       v
 [ terraform apply ]     --> Deploys resources to Azure (Documentation Only)
       |
       v
 [ terraform destroy ]   --> Safely removes managed resources (Lifecycle Demo)
```

---

## 📂 Repository Structure

```
terraform-azure-fundamentals/
├── .github/
│   └── workflows/
│       └── validate.yml          # Automated syntax and validation CI
├── examples/
│   └── 01-basic-resource-group/  # Self-contained standalone example
│       ├── main.tf
│       ├── outputs.tf
│       └── versions.tf
├── .gitignore                    # Prevents committing state and sensitive data
├── main.tf                       # Primary resource definitions (Resource Group)
├── outputs.tf                    # Declares output values
├── providers.tf                  # Configures the AzureRM provider
├── terraform.tfvars.example      # Example input variable values
├── variables.tf                  # Declares input variables with default values
├── versions.tf                   # Enforces required Terraform & provider versions
└── README.md                     # Comprehensive documentation
```

---

## 🧩 Core Concepts & Explanations

### 1. What is Infrastructure as Code (IaC)?
Infrastructure as Code is the practice of managing networks, virtual machines, storage accounts, and cloud services using machine-readable configuration files. IaC provides:
- **Repeatability**: Deploy identical infrastructure across Development, Staging, and Production.
- **Version Control**: Track every infrastructure modification through Git commits and pull requests.
- **Drift Prevention**: Audit differences between declared configurations and active cloud resources.

### 2. The AzureRM Provider & Features Block
Terraform communicates with Microsoft Azure through plugins called **providers**. The `azurerm` provider translates HCL code into Azure Resource Manager REST API calls.
The `features {}` block inside the provider block is mandatory for the Azure provider; it allows configuring provider-level settings such as key vault deletion policies.

```hcl
provider "azurerm" {
  features {}
}
```

### 3. Resource Block Anatomy
Every cloud resource in Terraform follows a standardized declarative syntax:

```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
```
- **Block Type**: `resource` declares that Terraform will manage this infrastructure object.
- **Resource Type**: `azurerm_resource_group` indicates the specific Azure service managed by the AzureRM provider.
- **Resource Name**: `rg` is a local identifier used to reference this resource inside other Terraform blocks.
- **Required Arguments**: `name` and `location` are mandatory properties required by Azure to create a Resource Group.

---

## 🛠️ Step-by-Step Getting Started Guide

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.5.0 or later installed).
- Basic understanding of terminal commands.

### 1. Format Check
Format your HCL code according to canonical HashiCorp standards:
```bash
terraform fmt
```

### 2. Initialize Working Directory
Initialize Terraform to download the required `azurerm` provider plugin:
```bash
terraform init -backend=false
```
*Note: We pass `-backend=false` for local offline validation without requiring an active cloud backend.*

### 3. Validate Configuration
Verify that configuration files are syntactically valid and internally consistent:
```bash
terraform validate
```

### 4. Generate Execution Plan (Educational Documentation)
```bash
terraform plan
```
`terraform plan` reads active cloud state and compares it with your configuration files to show what actions will take place.

### 5. Apply Changes (Educational Documentation)
```bash
terraform apply
```
> ⚠️ **IMPORTANT**: In production, `terraform apply` requires manual confirmation. In this educational repository, no cloud deployment is executed.

---

## 🔄 Terraform Resource Lifecycle & Destruction Concepts

Understanding the lifecycle of cloud infrastructure is critical for every DevOps engineer:

1. **`terraform destroy` Purpose**:
   `terraform destroy` is a built-in lifecycle command designed to cleanly remove all resources tracked by the state file. It calculates reverse dependency order (e.g., deleting a Virtual Machine before deleting its Virtual Network).

2. **Accidental Deletion via Code Removal**:
   Removing a resource block from your `.tf` file and running `terraform apply` will cause Terraform to plan the **destruction** of that cloud resource. Terraform's declarative model ensures that what is in your code matches what exists in the cloud.

3. **Plan Review is Mandatory**:
   Never run `terraform destroy -auto-approve` or `terraform apply -auto-approve` casually. Always inspect the generated plan to verify which resources are being added (`+`), modified (`~`), or destroyed (`-`).

4. **Code vs State vs Cloud Resource**:
   - **Configuration Code**: The `.tf` files in Git declaring desired state.
   - **State File**: The record mapping your HCL blocks to real Azure Resource IDs.
   - **Cloud Resource**: The live running service in Azure.
   Removing code removes the resource from the desired state; Terraform will then offer to delete the cloud resource on the next apply unless explicitly removed from state using `terraform state rm`.

---

## 🤖 CI/CD Automation (GitHub Actions)

This repository includes a lightweight continuous integration workflow in `.github/workflows/validate.yml`.
On every `push` and `pull_request`, GitHub Actions:
1. Sets up the Terraform CLI.
2. Executes `terraform fmt -check -recursive` to enforce clean code style.
3. Runs `terraform init -backend=false` and `terraform validate` across root and example directories.

This ensures all code remains 100% syntactically correct without requiring cloud credentials or an active subscription.

---

## 👨‍💻 Author Information

- **Developer**: Vishal Yadav (`vishalnik002-git`)
- **Education**: MCA @ Galgotias University (2025–2027) | BCA @ MGKVP (2022–2025)
- **Role**: DevOps Intern @ DevOps Insiders
- **GitHub Profile**: [https://github.com/vishalnik002-git](https://github.com/vishalnik002-git)
