import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { resolve } from 'path';
import tocBuilder from './lib/toc-builder';
import buildRedirects from './lib/build-redirects';
import { loadFront } from 'yaml-front-matter';

import { DynamicPublicDirectory } from 'vite-multiple-assets';
import { readFileSync } from 'fs';

export default defineConfig({
  build: {
    ssr: process.env.BUILD_SSR ? 'app/app.js' : false,
    outDir: process.env.BUILD_SSR ? 'dist-ssr' : 'dist',
  },
  ssr: {
    noExternal: true,
  },

  resolve: {
    alias: {
      rfcs: resolve('./rfcs'),
    },
  },
  publicDir: false,
  plugins: [
    {
      name: 'rfcs-app-parsed-markdown',
      load(id) {
        if (id.endsWith('.md')) {
          const rfc = readFileSync(id, 'utf8');

          const parsed = loadFront(rfc);

          const contents = {
            ...parsed,
            startDate: parsed['start-date'],
            releaseDate: parsed['release-date'],
            releaseVersions: parsed['release-versions'],
            content: parsed.__content,
          };

          return `export default ${JSON.stringify(contents)}`;
        }
      },
    },
    DynamicPublicDirectory([
      'public/**',
      {
        input: 'rfcs/images/**',
        output: '/images',
      },
    ]),
    buildRedirects(),
    tocBuilder('rfcs/text', 'data'),
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
