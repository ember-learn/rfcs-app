import { pageTitle } from 'ember-page-title';
import RfcCard from '../../components/rfc-card';
<template>
  {{pageTitle "Discontinued"}}
  <h1>Discontinued</h1>
  <p>The
    <a href="/stages#discontinued">Discontinued stage</a>
    is a phase where a previously accepted RFC is no longer going to be
    implemented. See the list of discontinued RFCs below.</p>
  <div class="rfc-grid">
    {{#each @model as |rfc|}}
      <RfcCard @title={{rfc}} />
    {{/each}}
  </div>
</template>
