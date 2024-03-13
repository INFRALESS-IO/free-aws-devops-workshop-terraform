provider "aws" {
  profile = "workshop-1"
  region = "${var.region}" # Define AWS region
}
