import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

export default class RfcCard extends Component {
  <template>
    <div class="rfc-card">
      <LinkTo class="card-number" @route="rfc" @model={{@rfc.rfcFile}}><h2>#{{@rfc.number}}</h2></LinkTo>
      <LinkTo class="card-title" @route="rfc" @model={{@rfc.rfcFile}}><h2>{{@rfc.title}}</h2></LinkTo>
      <p class="card-summary">{{@rfc.summary}}</p>
      {{#unless @compact}}
        <ul title="RFC Champions" class="card-champion rfc-champions">
          {{#if @rfc.fcp}}<span class="card-fcp">Final Comment Period</span>{{/if}}
          {{#each @rfc.assignees as |assignee|}}
            <li>
              <img
                alt="Avatar for {{assignee.login}}"
                title={{assignee.login}}
                src={{assignee.avatarUrl}}
              />
              <span>{{assignee.login}}</span>
            </li>
          {{/each}}
        </ul>
      {{/unless}}
    </div>
  </template>

  get getURL() {
    return `/id/${this.args.rfc.rfcFile}`;
  }
}
