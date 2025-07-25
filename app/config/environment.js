import { assert } from '@ember/debug';

let config = {
  modulePrefix: 'rfcs-app',
  rootURL: '/',
  locationType: 'history',
  APP: {},
  'ember-showdown-shiki': {
    theme: 'github-dark',
    languages: [
      'bash',
      'css',
      'http',
      'javascript',
      'json',
      'json5',
      'ruby',
      'scss',
      'yaml',
      'typescript',
      'glimmer-js',
      'glimmer-ts',
      'handlebars',
    ],
  },
  showdown: {
    tables: true,
  },
};

assert(
  'config is not an object',
  typeof config === 'object' && config !== null
);
assert(
  'modulePrefix was not detected on your config',
  'modulePrefix' in config && typeof config.modulePrefix === 'string'
);
assert(
  'locationType was not detected on your config',
  'locationType' in config && typeof config.locationType === 'string'
);
assert(
  'rootURL was not detected on your config',
  'rootURL' in config && typeof config.rootURL === 'string'
);
assert(
  'APP was not detected on your config',
  'APP' in config && typeof config.APP === 'object'
);

export default config;
