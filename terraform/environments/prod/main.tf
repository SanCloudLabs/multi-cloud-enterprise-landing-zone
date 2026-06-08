module "azure_network" {
  source              = "../../modules/azure_network"
  environment         = var.environment
  location            = var.azure_location
  hub_cidr            = "10.0.0.0/16"
  spoke_cidr          = "10.1.0.0/16"
  resource_group_name = "rg-enterprise-prod-hz"
}

module "azure_security" {
  source              = "../../modules/azure_security"
  environment         = var.environment
  location            = var.azure_location
  resource_group_name = module.azure_network.rg_name
  subnet_id           = module.azure_network.spoke_app_subnet_id
}

module "aws_vpc" {
  source           = "../../modules/aws_vpc"
  environment      = var.environment
  aws_region       = var.aws_region
  vpc_cidr         = "172.16.0.0/16"
  public_subnets   = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnets  = ["172.16.10.0/24", "172.16.11.0/24"]
}
