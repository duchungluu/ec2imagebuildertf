resource "aws_iam_instance_profile" "ec2" {
  name = "ec2_windows"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "ec2_buildimage_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
        "Service": [
           "ec2.amazonaws.com",
           "imagebuilder.amazonaws.com"
          ]
      },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
