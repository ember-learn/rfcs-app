import Route from '@ember/routing/route';

export default class StagesExploringRoute extends Route {
  async model() {
    return (await import('rfcs-app-toc-builder:stage-exploring.json')).default;
  }
}
