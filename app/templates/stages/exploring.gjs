import { pageTitle } from 'ember-page-title';
import RfcCard from 'rfcs-app/components/rfc-card';

<template>
  {{pageTitle "Exploring"}}
  <h1>Exploring</h1>
  <p>The <a href="/stages#exploring">Exploring stage</a> is a phase where an idea is being refined and discussed further, but needs more clarity, answers, or a champion. See the list of exploring RFCs below.</p>

  <div class="rfc-grid">
    {{#each @model as | rfc | }}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
