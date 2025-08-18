import Route from '@ember/routing/route';

export default class StagesDiscontinuedRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-discontinued.json')).default;
  }
}
