terraform {
  backend "remote" {
    organization = "github-minecraft"

    workspaces {
      name = "github-minecraft-automation"
    }
  }
}