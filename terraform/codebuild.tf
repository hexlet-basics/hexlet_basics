resource "aws_s3_bucket" "codebuild_cache" {
  bucket = "hexlet-basics-codebuild-cache"
  acl    = "private"
}

resource "aws_iam_role" "codebuild" {
  name = "hexlet-basics-codebuild"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codebuild" {
  name        = "hexlet-basics-codebuild"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:GetAuthorizationToken",
        "ecr:CompleteLayerUpload",
        "s3:CreateBucket",
        "s3:GetObject",
        "s3:List*",
        "s3:PutObject"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "codebuild" {
  name       = "hexlet-basics-codebuild"
  policy_arn = "${aws_iam_policy.codebuild.arn}"
  roles      = ["${aws_iam_role.codebuild.id}"]
}

resource "aws_codebuild_project" "app" {
  name         = "hexlet-basics-app"
  description  = "Hexlet Basics"
  build_timeout      = "20"
  service_role = "${aws_iam_role.codebuild.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.codebuild_cache.bucket}"
  }

  environment {
    privileged_mode = true
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/docker:17.09.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      "name"  = "CONTAINER_REPOSITORY_URL"
      "value" = "${aws_ecr_repository.app.repository_url}"
    }

    environment_variable {
      "name"  = "REF_NAME"
      "value" = "latest"
    }
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/hexlet-basics/hexlet_basics.git"
  }

  /* tags { */
  /*   "Environment" = "Test" */
  /* } */
}
