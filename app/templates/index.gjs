import RfcCard from '../components/rfc-card';

<template>
  <div>
      <h1>Welcome to the Ember.js RFCs app</h1>
      <p>This is the place to find what is currently cooking within Ember.js. Check out the documentation on our RFC process and what RFCs need your input!</p>
      <h2>RFC's that can use your input</h2>
      <div class="rfc-grid">
      <RfcCard @compact={{true}} @title="0127-make-sure-the-times-is-on-time"></RfcCard>
      <RfcCard @compact={{true}} @title="0128-make-sure-the-times-is-on-time"></RfcCard>
      <RfcCard @compact={{true}}  @title="0129-make-sure-the-times-is-on-time"></RfcCard>
      </div>
      <a href="/rfcs-input">See all</a>
      <h2>RFC's that need you help</h2>
      <div class="rfc-grid">
      <RfcCard @compact={{true}}  @title="0117-make-sure-the-times-is-on-time"></RfcCard>
      <RfcCard @compact={{true}}  @title="0137-make-sure-the-times-is-on-time"></RfcCard>
      <RfcCard @compact={{true}}  @title="0147-make-sure-the-times-is-on-time"></RfcCard>
      </div>
      <a href="/rfcs-help">See all</a>
  </div>
</template>
