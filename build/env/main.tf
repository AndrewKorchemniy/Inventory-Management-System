# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "primary" {
  name     = "ims"
  location = "westus3"
}

# Create Azure Storage Account required for Function App
resource "azurerm_storage_account" "primary" {
  name                     = "imsstorageaccount"
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Azure App Service Plan using Consumption pricing
resource "azurerm_app_service_plan" "primary" {
  name                = "ims-app-service-plan"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  kind                = "FunctionApp"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create Azure Function App
resource "azurerm_function_app" "primary" {
  name                       = "inventory-management-system-function-app"
  resource_group_name        = azurerm_resource_group.primary.name
  location                   = azurerm_resource_group.primary.location
  app_service_plan_id        = azurerm_app_service_plan.primary.id
  storage_account_name       = azurerm_storage_account.primary.name
  storage_account_access_key = azurerm_storage_account.primary.primary_access_key
  version                    = "~3"

  site_config {
    always_on = true
  }
}

# Create Azure Cosmos DB Account
resource "azurerm_cosmosdb_account" "primary" {
  name                      = "ims-cosmosdb-account"
  location                  = azurerm_resource_group.primary.location
  resource_group_name       = azurerm_resource_group.primary.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  enable_free_tier          = true
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  geo_location {
    location          = azurerm_resource_group.primary.location
    failover_priority = 0
  }
  capabilities {
    name = "EnableServerless"
  }
}

# Create Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "primary" {
  name                = "ims-log-analytics-workspace"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Create Azure APIM instance
resource "azurerm_api_management" "primary" {
  name                = "ims-apim-apk"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  publisher_name      = "Andrew Korchemniy"
  publisher_email     = "andrewkorch@gmail.com"
  sku_name            = "Developer_1"
}
