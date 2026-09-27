import Route from '@ember/routing/route';

export default class StagesLibraryRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:index.json'))
      .default;
  }
}
