import Route from '@ember/routing/route';

export default class RfcsHelpRoute extends Route {
  async model() {
    // doing it this way makes sure we request both files at the same time
    return (
      await Promise.all([
        import('rfcs-app-toc-builder:stage-accepted.json'),
        import('rfcs-app-toc-builder:stage-released.json'),
      ])
    ) // do we need this one? 🤔
      .map((item) => item.default)
      .flat();
  }
}
