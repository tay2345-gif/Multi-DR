terraform {
  cloud {
    organization = "the-best"
    workspaces {
      name = "Multi-DR"
    }
  }
}