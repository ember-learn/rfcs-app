import { pageTitle } from 'ember-page-title';
import RfcCard from '../../components/rfc-card';
<template>
  {{pageTitle "Released"}}
  <h1>Released</h1>
  <p>The
    <a href="/stages#released">Released stage</a>
    is a phase where the work is available in a stable release and has been
    shipped. See the list of released RFCs below.</p>
  <div class="rfc-grid">
    {{#each @model as |rfc|}}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
