import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import GroupedToc from 'rfcs-app/components/grouped-toc';

<template>
  {{pageTitle "Ember.js RFCs"}}

  <aside class="sidebar light">
    <ul class="chapter">
      <li>
        <LinkTo @route="index">Introduction</LinkTo>
      </li>
    </ul>

    <GroupedToc @model={{@model}} />
  </aside>

  <main class="page-wrapper light">
    {{outlet}}
  </main>
</template>
