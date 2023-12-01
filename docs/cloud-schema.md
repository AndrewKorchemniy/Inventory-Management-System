```mermaid
---
title: Inventory Management System
---
graph LR;
    frontend[Static Web App] --- apim{APIM}
    apim --- api_inventory & api_item & api_formulate & api_auth
    subgraph functions[Azure Functions]
        api_inventory[Inventory Endpoint]
        api_item[Item Endpoint]
        api_formulate[Formulate Endpoint]
        api_auth[Auth Endpoint]
    end
    api_inventory & api_item & api_formulate & api_auth --- cosmosdb[(Cosmos DB)]
```


### Inventory Endpoint
 - get inventory logs
 - get inventory records
 - get inventory items
### Item Endpoint
 - post item
 - update item
 - delete item
### Formulate Endpoint
 - post record of item usage
### Auth Endpoint
 - get users

Extras/TODO:  Audit log, storage queue

