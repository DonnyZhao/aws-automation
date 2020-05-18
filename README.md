# aws-automation
Scripts for automating AWS infrastructure

Patterns...

# Use Cases
- Script to establish a few lambda for Automation
- Script for Lambdas to establish the network environment/s
 - Script establishment of standard-pattern VPCs
 - Script establishment of Bastion Jumphosts
 - Script establishment of NATs
 - Script establishment of Internet Gateway
- Script Automation Host (e.g. Jenkins) establishment on an EC2 (need multiple Jenkins)

# Lambda-based Automation
- Script IAM create user + role + policy
- Script Dynamo Infrastructure State management
- Script Lambdas to test the infrastructure and environment + SNS + Dynamo update

# Related
- AWS Config can be used for resource inventory
