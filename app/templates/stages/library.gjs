import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';

<template>
  {{pageTitle "RFC library"}}
  <div>
    <h1>RFC library</h1>
    <p>The table below shows all the RFCs in chronological order. If you are interested in more information you can click on the RFC or check out the specific stages.</p>
    {{#each @model as |rfc|}}
      <div class="rfc-card"><span>#{{rfc.number}}</span><div><LinkTo
          @route="rfc"
          @model={{rfc.link}}
        >{{rfc.title}}</LinkTo></div><span class="label-{{rfc.stage}}">{{rfc.stage}}</span></div>
    {{/each}}
  </div>
</template>
