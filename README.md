Use API Key and Terraform to create resources. Use S3 bucket for terraform state file.

1. VPC
Subnet: 10.0.0.0/16

2. Subnets

us-west-2a
i. subnet: 10.0.8.0/24

us-west-2b
i.  subnet: 10.0.9.0/24


3. Application Load Balancer

Type: ALB
Listener: HTTP
Target group with 2x EC2 instances on tcp/80
Security group allowing tcp/80 ingress from internet
4.  2x EC2 instances in separate az’s

Size: t3.micro
OS: Ubuntu Server
Ec2 instances must have the TAG:
Key: sysId           Value: 6f1bb632-da38-4e1f-86c3-6065f8662f88
Key: wy-a4f84a230c77
5.  Security group allowing

tcp/22 ingress from your public IP
tcp/80 ingress from loadbalancer
all ip egress to internet
6. Output:

EC2 instance ids
load balancer public DNS name
VPC id
Subnet id

In your preferred method, on the 2x EC2 Instances from above:

1. Install docker

2. Create php docker container which serves on tcp/80

3. Add 2x pages to the docker container

  a. /test.php - displays phpinfo()
  b. /index.html - Copy file ok.jpg from S3 bucket. Create index.html to display image.


* Use aws cli for all S3 operations.

Results:

Should be able to browse from internet addresses

  - http://loadbalancerFqdn/test.php

  - http://loadbalancerFqdn/index.html

Should NOT be able to browse from internet addresses
    
   - http://ec2publicIP1/test.php

   - http://ec2publicIP2/test.php

   - http://ec2publicIP1/index.html

   - http://ec2publicIP2/index.html
 
Upload to S3 bucket

1.  Text file containing output of your terraform code which should include

EC2 instance IDs
Loadbalancer public DNS name
VPC id
Subnet ids
2. Compressed copy of your terraform code
