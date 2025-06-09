import Route from '@ember/routing/route';

export default class IndexRoute extends Route {
  async model() {
    return (await import('rfcs/README.md?raw')).default
  }
}
