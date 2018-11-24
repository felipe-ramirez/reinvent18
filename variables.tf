variable "ghe_version" {
  description = "GitHub Enterprise version number"
}

variable "ghe_hostname" {
  description = "The hostname of the GHE appliance"
}

variable "ghe_license" {
  description = "GitHub Enterprise license file"
}

variable "ghe_settings" {
  description = "GitHub Enterprise exported settings file in JSON"
}

variable "primary" {
  description = "The instance considered the primary in an HA configuration."
  default = "0"
}

variable "vpc_id" {
  description = "The AWS VPC ID"
}

variable "subnet_ids" {
  description = "List of 2 AWS subnet IDs matching the AZs where each HA appliance will reside"
  type        = "list"
}

variable "instance_type" {
  description = "AWS Instance type to deploy for GitHub Enteprise appliance(s)"
}

variable "data_volume_size" {
  description = "Size in GB of data block device"
}
