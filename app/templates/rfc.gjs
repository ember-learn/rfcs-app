import { pageTitle } from 'ember-page-title';
import formatDate from 'rfcs-app/helpers/format-date';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import Component from '@glimmer/component';
import { inject as controller } from '@ember/controller';

export default class RFCRouteComponent extends Component {
  @controller application;


  <template>
    {{pageTitle "Rfc"}}
    <div class="page">
      <div class="content">
        <a class="github-url" href={{@model.url}} rel="noopener noreferrer" target="_blank">Open on Github</a>
        <MarkdownToHtml @markdown={{@model.content}} />
      </div>
    </div>
  </template>
}
