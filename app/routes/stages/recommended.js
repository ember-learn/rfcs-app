import Route from '@ember/routing/route';

export default class StagesRecommendedRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-recommended.json'))
      .default;
  }
}
