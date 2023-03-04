resource "aws_flow_log" "vpc" {
  traffic_type = "ALL"

  # The ID of the VPC to enable flow logs for
  vpc_id = aws_vpc.cloud.id

  # forward vpc flow log to cloudwatch
  log_destination = aws_cloudwatch_log_group.vpc_traffic.arn
  iam_role_arn    = aws_iam_role.cloudwatch.arn
}

resource "aws_cloudwatch_log_group" "vpc_traffic" {
  name = "${var.environment}-${aws_vpc.cloud.id}-vpc_raffic"
}

resource "aws_iam_role" "cloudwatch" {
  name = "${var.environment}-${aws_vpc.cloud.id}-cloudwatch-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com",
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "${var.environment}-${aws_vpc.cloud.id}-cloudwatch-policy"
  role = aws_iam_role.cloudwatch.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Amazon Kinesis Data Firehose logging

// resource "aws_flow_log" "example" {
//   log_destination      = aws_kinesis_firehose_delivery_stream.example.arn
//   log_destination_type = "kinesis-data-firehose"
//   traffic_type         = "ALL"
//   vpc_id               = aws_vpc.example.id
// }
// 
// resource "aws_kinesis_firehose_delivery_stream" "cloudwatch" {
//   name        = "kinesis_firehose_test"
//   destination = "extended_s3"
// 
//   extended_s3_configuration {
//     role_arn   = aws_iam_role.example.arn
//     bucket_arn = aws_s3_bucket.example.arn
//   }
// 
//   tags = {
//     "LogDeliveryEnabled" = "true"
//   }
// }
// 
// resource "aws_s3_bucket" "example" {
//   bucket = "example"
// }
// 
// resource "aws_s3_bucket_acl" "example" {
//   bucket = aws_s3_bucket.example.id
//   acl    = "private"
// }
// 
// resource "aws_iam_role" "cloudwatch" {
//   name               = "firehose_test_role"
//   assume_role_policy = <<EOF
//  {
//    "Version":"2012-10-17",
//    "Statement": [
//      {
//        "Action":"sts:AssumeRole",
//        "Principal":{
//          "Service":"firehose.amazonaws.com"
//        },
//        "Effect":"Allow",
//        "Sid":""
//      }
//    ]
//  }
//  EOF
// }
// 
// resource "aws_iam_role_policy" "cloud_watch" {
//   name   = "test"
//   role   = aws_iam_role.cloudwatch.id
//   policy = <<EOF
//  {
//    "Version":"2012-10-17",
//    "Statement":[
//      {
//        "Action": [
//          "logs:CreateLogDelivery",
//          "logs:DeleteLogDelivery",
//          "logs:ListLogDeliveries",
//          "logs:GetLogDelivery",
//          "firehose:TagDeliveryStream"
//        ],
//        "Effect":"Allow",
//        "Resource":"*"
//      }
//    ]
//  }
//  EOF
// }

// resource "aws_s3_bucket" "vpc_flow_log" {
//   bucket = "${aws_vpc.coud.id}-logs-bucket"
//   acl    = "private"
// 
//   server_side_encryption_configuration {
//     rule {
//       apply_server_side_encryption_by_default {
//         sse_algorithm = "AES256"
//       }
//     }
//   }
// 
//   # Configure bucket policy to restrict access
//   policy = jsonencode({
//     Version = "2012-10-17"
//     Statement = [
//       {
//         Action = [
//           "s3:GetObject",
//           "s3:ListBucket"
//         ]
//         Effect = "Allow"
//         Principal = {
//           AWS = [
//             "arn:aws:iam::863783060764:user/chengkli"
//           ]
//         }
//         Resource = [
//           "${aws_s3_bucket.vpc_flow_log.arn}",
//           "${aws_s3_bucket.vpc_flow_log.arn}/*",
//          ]
//        },
//        {
//          Action = "s3:*"
//          Effect = "Deny"
//          Principal = "*"
//          Resource = [
//            "${aws_s3_bucket.vpc_flow_log.arn}",
//            "${aws_s3_bucket.vpc_flow_log.arn}/*",
//           ]
//         }
//       ]
//     })
// 
//     tags = {
//       Name        = "Example Bucket"
//       Environment = "Production"
//     }
//   }
