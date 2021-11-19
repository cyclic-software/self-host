#!/usr/bin/env bash
set -ex

aws --version

# externalId=$(echo $RANDOM | shasum | shasum | shasum | awk '{print $1}')
# externalId=$(echo "$RANDOM $(curl --silent "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=1000000000&count=100") $(date) $(uname -a)" | shasum | shasum | shasum | awk '{print $1}')
externalId=$(head -c${1:-128} < /dev/urandom | shasum | awk '{print $1}')

#cyclic-software/aws-self-hosting-role

aws cloudformation create-stack \
	--stack-name cyclic-management-role-global \
	--capabilities CAPABILITY_NAMED_IAM \
	--template-body file://account/bootstrap.yaml \
	--parameters ParameterKey=ExternalId,ParameterValue="$externalId" \
	--region us-east-2
