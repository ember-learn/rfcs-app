import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

export default class RfcCard extends Component {
  <template>
    <div class="rfc-card">
      <span class="card-number"><h2>#{{@rfc.number}}</h2></span>

      {{#if @rfc.rfcFile}}
        <LinkTo class="card-title" @route="rfc" @model={{@rfc.rfcFile}}>
          <h2>{{@rfc.title}}</h2>
        </LinkTo>
      {{else}}
        <a
          href="https://github.com/emberjs/rfcs/pull/{{@rfc.number}}"
          class="card-title"
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2>{{@rfc.title}}</h2>
        </a>
      {{/if}}
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
