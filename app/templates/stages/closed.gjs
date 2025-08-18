import { pageTitle } from 'ember-page-title';
import RfcCard from 'rfcs-app/components/rfc-card';

<template>
  {{pageTitle "Closed"}}
  <h1>Closed</h1>
  <p>The <a href="/stages#closed">Closed stage</a> is a phase where a proposed or exploring RFC is no longer being pursued. See the list of closed RFCs below.</p>
  <div class="rfc-grid">
    {{#each @model as |rfc|}}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
