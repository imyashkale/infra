output "master-node-ssh" {
  description = "Master Node SSH"
  value       = "ssh -i ${var.local_key_path} ubuntu@${aws_instance.master-node.public_ip}"

}

output "worker-node-ssh" {
  description = "Worker Node SSH"
  value       = "ssh -i ${var.local_key_path} ubuntu@${aws_instance.worker-node.public_ip}"
}