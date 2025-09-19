import { pageTitle } from 'ember-page-title';
import RfcCard from '../../components/rfc-card';
<template>
  {{pageTitle "Recommended"}}
  <h1>Recommended</h1>
  <p>The
    <a href="/stages#recommended">Recommended stage</a>
    is a phase where the feature is considered mature and ready for broad use in
    the community. See the list of recommended RFCs below.</p>
  <div class="rfc-grid">
    {{#each @model as |rfc|}}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
