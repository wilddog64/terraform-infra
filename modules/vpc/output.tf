output "id" {
  value = aws_vpc.cloud.id
}

output "public_subnet_ids" {
  value = [for k, v in aws_subnet.public: v.id]
}

output "private_subnet_ids" {
  value = [for k, v in aws_subnet.private: v.id]
}
