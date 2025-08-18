import Route from '@ember/routing/route';

export default class StagesReadyForReleaseRoute extends Route {
  async model() {
    const result = (await import('rfcs-app-toc-builder:stage-ready-for-release.json')).default;
    return result;
  }
}
