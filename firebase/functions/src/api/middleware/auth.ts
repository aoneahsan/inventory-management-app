import { Request, Response, NextFunction } from 'express';
import * as admin from 'firebase-admin';

interface AuthenticatedRequest extends Request {
  apiKey?: string;
  organizationId?: string;
}

export async function authenticateApiKey(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const apiKey = req.headers['x-api-key'] as string;

    if (!apiKey) {
      res.status(401).json({
        error: 'Unauthorized',
        message: 'API key is required'
      });
      return;
    }

    // Validate API key against Firestore
    const db = admin.firestore();
    const apiKeyDoc = await db
      .collection('apiKeys')
      .where('key', '==', apiKey)
      .where('active', '==', true)
      .limit(1)
      .get();

    if (apiKeyDoc.empty) {
      res.status(401).json({
        error: 'Unauthorized',
        message: 'Invalid API key'
      });
      return;
    }

    const apiKeyData = apiKeyDoc.docs[0].data();
    
    // Check if API key has expired
    if (apiKeyData.expiresAt && apiKeyData.expiresAt.toDate() < new Date()) {
      res.status(401).json({
        error: 'Unauthorized',
        message: 'API key has expired'
      });
      return;
    }

    // Update last used timestamp
    await apiKeyDoc.docs[0].ref.update({
      lastUsedAt: admin.firestore.FieldValue.serverTimestamp(),
      usageCount: admin.firestore.FieldValue.increment(1)
    });

    // Add organization ID to request
    req.apiKey = apiKey;
    req.organizationId = apiKeyData.organizationId;

    next();
  } catch (error) {
    console.error('Auth error:', error);
    res.status(500).json({
      error: 'Internal Server Error',
      message: 'Authentication failed'
    });
  }
}