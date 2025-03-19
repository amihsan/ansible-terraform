import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()], // React plugin for JSX support, Fast Refresh, and React optimizations
  css: {
    preprocessorOptions: {
      scss: {
        quietDeps: true, // Suppress deprecation warnings from Bootstrap's @import
      },
    },
  },
});
