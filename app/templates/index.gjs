import { LinkTo } from '@ember/routing';

function daysUntilFriday() {
  let today = new Date().getDay();
  return (12 - today)%7; //It's 12 because Friday is the fifth day, and we wan't to %7 so we added 7
}

<template>
  <div>
    <h1>Welcome to the Ember.js RFCs app</h1>
    <p>This is the place to find what is currently cooking within Ember.js.
      Check out the documentation on our RFC process and what RFCs need your
      input!</p>
    <h2>These RFCs are in their Final Comment Period and will move to their next stage in {{daysUntilFriday}} days</h2>
    <div>
      {{#each @model as |rfc|}}
        <LinkTo class="fcp-item" @route="rfc" @model={{rfc.rfcFile}}>#{{rfc.number}} {{rfc.title}}</LinkTo>
      {{/each}}
    </div>
  </div>
</template>
