import Route from '@ember/routing/route';

export default class StagesClosedRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-closed.json')).default;
  }
}
