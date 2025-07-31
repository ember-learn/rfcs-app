import Route from '@ember/routing/route';
import toc from 'rfcs-app-toc-builder:toc.json';

import accepted from 'rfcs-app-toc-builder:stage-accepted.json'

export default class RfcsHelpRoute extends Route {
  async model() {
    console.log(accepted)
      return [...toc.stageLinks["accepted"], ...toc.stageLinks["released"]];
    }
}
