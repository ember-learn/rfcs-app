import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Stages"}}
  <div class="content-wrapper">
    <div class="main-content">
      <h1>RFC stages</h1>
      <p>The RFC ("request for comments") process is how Ember designs and
        achieves consensus on "substantial" proposed changes. The process is
        intended to provide a consistent and controlled path for new features
        and changes to enter the framework. RFCs can be created by
        <strong>any member</strong>
        of the community.</p>
      <p>When an RFC is created and implemented it goes through six stages,
        proposed, exploring, accepted, ready-for-release, released and
        recommended. There are two statuses for when RFCs don't move forward,
        discontinued and closed.
      </p>
      <p>For certain stage advancements, a final comment period (FCP) is
        required. This is a period lasting 7 days. The beginning of this period
        will be signaled with a comment and tag on the RFC's pull request.
        Furthermore, a message will be posted in #news-and-announcements on
        Ember Discord to attract the community's attention.</p>
      <p>An RFC can be modified based upon feedback from the core teams and
        community during the final comment period. Significant modifications may
        trigger a new final comment period. At the end of a successful FCP, the
        RFC moves into the next stage. An RFC may be closed or discontinued by
        the core teams after public discussion has settled and comments have
        been made summarizing the rationale for closing. The RFC will enter a
        "final comment period to close" lasting 7 days. At the end of the "FCP
        to close" period, the PR will be closed. An RFC author may withdraw
        their own RFC by closing it themselves.</p>
      <table class="table">
        <thead>
          <tr>
            <th>Stage</th>
            <th>Description</th>
            <th>Requires FCP to enter?</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><a href="#proposed">0 - Proposed</a></td>
            <td>A proposal for a change to Ember or its processes that is
              offered for community and team evaluation.</td>
            <td>no</td>
          </tr>
          <tr>
            <td><a href="#exploring">1 - Exploring</a></td>
            <td>An RFC deemed worth pursuing but in need of refinement.</td>
            <td>no</td>
          </tr>
          <tr>
            <td><a href="#accepted">2 - Accepted</a></td>
            <td>A fully specified RFC. Waiting for or in the process of
              implementation.</td>
            <td>yes</td>
          </tr>
          <tr>
            <td><a href="#ready-for-release">3 - Ready for Release</a></td>
            <td>The implementation of the RFC is complete, including learning
              materials.</td>
            <td>yes</td>
          </tr>
          <tr>
            <td><a href="#released">4 - Released</a></td>
            <td>The work is published. If it is codebase-related work, it is in
              a stable version of the relevant package(s).</td>
            <td>no</td>
          </tr>
          <tr>
            <td><a href="#recommended">5 - Recommended</a></td>
            <td>The feature/resource is recommended for general use.</td>
            <td>yes</td>
          </tr>
        </tbody>
      </table>

      <h2 id="proposed">Proposed</h2>
      <p>Proposed RFCs are opened as pull requests to the RFC repository.
        Anybody may create an RFC. The format should follow the templates in the
        RFC repository.</p>
      <p>An RFC's number is the number of it's original proposal PR.</p>
      <p>From "Proposed" an RFC may move to Exploring, or Closed stages. To move
        to Closed an FCP is required as in the existing process. A "Proposed"
        RFC may be moved to "Exploring" by consensus of the relevant team(s)
        without an FCP. See Exploring.</p>
      <h2 id="exploring">Exploring</h2>

      <p>An Exploring RFC is one the Ember team believes should be pursued, but
        the RFC may still need some more work, discussion, answers to open
        questions, and/or a champion before it can move to the next stage.</p>

      <p>An RFC is moved into Exploring with consensus of the relevant teams.
        The relevant team expects to spend time helping to refine the proposal.
        The RFC remains a PR and will have an Exploring label applied.</p>

      <p>An Exploring RFC that is successfully completed can move to Accepted
        with an FCP is required as in the existing process. It may also be moved
        to Closed with an FCP.</p>
      <h2 id="accepted">Accepted</h2>

      <p>An RFC that has been "accepted" has complete prose and has successfully
        passed through an "FCP to Accept" period in which the community has
        weighed in and consensus has been achieved on the direction. The
        relevant teams believe that the proposal is well-specified and ready for
        implementation. The RFC has a champion within one of the relevant teams.</p>

      <p>If there are unanswered questions, we have outlined them and expect
        that they will be answered before Ready for Release.</p>

      <p>When an RFC is merged and moved to "Accepted", a new PR will be opened
        to move it to Ready for Release. This PR should be used to track the
        implementation progress and gain consensus to move to the next stage.</p>
      <h2 id="ready-for-release">Ready for Release</h2>

      <p>The implementation is complete according to plan outlined in the RFC,
        and is in harmony with any changes in Ember that have occurred since the
        RFC was first written. This includes any necessary learning materials.
        At this stage, features or deprecations may be available for use behind
        a feature flag, or with an optional package, etc. The team reviews the
        work to determine when it can be included in a stable release. For
        codebase changes, there are no open questions that are anticipated to
        require breaking changes; the Ember team is ready to commit to the
        stability of any interfaces exposed by the current implementation of the
        feature. Today, this would be the "go/no-go" decision by a particular
        team.</p>

      <p>This stage should include a list of criteria for determining when the
        proposal can be considered Recommended after being Released.</p>

      <p>A PR is opened on the repo (see Accepted) to move an accepted RFC into
        this stage. An FCP is required to move into this stage.</p>

      <p>Each Ember core team will be requested as a reviewer on the PR to move
        into this stage. A representative of each team adds a review. If a team
        does not respond to the request, and after the conclusion of the FCP, it
        is assumed that the release may proceed.</p>
      <h2 id="released">Released</h2>
      <p>The work is published. If it is codebase-related work, it is in a
        stable version of the relevant package(s). If there are any critical
        deviations from the original RFC, they are briefly noted at the top of
        the RFC.</p>
      <p>If the work for an RFC is spread across multiple releases of Ember or
        other packages, the RFC is considered to be in the Released stage when
        all features are available in stable releases and those packages and
        versions are noted in the RFC frontmatter.</p>

      <p>Ember's RFC process can be used for process and work plans that are not
        about code. Some examples include Roadmap RFCs, changes to the RFC
        process itself, and changes to learning resources. When such an RFC is a
        candidate for Released, the work should be shipped as described, and the
        result should presented to the team with the intent of gathering
        feedback about whether anything is missing. If there is agreement that
        the work is complete, the RFC may be marked "Released" and a date is
        provided instead of a version.</p>

      <p>An RFC is moved into "Released" when the above is verified by consensus
        of the relevant team(s) via a PR to update the stage.</p>
      <h2 id="recommended">Recommended</h2>

      <p>The "Recommended" stage is the final milestone for an RFC. It provides
        a signal to the wider community to indicate that a feature has been put
        through its ecosystem paces and is ready to use.</p>

      <p>The "Recommended" stage is most important for suites of features that
        are designed as a number of separate RFCs. It allows the Ember
        maintainers to stabilize individual features once they are technically
        feature complete, an important goal for maintaining technical velocity.</p>

      <p>To reach the "Recommended" stage, the following should be true:</p>
      <ul>
        <li>If appropriate, the feature is integrated into the tutorial and the
          guides prose. API documentation is polished and updates are carried
          through to other areas of API docs that may not directly pertain to
          the feature.</li>
        <li>
          If the proposal replaces an existing feature, the addon ecosystem has
          largely updated to work with both old and new features.</li>
        <li>If the proposal updates or replaces an existing feature,
          high-quality codemods are available</li>
        <li>If needed, Ember debugging tools as well as popular IDE support have
          been updated to support the feature.</li>
        <li>
          If the feature is part of a suite of features that were designed to
          work together for best ergonomics, the other features are also ready
          to be "Recommended".</li>
        <li>Any criteria for "Recommended" for this proposal that were
          established in the Ready For Release stage have been met.</li>
      </ul>

      <p>An RFC is moved into "Recommended" via PR to update the stage. An FCP
        is required to enter this stage. Multiple RFCs may be moved as a batch
        into "Recommended" with the same PR.</p>
      <h2 id="discontinued">Discontinued</h2>
      <p>A previously Accepted RFC may be discontinued at any point. The RFC may
        be superseded, out-of-date, or no longer consistent with the direction
        of Ember.</p>
      <h2 id="closed">Closed</h2>
      <p>A Proposed or Exploring RFC may be closed after an FCP period. This is
        the same as the existing process. A closed RFC is discontinued.</p>
    </div>
    <div>
      <div class="on-this-page-wrapper">
        <div class="on-this-page-wrapper-header">On this page</div>
        <hr />
        <ul>
          <li>
            <a href="#proposed">Proposed</a>
          </li>
          <li>
            <a href="#exploring">Exploring</a>
          </li>
          <li>
            <a href="#accepted">Accepted</a>
          </li>
          <li>
            <a href="#read-for-release">Ready for Release</a>
          </li>
          <li>
            <a href="#released">Released</a>
          </li>
          <li>
            <a href="#recommended">Recommended</a>
          </li>
          <li>
            <a href="#discontinued">Discontinued</a>
          </li>
          <li>
            <a href="#closed">Closed</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
