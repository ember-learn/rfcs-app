import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';

const stageOrder = {
  proposed: 'Proposed',
  exploring: 'Exploring',
  accepted: 'Accepted',
  'ready-for-release': 'Ready for release',
  released: 'Released',
  recommended: 'Recommended',
  closed: 'Closed',
  dicontinued: 'Discontinued',
  'no-stage': '[No Stage]',
};

export default class GroupedTocComponent extends Component {
  <template>
    {{#each this.sortedStages as |group|}}
      {{#if group.links}}
        <h3 class="stage-title">
          {{group.name}}
        </h3>
        <ul class="chapter">
          {{#each group.links as |id|}}
            <li>
              <LinkTo @route="rfc" @model={{id}}> {{id}} </LinkTo>
            </li>
          {{/each}}
        </ul>
      {{/if}}
    {{/each}}
  </template>

  get sortedStages() {
    const result = [];

    for (let stage in stageOrder) {
      result.push({
        name: stageOrder[stage],
        links: this.args.model.stageLinks[stage],
      });
    }

    return result;
  }
}
