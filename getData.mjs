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

const query = `
  query($owner: String!, $repo: String!, $number: Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        number
        title
        timelineItems(first: 20, itemTypes: [LABELED_EVENT, UNLABELED_EVENT]) {
          nodes {
            __typename
            ... on LabeledEvent {
              createdAt
              actor { login }
              label { name }
            }
            ... on UnlabeledEvent {
              createdAt
              actor { login }
              label { name }
            }
          }
        }
      }
    }
  }
`;

await mkdir('data/raw', { recursive: true });

for await (const { data: pulls } of iterator) {
  for (const pull of pulls) {
    const data = await octokit.graphql(query, {
      owner: "emberjs",
      repo: "rfcs",
      number: pull.number,
    });

    const timeLineEvents = data.repository.pullRequest.timelineItems.nodes.map((n) => ({
      event: n.__typename === "LabeledEvent"
      ? "labeled"
      : n.__typename === "UnlabeledEvent"
      ? "unlabeled"
      : null,
      createdAt: n.createdAt,
      label: n.label?.name ?? null,
    }));

    await writeFile(
      join('data/raw', `${pull.number}.json`),
      JSON.stringify(
        {
          number: pull.number,
          url: pull.url,
          title: pull.title,
          createdAt: pull.created_at,
          closed: Boolean(pull.closed_at),
          closedAt: pull.closed_at,
          merged: Boolean(pull.merged_at),
          mergedAt: pull.merged_at,
          assignees: pull.assignees.map((item) => ({
            login: item.login,
            avatarUrl: item.avatar_url,
          })),
          timelineItems: timeLineEvents,
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
