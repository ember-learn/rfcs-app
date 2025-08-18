import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

export default class RfcCard extends Component {
<template>
  <div class="rfc-card">
    <LinkTo @route="rfc" @model={{@rfc.rfcFile}}><h2>#{{@rfc.number}} {{@rfc.title}}</h2></LinkTo>
    <p class="summary">{{@rfc.summary}}...</p>
    {{#unless @compact}}
    <div class="rfc-champions">
      {{#each @rfc.assignees as |assignee|}}
        <img title={{assignee.login}} src={{assignee.avatarUrl}} />
      {{/each}}
    </div>
    {{/unless}}
  </div>
</template>

  get getURL() {
    return `/id/${this.args.rfc.rfcFile}`;
  }
}
