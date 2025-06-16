import Route from '@ember/routing/route';

export default class RfcsRoute extends Route {
  async model(params) {
    const rfcId = params.id;
    const rfc = (await import(`rfcs/text/${rfcId}.md`)).default

    return {
      ...rfc,
      id: params.id,
    }
  }
}
