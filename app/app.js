import Application from '@ember/application';
import compatModules from '@embroider/virtual/compat-modules';
import Resolver from 'ember-resolver';
import loadInitializers from 'ember-load-initializers';
import config from 'rfcs-app/config/environment';
import 'ember-a11y-refocus/styles.css';

import setupInspector from '@embroider/legacy-inspector-support/ember-source-4.12';

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  podModulePrefix = config.podModulePrefix;
  Resolver = Resolver.withModules(compatModules);

  inspector = setupInspector(this);
}

loadInitializers(App, config.modulePrefix, compatModules);
