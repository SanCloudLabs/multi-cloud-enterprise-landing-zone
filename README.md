# Enterprise Multi-Cloud Landing Zone Architecture (IaC)

[![Terraform](https://img.shields.io/badge/Terraform-%235C4EE5.svg?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=flat&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Overview

This repository contains a production-grade, highly modularized Infrastructure as Code (IaC) blueprint written in **Terraform**. It defines a secure, compliant, and scalable multi-cloud Landing Zone topology spanning **Microsoft Azure** and **Amazon Web Services (AWS)**, designed to mimic enterprise-scale hybrid cloud environments.

The architecture focuses heavily on strict network isolation, zero-trust security postures, private endpoint integrations, and structured cloud governance—modeled on real-world migrations and modernization frameworks.

### 🤖 AI-Assisted Engineering Note
> This entire architecture was developed utilizing **Spec-Driven Development** methodologies. Workflows, resource naming patterns, and complex module relations were accelerated and validated using **GitHub Copilot** and custom AI workflows to simulate modern, rapid enterprise delivery cycles.

---

## 🏗️ Architectural Topology

The landing zone is split across both major cloud providers to handle hybrid workloads, featuring a structured Hub-and-Spoke model in Azure and a secure VPC layout in AWS optimized for hybrid compliance.

```mermaid
graph TD
    %% Azure Hub-and-Spoke
    subgraph Azure Cloud Environment
        HubVNet[Hub VNet] -->|VNet Peering| SpokeVNet[Spoke App VNet]
        
        subgraph HubVNet [Hub VNet - Shared Services]
            AzFW[Azure Firewall / App Gateway]
            VPNGW[VPN / ExpressRoute Gateway]
        end
        
        subgraph SpokeVNet [Spoke VNet - Workload Tier]
            AppSubnet[Application Subnet]
            DBSubnet[Isolated Database Subnet]
            KV[Azure Key Vault] --->|Private Endpoint| AppSubnet
            DB[Azure Database for Postgres] --->|Private Link| DBSubnet
        end
    end

    %% AWS Hybrid Simulation
    subgraph AWS Cloud Environment
        subgraph AWS VPC [Production VPC]
            IGW[Internet Gateway]
            PubSub[Public Subnet / NAT Gateway]
            PrivSub[Private App Subnet]
            IGW --> PubSub --> PrivSub
        end
        subgraph AWS Outpost [Hybrid Outpost Edge]
            OutpostCompute[Local Compute / Outpost Simulation]
        end
        PrivSub <-->|Secure Inter-Cloud Routing| OutpostCompute
    end

    %% Cross-Cloud Link
    VPNGW <==>|Secure Site-to-Site VPN Tunnel| IGW


🛠️ Repository Structure
The code is strictly decoupled into reusable, dry (Don't Repeat Yourself) Terraform modules.

├── .github/workflows/          # CI/CD pipelines for validation and planning
│   └── terraform-lint-plan.yml
├── terraform/
│   ├── environments/
│   │   └── prod/               # Root configuration executing the landing zone
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── modules/                # Reusable Infrastructure Modules
│       ├── azure_network/      # VNets, Subnets, Peerings, Route Tables, NSGs
│       ├── azure_security/     # Key Vault, Defender, Managed Identities
│       ├── azure_paas/         # App Services, Postgres DB with Private Links
│       ├── aws_vpc/            # VPC, Subnets, NAT Gateways, Secure Routing
│       └── aws_outpost_stub/   # Hybrid-cloud compute configuration
└── README.md



🔒 Implemented Key Features
1. Advanced Networking & Network Hardening
Azure Hub-and-Spoke VNet Topology: Isolates external traffic management (Azure Firewall, Application Gateway) within a central Hub VNet, routing safely to application workloads in spoke VNets via explicit user-defined routing tables.

AWS VPC Isolation: Implements public/private subnet architectures with multi-AZ deployment strategies, strictly routing outbound internal traffic through resilient NAT Gateways.

Hybrid Cloud Simulation: Simulates secure network routing patterns mapped out for On-Premises to AWS Outpost edge computing transitions.

2. Zero-Trust Security & Identity Governance
Network Isolation via Private Link: PaaS assets (such as Azure Key Vault and Managed Postgres) are completely blocked from public internet routing, exposed only inside isolated subnets via Private Endpoints.

Identity Assertions: Completely eliminates long-lived cloud access keys by using Azure Managed Identities and strict least-privilege IAM roles.

Micro-Segmentation: Granular Network Security Groups (NSGs) and AWS Security Groups enforcing strict layer-4 ingress and egress rules.

3. FinOps & Governance
Tagging Strategy: Enforces standardized, company-wide tagging variables across all multi-cloud components (Environment, CostCenter, Owner, Compliance) to support strict FinOps cloud cost optimization.

🚀 Deployment & Local Testing
Prerequisites
Terraform v1.5.0+

Azure CLI & AWS CLI configured with appropriate non-production testing sandboxes.

Initialization & Execution
1. Clone the repository:

git clone [https://github.com/SanCloudLabs/multi-cloud-enterprise-landing-zone.git](https://github.com/SanCloudLabs/multi-cloud-enterprise-landing-zone.git)
   cd multi-cloud-enterprise-landing-zone/terraform/environments/prod

2. Initialize backend storage accounts and provider plugins:
terraform init

3. Validate configuration syntax and resource compliance mappings:
terraform validate

4. Generate a declarative execution plan to preview infrastructure mutations:
terraform plan -out=tfplan.binary

📨 Contact & Consultation
This architecture was designed and is maintained by Santanu Banerjee.

If you are looking for a Senior/Lead DevOps & SRE Engineer capable of building highly secure enterprise platform architectures, let's connect:

💼 LinkedIn: linkedin.com/in/shantanubanerjee

📧 Email: saan123@gmail.com
