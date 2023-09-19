variable "keyfile" {
  description = "Please Enter json name file and path"
  type        = string
  default     = "../gcp-key/gd-gcp-gridu-devops-t1-t2-e0c795825e24.json"
}
variable "gke_num_nodes" {
  description = "number of gke nodes"
}
variable "project_id" {
  description = "project id"
}
variable "region" {
  description = "region"
}
variable "zone" {
  description = "zone"
}
variable "name" {
  description = "name"
}
variable "ports" {
  type        = list
  description = "port for access"
}
variable "source_range_all" {
 description = "Please Enter ip source range address for other"
 type        = list
}