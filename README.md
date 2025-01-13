# Coin Management API

This is a simple API for managing coins in an account. It allows users to:

1. Add new coins to an account or update existing coins' quantities.
2. Retrieve all coins associated with an account.
3. Retrieve details for a specific coin.

## Example API Endpoints
1. GET /api/v1/coins

2. GET /api/v1/coins?account_id=<account_id>
    Retrieve all the coins associated with a specific account.

3. POST /api/v1/coins
    Create a new coin or update an existing coin's quantity. If the coin already exists, the quantity will be updated.

4. POST /api/v1/coins?account_id=<account_id>

   Request:
    ```bash
    {
      "coin": "BTC",
      "quantity": 10
    }
    ```
    
    Response:
   ```bash
    {
      "success": true,
      "coin": {
        "name": "BTC",
        "quantity": 10
      }
    }
   ```
4. GET /api/v1/coins/:coin_name
Retrieve details for a specific coin associated with the account.

5. GET /api/v1/coins/BTC?account_id=<account_id>

   Response:
   ```bash
    {
      "success": true,
      "coin": {
        "name": "BTC",
        "quantity": 10
      }
    }
   ```

