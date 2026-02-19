terraform {
  backend "local" {
    path = "/home/ansible/terraform_state/ansible-env/terraform.tfstate"
  }
}