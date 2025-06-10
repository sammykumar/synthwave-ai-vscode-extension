import { defineConfig } from "@vscode/test-cli";

export default defineConfig({
  label: "development",
  files: "out/test/**/*.test.js",
  workspaceFolder:
    "/Users/samkumar/Development/SK-Productions-LLC/vscode-extensions/synthwave-ai-vscode-extension/examples",
  launchArgs: [
    "--disable-extensions",
    "--disable-workspace-trust",
    "--user-data-dir=/tmp/.vscode-dev",
    // Add headless options for CI
    ...(process.env.CI ? ["--headless"] : []),
  ],
  // mocha: {
  //   globalSetup: "./out/test/globalSetup.js",
  //   globalTeardown: "./out/test/globalTeardown.js",
  // },
  keepAlive: true, // This keeps the window open
});
