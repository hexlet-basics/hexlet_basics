resource "aws_s3_bucket" "codepipline" {
  bucket = "hexlet-basics-codepipline"
  acl    = "private"
}

resource "aws_iam_role" "codepipeline" {
  name = "hexlet-basics-codepipeline"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "hexlet-basics-codepipeline"
  role = "${aws_iam_role.codepipeline.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObject",
        "s3:GetBucketVersioning",
        "s3:ListBucket",
        "s3:GetBucketPolicy",
        "s3:GetObjectAcl",
        "s3:PutObjectAcl",
        "s3:DeleteObject"
      ],
      "Resource": [
        "${aws_s3_bucket.codepipline.arn}",
        "${aws_s3_bucket.codepipline.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

/* data "aws_kms_alias" "s3kmskey" { */
/*   name = "alias/myKmsKey" */
/* } */

resource "aws_codepipeline" "app" {
  name     = "hexlet-basics-app"
  role_arn = "${aws_iam_role.codepipeline.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipline.bucket}"
    type     = "S3"
    /* encryption_key { */
    /*   id   = "${data.aws_kms_alias.s3kmskey.arn}" */
    /*   type = "KMS" */
    /* } */
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["hexlet-basics-source"]

      configuration {
        Owner      = "hexlet-basics"
        Repo       = "hexlet_basics"
        Branch     = "master"
        OAuthToken = "${var.github_oauth_token}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["hexlet-basics-source"]
      version         = "1"

      configuration {
        ProjectName = "${aws_codebuild_project.app.name}"
      }
    }
  }
}
