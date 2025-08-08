#!/bin/bash

# Build Flutter web with CanvasKit renderer
# This provides better compatibility but larger bundle size

ENV=${1:-dev}

echo "Building Flutter web with CanvasKit renderer for $ENV environment..."

# Clean previous build
flutter clean

# Build with CanvasKit renderer
flutter build web \
    --web-renderer canvaskit \
    --dart-define=ENV=$ENV \
    --base-href="/" \
    --release

echo "Build complete with CanvasKit renderer!"