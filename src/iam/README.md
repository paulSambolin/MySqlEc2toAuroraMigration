 needs us to provide him with the JSON policy documents that specify the access we'll need so he can create our AWS  accts.

Our user accounts need access to the following:

- S3 full access
-- to read backups and potentially delete and recreate them as needed for testing

- Aurora RDS
-- to create, teardown and administer Aurora DB instances

- EC2 access
-- full access to any instances we create
-- readonly access to all instances
-- to create EC2 instances for data validation and for the new EC2-mysql instance that will be used for a backout plan.
-- The EC2 instances that are created needs to have access to S3
-- Should only provide read-only access to security groups

- CloudWatch
-- full access to any cloudwatch views we create
-- readonly access to all cloudwatch views

- VPC readonly access

- CloudFormation
-- full access to any stacks we create
-- readonly access to all stacks

Per SOW, we *SHOULD NOT* have access to the following:
- IAM users & roles management
- VPC and networking management
-- Includes subnets, routing tables, ACLs, security groups
- Write access to application code repositories
- Encryption key management 
