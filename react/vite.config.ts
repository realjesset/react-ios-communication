import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      injectRegister: "auto",
      includeAssets: ["vite.svg", "favicon.ico"],
      manifest: {
        name: "React to Swift",
        short_name: "react-swift",
        description: "react to swift communication",
        theme_color: "#ffffff",
        scope: "/",
        start_url: "/",
        icons: [
          {
            src: "vite.svg",
            sizes: "192x192",
            type: "image/svg",
          },
          {
            src: "vite.svg",
            sizes: "512x512",
            type: "image/svg",
          },
        ],
      },
    }),
  ],
});
