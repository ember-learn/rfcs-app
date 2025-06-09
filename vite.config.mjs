import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { resolve } from 'path';
import tocBuilder from './lib/toc-builder';
import buildRedirects from './lib/build-redirects';

import {DynamicPublicDirectory} from "vite-multiple-assets";

export default defineConfig({
  resolve: {
    alias: {
      'rfcs': resolve('./rfcs')
    }
  },
  publicDir: false,
  plugins: [
    DynamicPublicDirectory(["public/**", {
      input: "rfcs/images/**",
      output: "/images"
    }]),
    buildRedirects(),
    tocBuilder('rfcs/text'),
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
