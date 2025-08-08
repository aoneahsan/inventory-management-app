import * as express from 'express';
import * as cors from 'cors';
import { authenticateApiKey } from './middleware/auth';
import { rateLimiter } from './middleware/rate-limit';
import { errorHandler } from './middleware/error-handler';
import productsRouter from './routes/products';
import ordersRouter from './routes/orders';
import customersRouter from './routes/customers';
import inventoryRouter from './routes/inventory';
import webhooksRouter from './routes/webhooks';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint (no auth required)
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// API documentation endpoint
app.get('/docs', (req, res) => {
  res.json({
    version: 'v1',
    endpoints: {
      products: '/api/v1/products',
      orders: '/api/v1/orders',
      customers: '/api/v1/customers',
      inventory: '/api/v1/inventory',
      webhooks: '/api/v1/webhooks'
    },
    authentication: 'API Key required in X-API-Key header',
    rateLimit: '100 requests per minute per API key'
  });
});

// Apply authentication and rate limiting to all API routes
app.use('/api/v1', authenticateApiKey, rateLimiter);

// API Routes
app.use('/api/v1/products', productsRouter);
app.use('/api/v1/orders', ordersRouter);
app.use('/api/v1/customers', customersRouter);
app.use('/api/v1/inventory', inventoryRouter);
app.use('/api/v1/webhooks', webhooksRouter);

// Error handling
app.use(errorHandler);

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Endpoint ${req.method} ${req.path} not found`
  });
});

export default app;