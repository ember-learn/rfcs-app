import Route from '@ember/routing/route';

export default class IndexRoute extends Route {
  async model() {
    const result = (
      await import('rfcs-app-toc-builder:fcp.json')
    ).default;
    return result;
  }
}
