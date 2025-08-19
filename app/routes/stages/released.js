import Route from '@ember/routing/route';

export default class StagesReleasedRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-released.json')).default;
  }
}
