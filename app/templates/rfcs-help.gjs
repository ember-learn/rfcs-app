import { pageTitle } from 'ember-page-title';
import RfcCard from '../components/rfc-card';

<template>
  {{pageTitle "RFCs that need your help"}}
  <h1>RFCs that need your help</h1>
  <p>The list below consists of RFCs that need active development to move them to the next phase. This could be technical development of the feature or writing documentation.</p>
  <div class="rfc-grid">
    {{#each @model as | rfc | }}
      <RfcCard @rfc={{rfc}}></RfcCard>
    {{/each}}
  </div>
</template>
