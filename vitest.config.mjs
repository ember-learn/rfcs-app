import { defineConfig } from 'vitest/config';
export default defineConfig({
  test: {
    include: ['node-tests/**/*.mjs'],
  },
});
