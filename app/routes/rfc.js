import Route from '@ember/routing/route';

const rfcs = import.meta.glob('rfcs/text/*.md');

export default class RfcsRoute extends Route {
  async model(params) {
    /**
     * we need to normalise the ID here because Netlify by default forces all URLs to be lowercase, that means that
     * there starts to be a discrepency between what vite can see on disk and the actual id that we're trying to access
     */
    const rormalisedRFCId = Object.keys(rfcs).find(id => id.toLowerCase() === `/rfcs/text/${params.id.toLowerCase()}.md`)

    const rfc = (await rfcs[rormalisedRFCId]()).default;

    return {
      ...rfc,
      id: params.id,
    }
  }
}
