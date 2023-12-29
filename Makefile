

recreate-infra:
	echo 'Recreating Infrastructure'
	terraform fmt
	terraform destroy --auto-approve
	terraform apply --auto-approve