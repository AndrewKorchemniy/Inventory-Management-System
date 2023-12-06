# Database Schema

```mermaid
erDiagram
    COMPANY ||--o{ INVENTORY : contains
    COMPANY {
        string name
    }
    INVENTORY ||--o{ ITEM : contains
    INVENTORY ||--o{ USER : contains
    INVENTORY ||--o{ RECORD : contains
    INVENTORY ||--o{ ITEM_USAGE : contains
    INVENTORY {
        string name
        string companyName
    }
    USER ||--o{ RECORD : creates
    USER {
        string name
        string inventoryName
        string companyName
    }
    RECORD ||--|{ ITEM_USAGE : contains
    RECORD {
        string userName
        string batchName
        datetime dateManufactured
        string inventoryName
        string companyName
    }
    ITEM_USAGE }o--|| ITEM : contains
    ITEM_USAGE {
        string batchName
        string itemName
        float quantityUsed
        string inventoryName
        string companyName
    }
    ITEM {
        string name
        string inventoryName
        string companyName
        string manufactureName
        float quantity
        float quantityRemaining
        string quantityUnit
        datetime dateIntroduced
        datetime dateExpired
        string location
        bool isInspected
        string lotNumber
    }
```
