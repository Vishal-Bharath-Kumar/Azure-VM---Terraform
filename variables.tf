variable "subscription_id" {
  type = string
}
variable "resource_group_name" {
  default =  "ODL-azure-1257894"
}
variable "az_vn_name" {
  default = "virtualvishal04"
}
variable "az_subnet_name" {
  default = "vishalsubnet04"
}
variable "az_public_ip_name" {
  default = "vishalip004"
}
variable "az_inetwork_name" {
  default = "vishalnic"
}
variable "az_linux_vm_name" {
  default = "vishalvm004"
}