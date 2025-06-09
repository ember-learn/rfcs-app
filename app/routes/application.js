import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import toc from 'rfcs-app-toc-builder:toc.json';

export default class ApplicationRoute extends Route {
  @service store;

  async model() {
    return toc;
  }
}
