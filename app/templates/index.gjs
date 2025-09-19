import { LinkTo } from '@ember/routing';
import EsNote from 'ember-styleguide/components/es-note';

function daysUntilFriday() {
  let today = new Date().getDay();
  return (12 - today) % 7; //It's 12 because Friday is the fifth day, and we wan't to %7 so we added 7
}

<template>
  <div>
    <h1>Welcome to the Ember.js RFCs app</h1>
    <p>This is the place to find what is currently cooking within Ember.js.
      Check out the documentation on our RFC process and what RFCs need your
      input!</p>
    {{#if @model}}
      <h2>These RFCs are in their Final Comment Period and will move to their
        next stage in
        {{daysUntilFriday}}
        days</h2>
      <div>
        {{#each @model as |rfc|}}
          <div class="fcp-item">#{{rfc.number}}<LinkTo
              @route="rfc"
              @model={{rfc.rfcFile}}
            >{{rfc.title}}</LinkTo></div>
        {{/each}}
      </div>
    {{else}}
      <p>There are currently no RFCs in their Final Comment Period but you can
        contribute to Ember.js by sharing your thoughts on
        <LinkTo @route="stages.exploring">Exploring RFCs</LinkTo>
        and help with the implementation
        <LinkTo @route="stages.accepted">Accepted RFCs</LinkTo>
        and
        <LinkTo @route="stages.released">Released RFCs</LinkTo>.</p>
    {{/if}}
    <p>If you want to share your ideas before creating a PR, check out the
      <code>#dev-rfc</code>
      Discord channel. Every friday we also host a RFC meeting in the same
      Discord server, see the events for the time in your local timezone.</p>
    <EsNote @mascot="zoey">Let's go change Ember.js together!</EsNote>
  </div>
</template>
