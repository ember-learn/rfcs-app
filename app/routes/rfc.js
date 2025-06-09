import Route from '@ember/routing/route';
import { loadFront } from 'yaml-front-matter';

const rfcs = import.meta.glob('rfcs/text/*.md', {query: '?raw', import: 'default'});

export default class RfcsRoute extends Route {
  async model(params) {
    const rfc = await rfcs[`/rfcs/text/${params.id}.md`]()

    const parsed = loadFront(rfc);

    return {
      ...parsed,
      startDate: parsed['start-date'],
      releaseDate: parsed['release-date'],
      releaseVersions: parsed['release-versions'],
      content: parsed.__content,
      id: params.id,
    }
  }
}
