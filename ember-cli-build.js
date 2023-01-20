'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
const mergeTrees = require('broccoli-merge-trees');
const funnel = require('broccoli-funnel');
const { readdirSync } = require('fs');

function buildRedirects() {
  const redirects = [];
  const rfcs = readdirSync('rfcs/text');

  for (let filename of rfcs) {
    const match = filename.match(/(\d+)-.*/);

    const number = parseInt(match[1]);

    redirects.push(
      `/number/${number} /id/${filename.replace(/\.md$/, '')} 301!`
    );
  }

  return redirects;
}

module.exports = function (defaults) {
  let app = new EmberApp(defaults, {
    rfcProcess: {
      textLocation: 'rfcs',
    },
    trees: {
      public: mergeTrees([
        'public',
        funnel('rfcs/images', {
          destDir: 'images',
        }),
      ]),
    },
    fingerprint: {
      extensions: ['js', 'css', 'map'],
    },
    'ember-cli-netlify': {
      redirects: buildRedirects(),
    },
  });

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  return app.toTree();
};
