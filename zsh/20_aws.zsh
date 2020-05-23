#######
# AWS #
#######

export AWS_PAGER=""

# -------
# Aliases
# -------

alias ec2ls="aws ec2 describe-instances --query 'sort_by(Reservations[].Instances[].{Name:Tags[?Key==\`Name\`]|[0].Value, Environment:Tags[?Key==\`Environment\`]|[0].Value, Purpose:Tags[?Key==\`Purpose\`]|[0].Value, ID:InstanceId, AZ:Placement.AvailabilityZone, PrivateIP:PrivateIpAddress, PublicIP:PublicIpAddress, State:State.Name}, &Name)' --output table --region"
alias ec2-reboot="aws ec2 reboot-instances"

# ---------
# Functions
# ---------
awssh () {
  ssh -l admin -F ssh.config $1
}

# AWS Account (Easily switch between profiles)
awsacc () {
  if [ -z "$1" ]; then
    echo $AWS_PROFILE
  elif [ "$1" = "ls" ]; then
    grep '\[*\]' ~/.aws/credentials
  else
    export AWS_PROFILE="$1"
  fi
}

awsid () {
  aws ec2 describe-security-groups --group-names 'Default' --query 'SecurityGroups[0].OwnerId' --output text --region us-east-1
}

# Get Private IP of EC2 Instance by name
awsip () {
  aws ec2 describe-instances --filters Name=tag:Name,Values=$1 --query "Reservations[].Instances[].PrivateIpAddress" --region $2 --output text
}

# EC2 Describe by name
ec2d () {
  aws ec2 describe-instances --filters Name=tag:Name,Values=$1 --query "Reservations[].Instances[]" --region $2 --output table
}

aws-tag() {
  help() {
    echo "Tag an AWS resource"
    echo "Args:"
    echo "  1. AWS region"
    echo "  2. Resource ID"
    echo "  3. Tag Name"
    echo "  4. Tag Value"
  }
  if [ -z "$4" ]; then
    help
  else
    aws ec2 create-tags --region $1 --resources $2 --tags "Key=$3,Value=$4"
  fi
}

aws-untag() {
  help() {
    echo "Untag an AWS resource"
    echo "Args:"
    echo "  1. AWS region"
    echo "  2. Resource ID"
    echo "  3. Tag Name"
  }
  if [ -z "$3" ]; then
    help
  else
    aws ec2 delete-tags --region $1 --resources $2 --tags "Key=$3"
  fi
}

ec2-inspect() {
  help() {
    echo "Describe an EC2 instance"
    echo "Args:"
    echo "  1. AWS region"
    echo "  2. EC2 ID"
  }
  if [ -z "$2" ]; then
    help
  else
    aws ec2 describe-instances --filters "Name=instance-id,Values=$2" --output table --region $1
  fi
}
