import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import EsHeader from 'ember-styleguide/components/es-header';
import EsSidebar from 'ember-styleguide/components/es-sidebar';
import { NavigationNarrator } from 'ember-a11y-refocus';

<template>
  {{pageTitle "Ember.js RFCs"}}
  <EsHeader>
    <NavigationNarrator />
  </EsHeader>
  <main class="sidebar-container sidebar-container--full-width">
    <EsSidebar>
      <ul class="table-of-contents">
        <li class="toc-item">
          <LinkTo @route="index">Welcome</LinkTo>
        </li>

        <li class="toc-heading">RFC process</li>
        <li class="toc-item">
          <ul class="table-of-contents sub-table-of-contents">
            <li class="toc-item">
              <LinkTo @route="stages">RFC stages</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="create-rfc">How to create an RFC</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="role-core-team">Role of the core teams</LinkTo>
            </li>
          </ul>
        </li>
        <li class="toc-heading">RFC library</li>
        <li class="toc-item">
          <ul class="table-of-contents sub-table-of-contents">
            <li class="toc-item">
              <LinkTo @route="stages.proposed">Proposed</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.exploring">Exploring</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.accepted">Accepted</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.ready-for-release">Ready for Release</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.released">Released</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.recommended">Recommended</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.discontinued">Discontinued</LinkTo>
            </li>
            <li class="toc-item">
              <LinkTo @route="stages.closed">Closed</LinkTo>
            </li>
          </ul>
        </li>
      </ul>
    </EsSidebar>
    <div class="example-content">
      {{outlet}}
    </div>
  </main>
</template>
