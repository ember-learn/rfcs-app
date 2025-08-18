import { pageTitle } from 'ember-page-title';
import RfcCard from '../components/rfc-card';

<template>
  {{pageTitle "RFCs that need your input"}}
   <h1>RFCs that need your input</h1>
  <p>The list below consists of RFCs that need input when it comes to coming up with the solution. This can be both the implementation, but also the caviats.</p>
  <div class="rfc-grid">
  {{#each @model as | rfc | }}
    <RfcCard @rfc={{rfc}}></RfcCard>
  {{/each}}
  </div>
</template>
