import Route from '@ember/routing/route';

export default class RfcsInputRoute extends Route {
  async model() {
    // doing it this way makes sure we request both files at the same time
    return (await Promise.all([
      import('rfcs-app-toc-builder:stage-proposed.json'),
      import('rfcs-app-toc-builder:stage-exploring.json')])
    ).map(item => item.default).flat();
  }
}
