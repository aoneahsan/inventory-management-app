# Inventory Management API Documentation

## Overview

The Inventory Management API provides programmatic access to your inventory data. This RESTful API allows third-party applications to interact with products, orders, customers, and inventory data.

## Base URL

```
https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/api/v1
```

## Authentication

All API requests require authentication using an API key. Include your API key in the `X-API-Key` header:

```bash
curl -H "X-API-Key: sk_live_YOUR_API_KEY" https://api.example.com/v1/products
```

## Rate Limiting

API requests are limited to 100 requests per minute per API key. Rate limit information is included in response headers:

- `X-RateLimit-Limit`: Maximum requests per minute
- `X-RateLimit-Remaining`: Remaining requests in current window
- `X-RateLimit-Reset`: Unix timestamp when the rate limit resets

## Error Responses

All errors follow a consistent format:

```json
{
  "error": "Error Type",
  "message": "Human-readable error description",
  "code": "ERROR_CODE"
}
```

Common HTTP status codes:
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `429` - Too Many Requests
- `500` - Internal Server Error

## Endpoints

### Products

#### List Products
```http
GET /products
```

Query Parameters:
- `limit` (integer, default: 100): Maximum number of products to return
- `offset` (integer, default: 0): Number of products to skip
- `search` (string): Search products by name or SKU
- `category` (string): Filter by category ID
- `active` (boolean): Filter by active status

Response:
```json
{
  "data": [
    {
      "id": "prod_123",
      "name": "Product Name",
      "sku": "SKU001",
      "barcode": "1234567890",
      "description": "Product description",
      "categoryId": "cat_123",
      "unit": "pcs",
      "currentStock": 100,
      "minStock": 10,
      "sellingPrice": 29.99,
      "costPrice": 15.00,
      "isActive": true
    }
  ],
  "total": 150,
  "limit": 100,
  "offset": 0
}
```

#### Get Product
```http
GET /products/:id
```

Response:
```json
{
  "id": "prod_123",
  "name": "Product Name",
  "sku": "SKU001",
  "barcode": "1234567890",
  "description": "Product description",
  "categoryId": "cat_123",
  "unit": "pcs",
  "currentStock": 100,
  "minStock": 10,
  "maxStock": 500,
  "reorderPoint": 20,
  "reorderQuantity": 100,
  "sellingPrice": 29.99,
  "costPrice": 15.00,
  "taxRate": 0.08,
  "warehouseLocation": "A1-B2",
  "supplierId": "sup_123",
  "imageUrl": "https://example.com/image.jpg",
  "isActive": true,
  "metadata": {},
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

#### Create Product
```http
POST /products
```

Request Body:
```json
{
  "name": "Product Name",
  "sku": "SKU001",
  "barcode": "1234567890",
  "description": "Product description",
  "categoryId": "cat_123",
  "unit": "pcs",
  "minStock": 10,
  "sellingPrice": 29.99,
  "costPrice": 15.00,
  "taxRate": 0.08
}
```

#### Update Product
```http
PUT /products/:id
```

Request Body (partial update supported):
```json
{
  "name": "Updated Product Name",
  "sellingPrice": 34.99,
  "currentStock": 150
}
```

#### Delete Product
```http
DELETE /products/:id
```

### Orders

#### List Orders
```http
GET /orders
```

Query Parameters:
- `limit` (integer, default: 100)
- `offset` (integer, default: 0)
- `status` (string): Filter by order status
- `customerId` (string): Filter by customer
- `startDate` (ISO date): Filter orders after this date
- `endDate` (ISO date): Filter orders before this date

#### Get Order
```http
GET /orders/:id
```

#### Create Order
```http
POST /orders
```

Request Body:
```json
{
  "customerId": "cust_123",
  "items": [
    {
      "productId": "prod_123",
      "quantity": 2,
      "price": 29.99
    }
  ],
  "shippingAddress": "123 Main St",
  "notes": "Please handle with care"
}
```

### Customers

#### List Customers
```http
GET /customers
```

Query Parameters:
- `limit` (integer, default: 100)
- `offset` (integer, default: 0)
- `search` (string): Search by name, email, or phone
- `type` (string): Filter by customer type

#### Get Customer
```http
GET /customers/:id
```

#### Create Customer
```http
POST /customers
```

Request Body:
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "type": "retail",
  "creditLimit": 1000.00,
  "address": "123 Main St"
}
```

### Inventory

#### Get Stock Levels
```http
GET /inventory/stock
```

Query Parameters:
- `low_stock` (boolean): Show only low stock items
- `location` (string): Filter by warehouse location

#### Update Stock
```http
POST /inventory/adjust
```

Request Body:
```json
{
  "productId": "prod_123",
  "adjustment": 50,
  "type": "add",
  "reason": "Stock received",
  "reference": "PO-123"
}
```

#### Stock Movement History
```http
GET /inventory/movements
```

Query Parameters:
- `productId` (string): Filter by product
- `startDate` (ISO date)
- `endDate` (ISO date)
- `type` (string): Filter by movement type

### Webhooks

#### Register Webhook
```http
POST /webhooks
```

Request Body:
```json
{
  "url": "https://your-server.com/webhook",
  "events": ["order.created", "stock.low"],
  "active": true
}
```

#### List Webhooks
```http
GET /webhooks
```

#### Update Webhook
```http
PUT /webhooks/:id
```

#### Delete Webhook
```http
DELETE /webhooks/:id
```

## Webhook Events

Webhooks are sent as POST requests with the following structure:

```json
{
  "id": "evt_123",
  "type": "order.created",
  "timestamp": "2024-01-01T00:00:00Z",
  "data": {
    // Event-specific data
  }
}
```

Available events:
- `order.created` - New order created
- `order.updated` - Order status changed
- `order.completed` - Order completed
- `stock.low` - Product stock below minimum
- `stock.out` - Product out of stock
- `product.created` - New product added
- `product.updated` - Product details updated
- `customer.created` - New customer added

## Code Examples

### JavaScript/Node.js
```javascript
const axios = require('axios');

const API_KEY = 'sk_live_YOUR_API_KEY';
const BASE_URL = 'https://api.example.com/v1';

// List products
async function listProducts() {
  const response = await axios.get(`${BASE_URL}/products`, {
    headers: {
      'X-API-Key': API_KEY
    },
    params: {
      limit: 50,
      active: true
    }
  });
  
  return response.data;
}

// Create order
async function createOrder(orderData) {
  const response = await axios.post(`${BASE_URL}/orders`, orderData, {
    headers: {
      'X-API-Key': API_KEY,
      'Content-Type': 'application/json'
    }
  });
  
  return response.data;
}
```

### Python
```python
import requests

API_KEY = 'sk_live_YOUR_API_KEY'
BASE_URL = 'https://api.example.com/v1'

headers = {
    'X-API-Key': API_KEY,
    'Content-Type': 'application/json'
}

# List products
response = requests.get(
    f'{BASE_URL}/products',
    headers=headers,
    params={'limit': 50, 'active': True}
)
products = response.json()

# Create order
order_data = {
    'customerId': 'cust_123',
    'items': [
        {'productId': 'prod_123', 'quantity': 2, 'price': 29.99}
    ]
}
response = requests.post(
    f'{BASE_URL}/orders',
    headers=headers,
    json=order_data
)
order = response.json()
```

### cURL
```bash
# List products
curl -X GET "https://api.example.com/v1/products?limit=50&active=true" \
  -H "X-API-Key: sk_live_YOUR_API_KEY"

# Create order
curl -X POST "https://api.example.com/v1/orders" \
  -H "X-API-Key: sk_live_YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "customerId": "cust_123",
    "items": [
      {"productId": "prod_123", "quantity": 2, "price": 29.99}
    ]
  }'
```

## Best Practices

1. **Always use HTTPS** for API requests
2. **Store API keys securely** - Never commit them to version control
3. **Handle rate limits** - Implement exponential backoff for retries
4. **Validate webhooks** - Verify webhook signatures to ensure authenticity
5. **Use pagination** - For large datasets, use limit and offset parameters
6. **Cache responses** - Cache frequently accessed data to reduce API calls
7. **Handle errors gracefully** - Implement proper error handling for all API calls

## Support

For API support, please contact:
- Email: api-support@inventory-management.com
- Documentation: https://docs.inventory-management.com
- Status Page: https://status.inventory-management.com