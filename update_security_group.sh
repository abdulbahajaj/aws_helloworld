#!/usr/bin/env bash

export AWS_CONFIG_FILE=/tmp/.aws_config
export AWS_SHARED_CREDENTIALS_FILE=/tmp/.aws_creds

aws configure set aws_access_key_id ${aws_access_key_id}
aws configure set aws_secret_access_key ${default_secret_key}
aws configure set default.region ${default_region}
aws configure set default.output ${default_format}

cidr_list=$(curl https://ip-ranges.atlassian.com | jq -r ".items[].cidr")

for cidr in ${cidr_list}
do
    echo "ADDING ${cidr} as IPV4"
    if ! aws ec2 authorize-security-group-ingress \
	 --group-name default \
	 --protocol -1 \
	 --cidr ${cidr};
    then
	echo "ADDING ${cidr} as IPV6"
	aws ec2 authorize-security-group-ingress \
	    --group-name default \
	    --ip-permissions IpProtocol=-1,Ipv6Ranges=[{CidrIpv6=${cidr}}];
    fi
done
