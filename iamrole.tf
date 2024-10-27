# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name               = "techrite-cms-ec2-role-${var.environment}"
  assume_role_policy = <<EOF
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

#Create IAM Role S3 policy
resource "aws_iam_role_policy" "s3_policy" {
  name   = "techrite-cms-s3-policy"
  role   = aws_iam_role.ec2_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "techrite-cms-ec2-instance-profile-${var.environment}"
  role = aws_iam_role.ec2_role.id
}

# Create ECR Policy
resource "aws_iam_role_policy" "ecr_policy" {
  name = "techrite-cms-ecr-policy"
  role   = aws_iam_role.ec2_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecr:*",
            "Resource": "*"
        }
    ]
}
EOF
}