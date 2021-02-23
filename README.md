# Intro
A script in bash that parse the Atlassian IP address ranges (https://ip-ranges.atlassian.com) and add them to aws' default security group

# Usage
Build the image then run it
```bash
docker build -t sgupdate .
docker run --env aws_access_key_id=${aws_access_key_id} \
       --env default_secret_key=${default_secret_key} \
       --env default_region=${default_region:-us-east-1} \
       --env default_format=${default_format:-json} \
	   -it sgupdate 
```

# Lambda setup
1. Create an ECR repository. Run `aws ecr create-repository --repository-name sgupdate --image-scanning-configuration scanOnPush=t` 
2. Build and push the image to aws' ECR. Run build_and_push.sh to achieve that. You need to export the following variables first.
   1. export aws_access_key_id = "Your access key id"
   2. export default_region = "us-east-1"
3. Create an IAM policy that allow ec2:AuthorizeSecurityGroupIngress
4. Create an AWS lambda execution role, attach the policy created in step 3 to it
5. Create an AWS lambda to run an image. use the URI of your newly pushed image ( in step 2 )
6. Use the execution role created in step 4 as the execution role of your newly created Lambda function
7. Invoke the Lambda function

# Script documentation
I have documented the script with comments

# References
1. [Creating IAM policy and role](https://aws.amazon.com/blogs/security/how-to-automatically-update-your-security-groups-for-amazon-cloudfront-and-aws-waf-by-using-aws-lambda/)
