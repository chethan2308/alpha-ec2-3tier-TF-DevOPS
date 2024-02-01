output "jenkins-public-ip" {
  description = "this is jenkins master ip"
  value       = try(aws_instance.apache["master"].public_ip, "")

}

output "slave-public-ip" {
  description = "this is jenkins slave ip"
  value       = try(aws_instance.apache["slave"].public_ip, "")
}


output "terraform-ansible" {
  description = "this is jenkins terraform-ansible ip"
  value       = try(aws_instance.apache["ansible"].public_ip, "")
}