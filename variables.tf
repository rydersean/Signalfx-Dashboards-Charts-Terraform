variable "signalfx_auth_token" {}

variable "tf_team_dashboard_group" {
	type = string
	default = "CHANGE_YOUR_NAME TF team dashboard group"
}

variable "tf_team_dashboard_group_description" {
	type = string
	default = "Terraform dashboard group"
}

variable "tf_dashboard" {
	type = string
	default = "CHANGE_YOUR_NAME Terraform Dashboard"
}

variable "api_url" {
	type = string
	default = "https://api.signalfx.com"
}
