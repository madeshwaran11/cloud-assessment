# Cloud Assessment Project

## Project Overview

This project demonstrates how to deploy a static website on AWS using Terraform for Infrastructure as Code (IaC) and GitHub Actions for Continuous Integration and Continuous Deployment (CI/CD).

The application is deployed on an Ubuntu EC2 instance with Apache Web Server and is publicly accessible over HTTP.

---

## Technologies Used

* AWS EC2
* IAM
* Security Groups
* Terraform
* GitHub
* GitHub Actions
* Apache Web Server
* HTML
* CSS
* JavaScript

---

## Project Structure

```text
aws-project/
│
├── website/
│   ├── index.html
│   ├── style.css
│   └── script.js
│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── userdata.sh
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
└── README.md
```

---

## Deployment Steps

1. Install Terraform and AWS CLI.
2. Configure AWS CLI.
3. Run:

   * terraform init
   * terraform validate
   * terraform plan
   * terraform apply
4. Connect to the EC2 instance.
5. Deploy the website files to `/var/www/html`.
6. Configure GitHub Actions for automatic deployment.

---

## Design Decisions

* Ubuntu 24.04 LTS selected as the operating system.
* Apache chosen as the web server.
* Terraform used for Infrastructure as Code.
* GitHub Actions used for CI/CD.
* Static website selected for simplicity and cost efficiency.

---

## Trade-offs Considered

* Static website instead of Node.js/Python backend.
* Single EC2 instance instead of Load Balancer.
* Manual infrastructure provisioning replaced by Terraform.

---

## Cost Awareness

* EC2 t2.micro (Free Tier eligible where applicable)
* Single VM deployment
* No Load Balancer
* No RDS Database
* Minimal AWS resource usage

---

## Cleanup

To remove all resources:

```bash
terraform destroy
```
