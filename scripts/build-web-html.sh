#!/bin/bash

# Build Flutter web with HTML renderer
# This provides smaller bundle size but may have compatibility issues

ENV=${1:-dev}

echo "Building Flutter web with HTML renderer for $ENV environment..."

# Clean previous build
flutter clean

# Build with HTML renderer
flutter build web \
    --web-renderer html \
    --dart-define=ENV=$ENV \
    --base-href="/" \
    --release

echo "Build complete with HTML renderer!"