# Signalfx-Dashboards-Charts-Terraform
Create dashboards and charts in SignalFx using Terraform

Cloning this git repository will demonstrate how to use terraform to deploy a team dashboard and charts to your SignalFx account.

# Assumptions
* You must have a Splunk SignalFx account (can be a trial)
* You must have terraform installed on your computer

# Lets do it

In the variables.tf, change the CHANGE_YOUR_NAME with a name that uniquely identifies your dashboards
In the variables.tf, change the api_url to your api_url if you are not using the default us0 realm
In the terraform.tfvars, change ENTER_YOUR_TOKEN_HERE with the token for your SignalFx admin user token

$ terraform init

$ terraform apply

Answer 'yes' to deploy.

Login to your Splunk SignalFx UI > Dashboards (top left) > search [YOUR_DASHBOARD_NAME]

Cleaning up when you are done'
When you are done, you can destroy your deployment using the following command.

$ terraform destroy

Answer 'yes' to destroy
