import Route from '@ember/routing/route';

export default class StagesAcceptedRoute extends Route {
  async model() {
    const result = (await import('rfcs-app-toc-builder:stage-accepted.json')).default;
    return result;
  }
}
