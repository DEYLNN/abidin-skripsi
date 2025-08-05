// Environment Loader untuk Media Pembelajaran Tajwid
// File ini akan load environment variables dari file .env

class EnvLoader {
  constructor() {
    this.env = {};
    this.loaded = false;
  }

  // Load environment variables langsung dari hard-coded values
  async loadFromEnvFile() {
    console.log("Loading hard-coded environment variables...");
    this.loadHardcodedEnv();
  }

  // Parse file .env (tidak digunakan lagi, langsung hard-coded)
  parseEnvFile(content) {
    // Fungsi ini tidak digunakan lagi karena langsung hard-coded
    console.log("parseEnvFile called but not used");
  }

  // Load hard-coded environment variables sebagai fallback
  loadHardcodedEnv() {
    this.env = {
      SUPABASE_URL: "https://jybgnujxmttmbzjvmuuw.supabase.co",
      SUPABASE_ANON_KEY:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5YmdudWp4bXR0bWJ6anZtdXV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzNjc2MjMsImV4cCI6MjA2OTk0MzYyM30.swolTdUv68TAvQk1u9m1xdU2wY1Jo5TdPGXorPWXTc4",
      APP_NAME: "TajwidMaster",
      APP_VERSION: "1.0.0",
      APP_ENV: "development",
      ENABLE_DEBUG: "true",
      ENABLE_ANALYTICS: "false",
      CACHE_DURATION: "3600",
    };
    console.log("Hard-coded environment variables loaded");
  }

  // Load default environment variables jika .env tidak ada (legacy)
  loadDefaultEnv() {
    this.loadHardcodedEnv();
  }

  // Get environment variable
  get(key, defaultValue = null) {
    return this.env[key] || defaultValue;
  }

  // Check if environment variable exists
  has(key) {
    return key in this.env;
  }

  // Get all environment variables
  getAll() {
    return { ...this.env };
  }

  // Initialize environment
  async init() {
    await this.loadFromEnvFile();

    // Set to window object for global access
    window.ENV = this.env;
    window.getEnv = (key, defaultValue) => this.get(key, defaultValue);
    window.hasEnv = (key) => this.has(key);

    this.loaded = true;
    console.log("Environment loader initialized");
  }
}

// Create global instance
window.envLoader = new EnvLoader();

// Auto-initialize when DOM is ready
document.addEventListener("DOMContentLoaded", () => {
  window.envLoader.init();
});
