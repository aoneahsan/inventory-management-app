#!/bin/bash

# Deploy script for Firebase Hosting
# Usage: ./scripts/deploy-web.sh [dev|staging|prod]

ENV=${1:-dev}

echo "Building Flutter web for $ENV environment..."

# Clean previous build
flutter clean

# Build Flutter web with appropriate environment
if [ "$ENV" = "prod" ]; then
    flutter build web --release --dart-define=ENV=prod --base-href="/"
    SITE="inventory-management-prod"
elif [ "$ENV" = "staging" ]; then
    flutter build web --release --dart-define=ENV=staging --base-href="/"
    SITE="inventory-management-staging"
else
    flutter build web --dart-define=ENV=dev --base-href="/"
    SITE="inventory-management-dev"
fi

echo "Build complete. Deploying to Firebase Hosting site: $SITE..."

# Deploy to Firebase Hosting
firebase deploy --only hosting:$SITE

echo "Deployment complete!"
echo "Visit your site at: https://$SITE.web.app"