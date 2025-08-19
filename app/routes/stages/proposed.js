import Route from '@ember/routing/route';

export default class StagesProposedRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-proposed.json')).default;
  }
}
