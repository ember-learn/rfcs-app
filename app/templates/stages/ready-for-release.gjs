import { pageTitle } from 'ember-page-title';
import RfcCard from 'rfcs-app/components/rfc-card';

<template>
  {{pageTitle "Ready for Release"}}
  <h1>Ready for Release</h1>
  <p>The
    <a href="/stages#ready-for-release">Ready for Release stage</a>
    is a phase where the implementation is complete and we're preparing it for
    an official release. See the list of RFCs ready for release below.</p>

  <div class="rfc-grid">
    {{#each @model as | rfc | }}
      <RfcCard @rfc={{rfc}} />
    {{/each}}
  </div>
</template>
