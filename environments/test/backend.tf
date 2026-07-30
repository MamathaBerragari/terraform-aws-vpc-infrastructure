terraform {
  backend "s3" {
    bucket       = "global-tfstate-482112738265"
    key          = "environments/test/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
