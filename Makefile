

recreate-infra:
	terraform destroy --auto-approve
	terraform apply --auto-approve