import { defineConfig } from "@vscode/test-cli";

export default defineConfig({
  label: "development",
  files: "out/test/**/*.test.js",
  workspaceFolder: "./examples", // Relative path is cleaner
  launchArgs: [
    "--disable-workspace-trust",
    "--user-data-dir=/tmp/.vscode-dev",
    // Enable your extension for testing
    "--enable-proposed-api",
    // Keep other extensions disabled for isolation
    "--disable-extensions",
  ],
  keepAlive: true,
  // Optional: auto-install your extension
  installExtension: [
    ".", // Install current extension being developed
  ],
});
