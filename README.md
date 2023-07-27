# Scalable and Secure Web Application
*This repository contains the Terraform scripts that you need to create a scalable and secure web application architecture on AWS.*

---

## Requirements

- You must have Terraform installed on your computer.

- You must have an AWS account.

- A security group that allows inbound HTTP traffic.

- A key pair that can be used to connect to the EC2 instances.

- An EC2 instance running the web application.

- A load balancer that distributes traffic to the EC2 instances.

- A target group that defines the health checks for the EC2 instances.

- A listener that routes traffic from the load balancer to the target group.

-An RDS instance that stores the data for the web application.

**Instructions**:
To create the web application architecture, you can follow these steps:

- Install Terraform.
- Clone this repository.
- Initialize Terraform.
- Plan the infrastructure changes.
- Apply the infrastructure changes.
- Securing the Communication Between the EC2 Instance and the RDS Instance
- The communication between the EC2 instance and the RDS instance is secured by using the following steps:

    1. *The EC2 instance is configured to use the security group that allows inbound traffic only on port 3306.*
    
    2. *The RDS instance is configured to use the security group that allows outbound traffic only to the EC2 instance on port 3306.*

    3. *The RDS instance is configured with a password that is strong and unique.*


-----

### AWS credentials

You must set up your AWS credentials. You can do this by setting up the following environment variables:

```````
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_REGION=us-west-2
``````


