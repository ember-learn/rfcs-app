#!/usr/bin/env node

import { Octokit } from 'octokit';
import { mkdir, writeFile } from 'node:fs/promises';
import { join } from 'path';

// Create a personal access token at https://github.com/settings/tokens/new?scopes=repo
const octokit = new Octokit({
  auth: process.env.GITHUB_TOKEN,
});

const iterator = octokit.paginate.iterator(octokit.rest.pulls.list, {
  owner: 'emberjs',
  repo: 'rfcs',
  state: 'all',
  per_page: 100,
});

await mkdir('data/raw', { recursive: true });

for await (const { data: pulls } of iterator) {
  for (const pull of pulls) {
    let { data: issueEvents } = await octokit.rest.issues.listEvents({
      owner: 'emberjs',
      repo: 'rfcs',
      issue_number: pull.number,
    });

    issueEvents = issueEvents.filter((item) =>
      ['labeled', 'unlabeled'].includes(item.event),
    );

    await writeFile(
      join('data/raw', `${pull.number}.json`),
      JSON.stringify(
        {
          number: pull.number,
          url: pull.url,
          title: pull.title,
          createdAt: pull.created_at,
          closed: pull.closed,
          closedAt: pull.closed_at,
          merged: pull.merged,
          mergedAt: pull.merged_at,
          assignees: pull.assignees.map((item) => ({
            login: item.login,
            avatarUrl: item.avatar_url,
          })),
          timelineItems: issueEvents.map((item) => ({
            event: item.event,
            createdAt: item.created_at,
            label: item.label.name,
          })),
        },
        null,
        2,
      ),
      'utf8',
    );
  }
}

// const pulls = await octokit.rest.pulls.list({
//   owner: 'emberjs',
//   repo: 'ember.js'
// })

// console.log(pulls);

// const result = await octokit.graphql.paginate(
//   `
//     query ($endCursor:String) {
//       repository(owner: "EmberJS", name: "rfcs") {
//         pullRequests(after: $endCursor, first: 100, orderBy:{ field: CREATED_AT, direction: DESC} ) {
//           pageInfo {
//             hasNextPage
//             endCursor
//           }
//           nodes {
//             number
//             url
//             title
//             createdAt
//             closed
//             closedAt
//             merged
//             mergedAt
//             assignees(first: 5) {
//               nodes {
//                 login
//                 avatarUrl
//               }
//             }
//             timelineItems(first: 10, itemTypes: [LABELED_EVENT, UNLABELED_EVENT]) {
//               nodes {
//                 ... on LabeledEvent {
//                   createdAt
//                   label {
//                     name
//                   }
//                   __typename
//                 }
//                 ... on UnlabeledEvent {
//                   createdAt
//                   label {
//                     name
//                   }
//                   __typename
//                 }
//               }
//             }
//           }
//         }
//       }
//     }
//   `,
// );

// console.log(result)
