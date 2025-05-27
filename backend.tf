terraform {
  backend "remote" {
    organization = "the-best" 

    workspaces {
      name = "Multi-DR" 
    }
  }
}
