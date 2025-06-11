# Development Workflow Guide

## Overview

This extension modifies VS Code's workbench files by injecting CSS and JS at runtime. This requires a special development workflow since changes need a full VS Code reload to be visible.

## Quick Start

### 1. Start Development Environment

```bash
# Option A: Run both watch and dev instance together
npm run dev:watch

# Option B: Run separately (recommended for debugging)
# Terminal 1: Start watch mode for automatic rebuilds
npm run watch:esbuild

# Terminal 2: Start isolated dev VS Code instance
npm run dev:instance
```

### 2. Test Your Changes

1. In the dev VS Code instance, open Command Palette (`Cmd+Shift+P`)
2. Run `SynthWave Liquid Glass: Enable Glow`
3. Your CSS changes from `dist/css/global.css` will be injected
4. Reload the dev instance (`Cmd+R`) to see visual changes

### 3. Reset When Needed

```bash
# Clean user data and restart dev instance
npm run dev:fresh
```

## Available Scripts

- `npm run dev:watch` - Runs watch mode + dev instance together
- `npm run dev:instance` - Starts isolated VS Code dev instance
- `npm run dev:fresh` - Cleans user data and restarts dev instance
- `npm run watch:esbuild` - Watches and rebuilds extension automatically

## VS Code Tasks

Use `Cmd+Shift+P` → "Run Task" to access:

- **Dev: Full Workflow** - Starts both watch mode and dev instance
- **Dev Extension (vscode-dev)** - Starts just the dev instance
- **npm: watch:esbuild** - Starts just the watch mode

## Development Environment Details

### Isolated Instance

- **User Data**: `/tmp/.vscode-dev` (isolated from your main VS Code)
- **Workspace**: `./examples` folder
- **Extensions**: All disabled except your extension under development
- **Persistent**: Settings and state persist between sessions

### File Structure

```
dist/css/global.css    # Your CSS modifications (auto-rebuilt)
src/css/global.css     # Source CSS (edit this)
.vscode-dev.mjs        # Dev instance configuration
.vscode-test.mjs       # Test instance configuration
```

## Daily Workflow

1. **Start Development**

   ```bash
   npm run dev:watch
   ```

   Or use VS Code task: "Dev: Full Workflow"

2. **Make Changes**

   - Edit CSS in `src/css/global.css`
   - Watch mode automatically rebuilds to `dist/css/global.css`

3. **Test Changes**

   - In dev instance: Run "SynthWave Liquid Glass: Enable Glow"
   - Reload dev instance (`Cmd+R`) to see changes

4. **Reset if Needed**
   ```bash
   npm run dev:fresh
   ```

## Benefits

✅ **Isolated Environment** - Clean VS Code instance with only your extension  
✅ **Persistent State** - User data persists between sessions  
✅ **Live Rebuild** - Watch mode rebuilds extension automatically  
✅ **Easy Reset** - Fresh start when needed  
✅ **Real Testing** - Test actual workbench modifications

## Troubleshooting

### Dev instance won't start

```bash
# Clean and restart
npm run dev:fresh
```

### Changes not visible

1. Ensure watch mode is running (`npm run watch:esbuild`)
2. Run the "Enable Glow" command in dev instance
3. Reload dev instance (`Cmd+R`)

### Extension not loading

Check that `.vscode-dev.mjs` has `installExtension: ["."]` configured.
