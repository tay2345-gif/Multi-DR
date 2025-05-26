terraform {
  cloud {
    organization = "the-best"
    workspaces {
      name = "multi-region"
    }
  }
}