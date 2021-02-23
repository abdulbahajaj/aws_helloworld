#!/usr/bin/env bash

export AWS_CONFIG_FILE=/tmp/.aws_config
export AWS_SHARED_CREDENTIALS_FILE=/tmp/.aws_creds

# Load ip-ranges, parse them and get cidr from each
cidr_list=$(curl https://ip-ranges.atlassian.com | jq -r ".items[].cidr")

# Iterate over the cidr list
for cidr in ${cidr_list}
do
    # Assume that the CIDR is ipv4 and add it
    echo "ADDING ${cidr} as IPV4"
    if ! aws ec2 authorize-security-group-ingress \
	 --group-name default \
	 --protocol -1 \
	 --cidr ${cidr};
    then
	# If CIDR has failed to be added as IPV4 assume that it is IPV6 and add it
	echo "ADDING ${cidr} as IPV6"
	aws ec2 authorize-security-group-ingress \
	    --group-name default \
	    --ip-permissions IpProtocol=-1,Ipv6Ranges=[{CidrIpv6=${cidr}}];
    fi
done
