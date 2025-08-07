const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:5000',
    supportFile: 'cypress/support/e2e.js',
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    video: true,
    screenshotOnRunFailure: true,
    viewportWidth: 1280,
    viewportHeight: 720,
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    pageLoadTimeout: 30000,
    chromeWebSecurity: false,
    env: {
      // Test user credentials
      testEmail: 'test@example.com',
      testPassword: 'testPassword123',
      // Firebase emulator URLs if needed
      firebaseAuthEmulator: 'http://localhost:9099',
      firestoreEmulator: 'http://localhost:8080'
    }
  },
  component: {
    devServer: {
      framework: 'react',
      bundler: 'webpack'
    }
  }
});