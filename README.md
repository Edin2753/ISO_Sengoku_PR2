# ISO_Sengoku_PR2

Sengoku Period interactive web application deployed on AWS using Docker and Terraform.

## Project Structure
ISO_Sengoku_PR2/
├── pyapp/              # Application code
│   ├── frontend/       # Nginx + HTML
│   ├── backend/        # Flask API
│   └── db/             # init.sql
├── terraform-sengoku/  # Terraform infrastructure code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── images/             # Static images for S3
└── setup script/       # setup.sh for sandbox terminal

## Terraform Deployment

### Prerequisites
- AWS Academy Sandbox session running
- Access to the sandbox terminal

### Steps

1. In the sandbox terminal create a new file called `setup.sh` and paste the contents from `setup script/setup.sh` in this repo

2. Run the setup script:
```bash
bash setup.sh
```
This installs Terraform, checks for Git, clones the repo and runs terraform init automatically.

3. Navigate to the terraform folder:
```bash
cd ISO_Sengoku_PR2/terraform-sengoku
```

4. Deploy the infrastructure:
```bash
terraform apply
```
Type `yes` when prompted. Takes approximately 10-15 minutes.

5. Wait 3-5 minutes after completion for Docker containers to start on the EC2 instances.

6. Open the ALB DNS address from the terraform output in your browser:
http://sengoku-alb-xxxxxxxxxx.us-east-1.elb.amazonaws.com

## Terraform Outputs

| Output | Description |
|--------|-------------|
| alb_dns | Load Balancer URL — open this in browser |
| rds_endpoint | RDS PostgreSQL endpoint |
| ec2_1_public_ip | Public IP of EC2 instance 1 |
| ec2_2_public_ip | Public IP of EC2 instance 2 |

## Cleanup

```bash
terraform destroy
```

Note: AWS Academy Sandbox automatically destroys all resources when the session ends.

## Note on S3

Due to AWS Academy Sandbox IAM restrictions, the S3 bucket cannot be created via Terraform directly. The S3 bucket is automatically created via AWS CLI commands inside the EC2 user_data script. The Terraform S3 code is present in `main.tf` but commented out — it will work correctly on a full AWS account without sandbox restrictions.