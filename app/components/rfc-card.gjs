import Component from '@glimmer/component';

export default class RfcCard extends Component {
<template>
  <div class="rfc-card">
    <a href={{this.getURL}}><h2>{{this.getTitle}}</h2></a>
    <p class="summary">Identifiers provides infrastructure for handling identity within ember-data to satisfy requirements around improved caching, serializability, replication, and handling of remote data.
    This concept would parallel a similar structure proposed for json-api resource identifier lid property drafted for version 1.2 of the json-api spec.
    In doing so we provide a framework for future RFCs and/or addons to address many common feature requests.</p>
    <div class="rfc-champions">
      <img width="100" height="100" class="eri-fixed team-image" loading="lazy" decoding="async" alt="" role="presentation" data-eri-bh="U9GkwhBJ9?=~OgNORQ^k_Ns+WBx^%hoHs:tQ" data-eri-bh-w="4" data-eri-bh-h="4" style="" src="https://avatars.githubusercontent.com/u/594890?v=4">
      <img src="https://avatars.githubusercontent.com/u/5811560?v=4" />
    </div>
  </div>
</template>

get getURL() {
    return `id/${this.args.title}`;
  }

  get getTitle() {
    const [number, ...title] = this.args.title.split('-');
    return `#${Number(number)} ${title.join(' ')}`
  }
}
