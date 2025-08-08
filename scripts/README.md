# Scripts Directory

This directory contains utility scripts for building, testing, and deploying the Inventory Management application.

## Available Scripts

### Deployment Scripts

#### `deploy-web.sh`
Builds and deploys the Flutter web app to Firebase Hosting.

```bash
# Deploy to development
./scripts/deploy-web.sh dev

# Deploy to staging  
./scripts/deploy-web.sh staging

# Deploy to production
./scripts/deploy-web.sh prod
```

### Build Scripts

#### `build-web-canvaskit.sh`
Builds Flutter web using the CanvasKit renderer (better compatibility, larger size).

```bash
./scripts/build-web-canvaskit.sh dev
```

#### `build-web-html.sh`
Builds Flutter web using the HTML renderer (smaller size, potential compatibility issues).

```bash
./scripts/build-web-html.sh dev
```

### Development Scripts

#### `serve-local.sh`
Builds and serves the web app locally for testing.

```bash
./scripts/serve-local.sh
# Visit http://localhost:8000
```

## Script Permissions

If you get a permission error, make scripts executable:

```bash
chmod +x scripts/*.sh
```

## Environment Variables

Scripts respect the following environments:
- `dev` - Development environment (default)
- `staging` - Staging environment
- `prod` - Production environment

## Troubleshooting

### 403 Forbidden Error
If you encounter this after deployment:
1. Check that Firebase hosting sites are configured
2. Verify `.firebaserc` has correct project mappings
3. Ensure you're logged into Firebase CLI
4. Review `firebase.json` configuration

### Build Failures
1. Run `flutter clean` before building
2. Ensure all dependencies are installed: `flutter pub get`
3. Check for any analyzer issues: `flutter analyze`

### Deployment Failures
1. Verify Firebase CLI is installed: `firebase --version`
2. Check you're using correct project: `firebase use`
3. Ensure you have deployment permissions in Firebase Console