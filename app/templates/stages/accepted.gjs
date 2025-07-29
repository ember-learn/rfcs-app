import { pageTitle } from 'ember-page-title';
import RfcCard from '../../components/rfc-card';
<template>
  {{pageTitle "Accepted"}}
  <h1>Accepted</h1>
  <p>The <a href="/stages#accepted">Accepted stage</a> is a phase where we need to start builing the implementation of the RFCs. See the list of accepted RFCs below.</p>
  <div class="rfc-grid">
  {{#each @model as | rfc | }}
    <RfcCard @title={{rfc}}></RfcCard>
  {{/each}}
  </div>
</template>
