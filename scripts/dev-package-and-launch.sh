#!/bin/bash
set -e

# Compile the extension
echo "🔨 Compiling extension..."
pnpm run compile

# Get current version and create dev version
CURRENT_VERSION=$(node -p "require('./package.json').version")
DEV_VERSION="${CURRENT_VERSION}-dev"
echo "📦 Creating dev package with version: $DEV_VERSION"

# Temporarily update version for dev build
npm version $DEV_VERSION --no-git-tag-version

# Package the extension
echo "📦 Packaging extension..."
pnpm run package

# Restore original version
npm version $CURRENT_VERSION --no-git-tag-version

# Install the dev VSIX in VS Code Insiders
DEV_VSIX="dist/vsix/synthwave-liquid-glass-${DEV_VERSION}.vsix"
echo "🚀 Installing dev extension: $DEV_VSIX"
code-insiders --install-extension "$DEV_VSIX" --force

# Launch dev environment
echo "🎉 Launching VS Code Insiders development environment..."
pnpm run dev
