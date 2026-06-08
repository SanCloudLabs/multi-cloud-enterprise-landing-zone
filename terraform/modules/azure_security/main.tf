resource "azurerm_key_vault" "kv" {
  name                        = "kv-enterprise-prod-sec"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = "sub-placeholder-tenant-id"
  sku_name                    = "standard"
  purge_protection_enabled    = true
  public_network_access_enabled = false # Zero trust rule enforced
}

resource "azurerm_private_endpoint" "kv_endpoint" {
  name                = "pe-keyvault-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-keyvault"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}
