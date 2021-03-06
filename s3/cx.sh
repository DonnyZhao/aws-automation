# AWS Scripts Command-line Assistant
#================================================================
clear
source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
STACK_NAME="IPA-BIA-stack1"
TEST_COUNTER=0

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo 100 : AWS S3 Validate Official S3 Bucket List
echo 101 : AWS S3 Create Official S3 Bucket List
echo 102 : AWS S3 Validate Bucket Permissions
echo 103 : AWS S3 Validate Bucket Encryption
echo 104 : AWS S3 Tag Buckets
echo ----------------------------------------------
echo 200 : AWS CloudFormation create-stack Create S3 Buckets
echo 201 : AWS CloudFormation deploy Create S3 Buckets
echo 202 : AWS CloudFormation delete-stack Delete S3 Buckets
echo ----------------------------------------------
echo 500 : AWS CloudFormation detect-stack-drift
echo 501 : AWS CloudFormation detect-stack-resource-drift
echo 502 : AWS CloudFormation describe-stack-resource-drifts
echo ----------------------------------------------
echo Enter [Selection] to continue
echo =============================================================

# Command line selection
if [ -n "$1" ]; then
  SELECTION=$1
else
  read  -n 3 SELECTION
fi

if [ -n "$2" ]; then
  PROFILE=$2
fi

echo Your selection is : $SELECTION.
echo Your profile is : $PROFILE.


case "$SELECTION" in
"001" )
  echo "===== AWS Configure - Setup"
  aws configure
  ;;


"002" )
  echo "===== AWS S3 List:" $PROFILE
  aws s3 ls \
		--profile $PROFILE
  echo "Count:"
  aws s3 ls \
		--profile $PROFILE | wc -l

  #aws s3 ls s3://bucketname
  #aws s3 cp 
  # aws s3 sync local s3://remote
  ;;


"003" )
  echo "===== AWS Assume Role:" $PROFILE
  # aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxxxxx:role/AWSAdmin" --role-session-name AWSCLI-Session
  # aws sts get-caller-identity --profile ipadev 
  ;;


"200" )
  echo "===== AWS CF create-stack Create S3 Buckets:" $PROFILE
  STACK_NAME="terence-s3-stack1"
  aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://stacks/s3-buckets-cf1.yaml \
    --role-arn $STACK_ROLE \
  ;;



"201" )
  echo "===== AWS CF create-stack Create S3 Buckets:" $PROFILE
  STACK_NAME="terence-s3-stack1"
  aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-file ./stacks/s3-buckets-cf1.yaml \
    --role-arn $STACK_ROLE \
  ;;


"202" )
  echo "===== AWS CF delete-stack Delete S3 Buckets:" $PROFILE
  STACK_NAME="terence-s3-stack1"
  aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"500" )
  echo "===== AWS CF detect-stack-drift:" $PROFILE
  aws cloudformation detect-stack-drift \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"501" )
  echo "===== AWS CF detect-stack-resource-drift:" $PROFILE
  aws cloudformation detect-stack-resource-drift \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"502" )
  echo "===== AWS CF describe-stack-resource-drifts:" $PROFILE
  aws cloudformation describe-stack-resource-drifts \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;



# Attempt to cater for ESC
"\x1B" )
  echo ESC1
  exit 0
  ;;


# Attempt to cater for ESC
"^[" )
  echo ESC2
  exit 0
  ;;

# ------------------------------------------------
#  GIT
# ------------------------------------------------
* )
  # Default option.
  # Empty input (hitting RETURN) fits here, too.
  echo
  echo "Not a recognized option."
  ;;
esac



