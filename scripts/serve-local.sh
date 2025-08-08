#!/bin/bash

# Local development server script
# This helps test the web build locally before deploying

echo "Building Flutter web for local testing..."

# Build Flutter web
flutter build web --dart-define=ENV=dev

echo "Starting local server..."

# Start a simple Python HTTP server
cd build/web
python3 -m http.server 8000

# Alternative using Node.js (if Python is not available):
# npx http-server build/web -p 8000