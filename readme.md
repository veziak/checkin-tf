
## Terraform project to create infrastructure for Checkin apps 

Following AWS resources will be created:
- ECS cluster running a task with two containers: checkin-backend and checkin-frontend
- Autoscaling configured for ECS cluster
- DynamoDB table
- DNS records and certificate for the website
- Application load balancer pointing to ECS cluster
- CloudWatch Log Groups


## How to create infrastructure

1. Create ECR repositories for checkin-frontend and checkin-backend apps. 
``` 
   aws ecr create-repository \
   --repository-name checkin-backend \
   --image-scanning-configuration scanOnPush=true \
   --region eu-west-2

   aws ecr create-repository \
   --repository-name checkin-frontend \
   --image-scanning-configuration scanOnPush=true \
   --region eu-west-2
```

2. Build docker images for the apps and push it to ECR repos

```
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-backend
docker build --tag checkin-backend .
docker tag checkin-backend:latest $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-backend:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-backend:latest

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-frontend
docker build --tag checkin-frontend .
docker tag checkin-frontend:latest $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-frontend:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/checkin-frontend:latest
```

3. create terraform.tfvars file and set all required values

```
aws_account_id       = <AWS Account Id>
ecs_cluster_name     = "checkin-cluster"
region               = "<aws region>"
availability_zones   = ["<aws region>-2a", "<aws region>-2b"]
backend_image_url    = "<AWS Account Id>.dkr.ecr.<aws region>.amazonaws.com/checkin-backend:latest"
frontend_image_url   = "<AWS Account Id>.dkr.ecr.<aws region>.amazonaws.com/checkin-frontend:latest"
domain_name          = "test.example.com"
route53_zone         = "example.com"
```


4. Run terraform
```
terraform init
terraform apply
```

5. Check that test.example.com website is up and running.

