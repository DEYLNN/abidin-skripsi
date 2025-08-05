// Environment Variables untuk Media Pembelajaran Tajwid
// Hard-coded environment variables

// Set environment variables langsung
window.ENV = {
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

// Set helper functions
window.getEnv = (key, defaultValue = null) => {
  return window.ENV[key] || defaultValue;
};

window.hasEnv = (key) => {
  return key in window.ENV;
};

// Override env-loader jika ada
if (window.envLoader) {
  window.envLoader.env = window.ENV;
  window.envLoader.loaded = true;
}

console.log("Hard-coded environment variables loaded");
console.log("Available variables:", Object.keys(window.ENV));
