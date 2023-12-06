# Cloud Schema

```mermaid
graph LR;
    frontend[Static Web App] --- apim{APIM}
    apim --- api_inventory & api_item & api_record & api_username
    subgraph functions[Azure Functions]
        api_inventory[Inventory]
        api_item[Item]
        api_record[Record]
        api_username[Username]
    end
    api_inventory & api_item & api_record & api_username --- cosmosdb[(Cosmos DB)]
    functions ---  logs>Log Analytics]
```

See the [API documentation](api-doc.md) for more detailed information.

| Inventory       | Item        | Record      | Username      |
| --------------- | ----------- | ----------- | ------------- |
| get inventories | get items   | post record | get usernames |
| post inventory  | post item   | get records | post username |
|                 | delete item |             |               |
|                 | update item |             |               |
