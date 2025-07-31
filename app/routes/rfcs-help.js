import Route from '@ember/routing/route';
import toc from 'rfcs-app-toc-builder:toc.json';

export default class RfcsHelpRoute extends Route {
  async model() {
      return [...toc.stageLinks["accepted"], ...toc.stageLinks["released"]];
    }
}
