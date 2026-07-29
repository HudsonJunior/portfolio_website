import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { fileURLToPath, URL } from 'node:url';

export default defineConfig({
  plugins: [react()],
  publicDir: false,
  // React's CommonJS entry checks this value at runtime. A browser has no
  // global `process`, so replace it while bundling the custom element.
  define: {
    'process.env.NODE_ENV': JSON.stringify('production'),
  },

  build: {
    // Emit directly into Flutter's public web directory so the bundle used by
    // the app cannot drift from the React source.
    outDir: fileURLToPath(
      new URL(
        '../web/components/react-sandbox',
        import.meta.url,
      ),
    ),
    emptyOutDir: true,

    lib: {
      entry: fileURLToPath(
        new URL(
          './src/react-sandbox-element.tsx',
          import.meta.url,
        ),
      ),

      formats: ['es'],

      fileName: () => 'react-sandbox.js',

      cssFileName: 'react-sandbox',
    },
  },
});
