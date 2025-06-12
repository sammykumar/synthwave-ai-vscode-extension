#!/bin/bash
set -e

# Run initial build
echo "🎬 Starting watch mode for extension development..."
./scripts/rebuild-extension.sh

# Launch dev environment (only once)
echo "🎉 Launching VS Code Insiders development environment..."
pnpm run dev &
DEV_PID=$!

# Watch for changes using Node.js and chokidar
node -e "
const chokidar = require('chokidar');
const { exec } = require('child_process');
const path = require('path');

console.log('👀 Watching for changes in src/, themes/, package.json...');

const watcher = chokidar.watch([
  'src/**/*',
  'themes/**/*',
  'package.json'
], {
  ignoreInitial: true,
  ignored: ['**/node_modules/**', '**/dist/**', '**/.git/**']
});

let timeout;
watcher.on('all', (event, filePath) => {
  console.log(\`📁 File \${event}: \${filePath}\`);
  
  // Debounce rapid changes
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    console.log('🔄 Running dev rebuild process...');
    exec('./scripts/rebuild-extension.sh', { cwd: process.cwd() }, (error, stdout, stderr) => {
      if (error) {
        console.error('❌ Error during rebuild:', error);
        return;
      }
      console.log(stdout);
      if (stderr) console.error(stderr);
    });
  }, 500);
});

process.on('SIGINT', () => {
  console.log('\\n🛑 Stopping watch mode...');
  watcher.close();
  process.exit(0);
});

process.on('SIGTERM', () => {
  console.log('\\n🛑 Stopping watch mode...');
  watcher.close();
  process.exit(0);
});
"
