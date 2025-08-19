import { pageTitle } from 'ember-page-title';
import formatDate from 'rfcs-app/helpers/format-date';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import Component from '@glimmer/component';
import { inject as controller } from '@ember/controller';

export default class RFCRouteComponent extends Component {
  @controller application;

  toggleSidebar() {
    document.body.classList.toggle('sidebar-hidden');
  }

  <template>
    {{pageTitle "Rfc"}}
    <div class="page">
      <div class="menu-bar">
        <div class="left-buttons">
          {{!-- <button class="reset" type="button" {{on "click" this.toggleSidebar}}>
          <FaIcon class="p2" @icon="bars" />
        </button> --}}
        </div>
      </div>
      <table class="rfc-data-table">
        <thead>
          <tr>
            <td>Start Date</td>
            <td>Release Date</td>
            <td>Release Versions</td>
            <td>PR link</td>
            <td>Tracking Link</td>
            <td>Stage</td>
            <td>Teams</td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{formatDate @model.startDate}}</td>
            <td>{{formatDate @model.releaseDate}}</td>
            <td>
              <ul>
                {{#each-in @model.releaseVersions as |key value|}}
                  <li>
                    {{key}}:
                    {{value}}
                  </li>
                {{/each-in}}
              </ul>
            </td>
            <td>
              {{#if @model.proposalPr}}
                <a href={{@model.proposalPr}}>RFC Proposal Link</a>
              {{/if}}
            </td>
            <td>
              {{#if @model.trackingLink}}
                <a href={{@model.trackingLink}}>Tracking Link</a>
              {{/if}}
            </td>
            <td>{{@model.stage}}</td>
            <td><ul>
                {{#each @model.teams as |team|}}
                  <li>{{team}}</li>
                {{/each}}
              </ul></td>
          </tr>
        </tbody>
      </table>
      <div class="content">
        <MarkdownToHtml @markdown={{@model.content}} />
      </div>
    </div>
  </template>
}
