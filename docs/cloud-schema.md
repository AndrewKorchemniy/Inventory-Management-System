# Inventory Management System
```mermaid
graph LR;
    frontend[Static Web App] --- apim{APIM}
    apim --- api_inventory & api_item & api_record & api_auth
    subgraph functions[Azure Functions]
        api_inventory[Inventory Endpoint]
        api_item[Item Endpoint]
        api_record[Record Endpoint]
        api_auth[Auth Endpoint]
    end
    api_inventory & api_item & api_record & api_auth --- cosmosdb[(Cosmos DB)]
    functions ---  logs>Log Analytics]
```

See the [API documentation](api-doc.md) for more detailed information.

| Inventory  | Item        | Record      | Auth          |
| -          | -           | -           | -             |
| get logs   | post item   | get records | get usernames | 
| get items  | update item | post record | post username | 
|            | delete item |             |               | 