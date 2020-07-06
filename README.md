Build and Deploying a simple microservice to ECS Fargate Cluster
----------------------------------------------------------------
-   This application builds a simple NodeJs application using Docker
-   Creates infrastructure in AWS using Terraform (Infrastructure as Code). Infrastructure includes VPC, ECR Repository, Application Load Balancer, Roles, Subnets, Security groups, ECS Fargate Cluster and finally deployes the above app to the Cluster.


Pre-requisites
--------------

-	A valid AWS account with S3 bucket with named "stream-tweets"
-	Basic Jenkins CI with Terraform(>=Version 12) installed in the slave
-   Jenkins credentials for 1. Github 2. AWS Credentials with ID as aws-id 3. AWS ECR Plug-in Credentials with ID as aws-ecr.

Usage
-----

-	Create a jenkins pipeline job using the given Jenkinsfile.
-   Once the application is deployed, it can be accessed using the alb dns name on port 80.