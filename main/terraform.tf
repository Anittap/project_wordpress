terraform {
  backend "s3" {
    bucket = "anitta-project-tfstatefile"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
