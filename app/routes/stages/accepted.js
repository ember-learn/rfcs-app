import Route from '@ember/routing/route';

export default class StagesAcceptedRoute extends Route {
  async model() {
    const result = (await import('rfcs-app-toc-builder:stage-accepted.json'))
      .default;

    /**
     * filter out PRs that don't have RFC files - i.e. are not RFCS
     * TODO figuire out the combine logic so that we don't get the data in here at this level
     */
    return result.filter((item) => Boolean(item.rfcFile));
  }
}
