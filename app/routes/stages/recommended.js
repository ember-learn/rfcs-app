import Route from '@ember/routing/route';
import toc from 'rfcs-app-toc-builder:toc.json';

export default class StagesRecommendedRoute extends Route {
  async model() {
    return toc.stageLinks['recommended'];
  }
}
