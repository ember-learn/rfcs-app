import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import EsNote from 'ember-styleguide/components/es-note';

<template>
  {{pageTitle "Creating an RFC"}}
  <h1>Creating an RFC</h1>
  <p>You need to follow this process if you intend to make "substantial" changes
    to Ember, Ember Data, Ember CLI, their documentation, or any other projects
    under the purview of the Ember core teams. What constitutes a "substantial"
    change is evolving based on community norms, but may include the following:
    <ul>
      <li>
        A new feature that creates new API surface area, and would require a
        feature flag if introduced.</li>
      <li>
        The removal of features that already shipped as part of the release
        channel.</li>
      <li>
        The introduction of new idiomatic usage or conventions, even if they do
        not include code changes to Ember itself.</li>
    </ul>
    Some changes do not require an RFC:
    <ul>
      <li> Rephrasing, reorganizing or refactoring</li>
      <li> Addition or removal of warnings</li>
      <li>
        Additions that strictly improve objective, numerical quality criteria
        (speedup, better browser support)</li>
      <li>
        Additions only likely to be noticed by other implementors-of-Ember,
        invisible to users-of-Ember.</li>
    </ul>
    If you submit a pull request to implement a new feature without going
    through the RFC process, it may be closed with a polite request to submit an
    RFC first.</p>

  <p>It's often helpful to get feedback on your concept before diving into the
    level of API design detail required for an RFC. You may open an issue on
    this repo to start a high-level discussion, with the goal of eventually
    formulating an RFC pull request with the specific implementation design. We
    also highly recommend sharing drafts of RFCs in <a href="https://discord.com/channels/480462759797063690/500803406676492298">#dev-rfc channel</a> on the <a href="https://discord.gg/vH76gMKgqB">Ember.js Discord</a> for early feedback.</p>

  <p>For more on the RFC process and stages, check out the
    <LinkTo @route="stages">RFC stages guide</LinkTo></p>

  <EsNote @mascot="zoey">The process may look daunting, however we invite
    everyone to participate. You can propose the change you want to see!</EsNote>
  <h2>How to create a new RFC</h2>
  <ul>
    <li> Fork the <a href="http://github.com/emberjs/rfcs">RFC repo</a></li>
    <li>
      Copy the appropriate template. For most RFCs, this is 0000-template.md,
      for deprecation RFCs it is deprecation-template.md. Copy the template file
      to text/0000-my-feature.md, where 'my-feature' is descriptive.
    </li>
    <li> Don't assign an RFC number yet.</li>
    <li>
      Fill in the RFC. Put care into the details: RFCs that do not present
      convincing motivation, demonstrate understanding of the impact of the
      design, or are disingenuous about the drawbacks or alternatives tend to be
      poorly-received.</li>
    <li>
      Fill in the relevant core teams.
    </li>
    <li>
      Submit a pull request. As a pull request the RFC will receive design
      feedback from the larger community, and the author should be prepared to
      revise it in response. The RFC is now in the
      <a href="/stages#proposed">Proposed stage</a>.
    </li>
    <li>
      Find a champion on the relevant core team. The champion is responsible for
      shepherding the RFC through the RFC process and representing it in core
      team meetings.
    </li>
    <li>
      Update the pull request to add the number of the PR to the filename and
      add a link to the PR in the header of the RFC.
    </li>
    <li>
      Build consensus and integrate feedback. RFCs that have broad support are
      much more likely to make progress than those that don't receive any
      comments.
    </li>
    <li>
      From here, the RFC moves to the <a href="/stages#exploring">Exploring stage</a> or <a href="/stages#closed">Closed</a> in the process
      explained in Stages.
    </li>
  </ul>

  <h3>RFC champion</h3>
  <p>For every RFC, you'll need to find a champion from the relevant core team.
    This person is responsible for representing the RFC in team meetings and
    guiding it through the various stages. Their responsibilities include
    helping the team reach consensus, ensuring the RFC adheres to the process,
    and supporting planning and implementation. A champion can step down before
    the RFC is accepted and may also designate a replacement at any time.</p>
    <p>The best way to find a champion is by engaging in the <a href="https://discord.com/channels/480462759797063690/500803406676492298">#dev-rfc channel</a> on the
    <a href="https://discord.gg/vH76gMKgqB">Ember.js Discord</a>, which is dedicated to RFC discussions. Sharing early drafts
    there is highly encouraged as it's a great way to receive initial feedback
    and connect with potential champions. You can also request a champion by
    opening an issue or noting it directly in the RFC.</p>
</template>
