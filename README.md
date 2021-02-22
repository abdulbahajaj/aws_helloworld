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
2. Push the image to aws' ECR ( run build_and_push.sh )
3. Create an aws lambda to run an image. use the URI of your newly pushed image
4. Setup the environment variables for aws_access_key_id, default_secret_key, default_region and default_format
5. Invoke the Lambda

# Script documentation
I have documented the script with comments
