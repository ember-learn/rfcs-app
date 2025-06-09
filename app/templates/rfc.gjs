import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import formatDate from 'rfcs-app/helpers/format-date';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import Component from '@glimmer/component';
import { inject as controller } from '@ember/controller';

export default class RFCRouteComponent extends Component {
  @controller application;

  get previousRFC() {
    let currentRFCIndex = this.application.model.links.indexOf(this.args.model.id);

    console.log({currentRFCIndex, applicationModel: this.application.model, currentId: this.args.model})
    if (currentRFCIndex <= 0) {
      return null;
    }

    return this.application.model.links[currentRFCIndex - 1];
  }

  get nextRFC() {
    let currentRFCIndex = this.application.model.links.indexOf(this.args.model.id);
    if (currentRFCIndex >= this.application.model.links.length) {
      return null;
    }

    return this.application.model.links[currentRFCIndex + 1];
  }

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
                  {{key}}: {{value}}
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

  {{#if this.previousRFC}}
    <LinkTo @route="rfc" @model={{this.previousRFC}} class="nav-chapters previous">
      <svg class="svg-inline--fa fa-angle-left margin-auto" data-prefix="fas" data-icon="angle-left" aria-hidden="true" focusable="false" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
        <path fill="currentColor" d="M192 448c-8.188 0-16.38-3.125-22.62-9.375l-160-160c-12.5-12.5-12.5-32.75 0-45.25l160-160c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25L77.25 256l137.4 137.4c12.5 12.5 12.5 32.75 0 45.25C208.4 444.9 200.2 448 192 448z"></path>
      </svg>
    </LinkTo>
  {{else}}
    <LinkTo @route="index" class="nav-chapters previous">
      <svg class="svg-inline--fa fa-angle-left margin-auto" data-prefix="fas" data-icon="angle-left" aria-hidden="true" focusable="false" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
        <path fill="currentColor" d="M192 448c-8.188 0-16.38-3.125-22.62-9.375l-160-160c-12.5-12.5-12.5-32.75 0-45.25l160-160c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25L77.25 256l137.4 137.4c12.5 12.5 12.5 32.75 0 45.25C208.4 444.9 200.2 448 192 448z"></path>
      </svg>
    </LinkTo>
  {{/if}}

  {{#if this.nextRFC}}
    <LinkTo @route="rfc" @model={{this.nextRFC}} class="nav-chapters next">
      <svg class="svg-inline--fa fa-angle-right margin-auto" data-prefix="fas" data-icon="angle-right" aria-hidden="true" focusable="false" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
        <path fill="currentColor" d="M64 448c-8.188 0-16.38-3.125-22.62-9.375c-12.5-12.5-12.5-32.75 0-45.25L178.8 256L41.38 118.6c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l160 160c12.5 12.5 12.5 32.75 0 45.25l-160 160C80.38 444.9 72.19 448 64 448z"></path>
      </svg>
    </LinkTo>
  {{/if}}

  </template>
}
