# API Documentation

### Base URL

-

## Overview

| Inventory       | Item        | Record      | Username      |
| --------------- | ----------- | ----------- | ------------- |
| get inventories | get items   | post record | get usernames |
| post inventory  | post item   | get records | post username |
|                 | delete item |             |               |
|                 | update item |             |               |

## Endpoints

/inventories/{companyName}

- GET: Retrieve a list of inventories
- POST: Create a new inventory

/inventories/{companyName}/{inventoryName}/items

- GET: Retrieve a list of items in a specific inventory
- POST: Add a new item to a specific inventory
- UPDATE: Update details of a specific item in a specific inventory
- DELETE: Delete a specific item from a specific inventory

/inventories/{companyName}/{inventoryName}/records

- GET: Retrieve a list of records for a specific inventory
- POST: Add a new record to a specific inventory

/inventories/{companyName}/{inventoryName}/usernames

- GET: Retrieve a list of usernames
- POST: Create a new username
