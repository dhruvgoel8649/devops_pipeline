# 1. Create the IAM Role that the EC2 instance will "assume"
resource "aws_iam_role" "ec2_role" {
  name = "ec2_ecr_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 2. Attach the Read-Only policy for ECR so the EC2 can pull images
resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# 3. Create the Instance Profile (the container for the role)
# This matches the name "ec2_profile" that your EC2 resource is looking for
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_ecr_profile"
  role = aws_iam_role.ec2_role.name
}
