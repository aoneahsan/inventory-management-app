import { Request, Response, NextFunction } from 'express';
import * as admin from 'firebase-admin';

interface RateLimitRequest extends Request {
  apiKey?: string;
}

const RATE_LIMIT_WINDOW = 60 * 1000; // 1 minute
const MAX_REQUESTS = 100;

export async function rateLimiter(
  req: RateLimitRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const apiKey = req.apiKey;
    if (!apiKey) {
      next();
      return;
    }

    const db = admin.firestore();
    const now = Date.now();
    const windowStart = now - RATE_LIMIT_WINDOW;

    // Get rate limit doc
    const rateLimitRef = db.collection('rateLimits').doc(apiKey);
    
    await db.runTransaction(async (transaction) => {
      const doc = await transaction.get(rateLimitRef);
      
      let requests: number[] = [];
      if (doc.exists) {
        const data = doc.data();
        requests = (data?.requests || []).filter((timestamp: number) => timestamp > windowStart);
      }

      if (requests.length >= MAX_REQUESTS) {
        res.status(429).json({
          error: 'Too Many Requests',
          message: `Rate limit exceeded. Max ${MAX_REQUESTS} requests per minute.`,
          retryAfter: Math.ceil((requests[0] + RATE_LIMIT_WINDOW - now) / 1000)
        });
        return;
      }

      requests.push(now);
      transaction.set(rateLimitRef, { requests }, { merge: true });
    });

    next();
  } catch (error) {
    console.error('Rate limit error:', error);
    // Don't block request on rate limit errors
    next();
  }
}