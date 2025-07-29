import Route from '@ember/routing/route';
import toc from 'rfcs-app-toc-builder:toc.json';

export default class StagesAcceptedRoute extends Route {
async model() {
    return toc.stageLinks["accepted"];
  }
}
