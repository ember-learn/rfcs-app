import { pageTitle } from 'ember-page-title';
import RfcCard from 'rfcs-app/components/rfc-card';

<template>
  {{pageTitle "Proposed"}}
  <h1>Proposed</h1>
  <p>The
    <a href="/stages#proposed">Proposed stage</a>
    is where new ideas are introduced as pull requests to start discussion. See
    the list of proposed RFCs below.</p>

  <div class="rfc-grid">
    {{#each @model as |rfc|}}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
