import { Router } from 'express';
import * as admin from 'firebase-admin';

const router = Router();
const db = admin.firestore();

interface AuthenticatedRequest extends Request {
  organizationId?: string;
}

// GET /api/v1/products - List all products
router.get('/', async (req: any, res) => {
  try {
    const { organizationId } = req;
    const { limit = 100, offset = 0, search, category, active } = req.query;

    let query = db.collection('products')
      .where('organizationId', '==', organizationId);

    if (category) {
      query = query.where('categoryId', '==', category);
    }

    if (active !== undefined) {
      query = query.where('isActive', '==', active === 'true');
    }

    const snapshot = await query
      .limit(Number(limit))
      .offset(Number(offset))
      .get();

    const products = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));

    // Apply search filter if provided
    const filteredProducts = search
      ? products.filter((p: any) => 
          p.name.toLowerCase().includes(search.toString().toLowerCase()) ||
          p.sku.toLowerCase().includes(search.toString().toLowerCase())
        )
      : products;

    res.json({
      data: filteredProducts,
      total: filteredProducts.length,
      limit: Number(limit),
      offset: Number(offset)
    });
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

// GET /api/v1/products/:id - Get single product
router.get('/:id', async (req: any, res) => {
  try {
    const { organizationId } = req;
    const { id } = req.params;

    const doc = await db.collection('products').doc(id).get();
    
    if (!doc.exists) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const product = doc.data();
    if (product?.organizationId !== organizationId) {
      return res.status(403).json({ error: 'Access denied' });
    }

    res.json({
      id: doc.id,
      ...product
    });
  } catch (error) {
    console.error('Error fetching product:', error);
    res.status(500).json({ error: 'Failed to fetch product' });
  }
});

// POST /api/v1/products - Create new product
router.post('/', async (req: any, res) => {
  try {
    const { organizationId } = req;
    const productData = {
      ...req.body,
      organizationId,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    };

    const docRef = await db.collection('products').add(productData);
    const doc = await docRef.get();

    res.status(201).json({
      id: doc.id,
      ...doc.data()
    });
  } catch (error) {
    console.error('Error creating product:', error);
    res.status(500).json({ error: 'Failed to create product' });
  }
});

// PUT /api/v1/products/:id - Update product
router.put('/:id', async (req: any, res) => {
  try {
    const { organizationId } = req;
    const { id } = req.params;

    const doc = await db.collection('products').doc(id).get();
    
    if (!doc.exists) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const product = doc.data();
    if (product?.organizationId !== organizationId) {
      return res.status(403).json({ error: 'Access denied' });
    }

    const updateData = {
      ...req.body,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await doc.ref.update(updateData);
    const updatedDoc = await doc.ref.get();

    res.json({
      id: updatedDoc.id,
      ...updatedDoc.data()
    });
  } catch (error) {
    console.error('Error updating product:', error);
    res.status(500).json({ error: 'Failed to update product' });
  }
});

// DELETE /api/v1/products/:id - Delete product
router.delete('/:id', async (req: any, res) => {
  try {
    const { organizationId } = req;
    const { id } = req.params;

    const doc = await db.collection('products').doc(id).get();
    
    if (!doc.exists) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const product = doc.data();
    if (product?.organizationId !== organizationId) {
      return res.status(403).json({ error: 'Access denied' });
    }

    await doc.ref.delete();
    res.status(204).send();
  } catch (error) {
    console.error('Error deleting product:', error);
    res.status(500).json({ error: 'Failed to delete product' });
  }
});

export default router;