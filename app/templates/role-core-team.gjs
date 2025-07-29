import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Role of Core Team"}}
  <h1>The Role of Core Team Members</h1>

  <p>
    Each Ember core team plays a vital part in reviewing and guiding RFCs. If
    your RFC touches on a specific area—like Ember Data, Learning, or
    Framework, the relevant team is responsible for reviewing your proposal. Make
    sure you've listed the correct teams in the
    <strong>“Relevant Team(s)”</strong>
    section of your RFC front matter. This helps ensure it reaches the right
    people.
  </p>

  <p>
    During the review process, core team members provide feedback, suggest
    improvements, and help shape the proposal. This is the time for in-depth
    discussion—teams may challenge, endorse, or refine your ideas to make sure
    they align with Ember's direction and standards.
  </p>

  <p>
    When an RFC is ready to move into the
    <strong><a href="stages/#ready-for-release">Ready for Release</a></strong>
    stage, the relevant core teams review the proposal one final time
    before it moves forward.
  </p>

  <h2>About Champions</h2>
  <p>
    Every RFC needs a champion from one of the core teams. This person
    represents your RFC in team meetings and helps it progress through the
    stages. Their role includes:
  </p>
  <ul>
    <li>Helping the team reach consensus to move the RFC forward.</li>
    <li>Ensuring your RFC follows the proper process.</li>
    <li>Supporting planning and implementation once the RFC is accepted.</li>
  </ul>
  <p>
    A champion can step down before the RFC is accepted and may also find
    someone else to take over at any time.
  </p>
</template>
