const { mkdirSync, readdirSync, readFileSync, writeFileSync } = require('fs');
const { join } = require('path');
const yamlFront = require('yaml-front-matter');
const { kebabCase } = require('lodash');
const { copySync } = require('fs-extra');

mkdirSync('processed-rfcs/text', { recursive: true });

function releaseVersions(versions) {
  let processedVersions = '';

  for (let v in versions) {
    if (versions[v] && versions[v] !== 'vX.Y.Z') {
      if (processedVersions.length === 0) {
        processedVersions += '\n';
      }
      processedVersions += `  ${v}: ${versions[v]}\n`;
    }
  }

  return processedVersions;
}

const teamMap = {
  'Ember.js': 'framework',
  'Ember CLI': 'cli',
  'Ember Data': 'data',
  'Ember-CLI': 'cli',
  'ember-cli': 'cli',
  'ember-data': 'data',
  'Ember Learn': 'learning',
  framework: 'framework',
  learning: 'learning',
  Steering: 'steering',
  Learning: 'learning',
  data: 'data',
  EmberData: 'data',
  Ember: 'framework',
  CLI: 'cli',
  TypeScript: 'typescript',
};

function teams(teams) {
  if (!teams) {
    return '\n  - framework';
  }

  const processedTeams = teams
    .replace(
      /^(All teams|All)$/,
      'Ember.js, Ember Data, Ember CLI, Learning, TypeScript, Steering'
    )
    .split(',')
    .map((t) => t.trim())
    .map((t) => {
      let newTeam = teamMap[t];
      if (!newTeam) {
        throw new Error(`what is ${t}`);
      }
      return newTeam;
    });

  let outputString = '';
  processedTeams.forEach((t, index) => {
    if (outputString.length === 0) {
      outputString += '\n';
    }
    outputString += `  - ${t}`;

    if (index !== processedTeams.length - 1) {
      outputString += '\n';
    }
  });
  return outputString;
}

const files = readdirSync('text');

copySync('stages', 'processed-rfcs/stages');
copySync('teams', 'processed-rfcs/teams');
copySync('README.md', 'processed-rfcs/README.md');

for (let file of files) {
  let fileContents = readFileSync(join('text', file), 'utf8');
  let frontMatter = yamlFront.loadFront(fileContents);

  writeFileSync(
    join('processed-rfcs', 'text', file),
    `---
start-date: ${frontMatter['Start Date']?.toISOString()}
release-date:
release-versions: ${releaseVersions(frontMatter['Release Versions'])}
teams: ${teams(frontMatter['Relevant Team(s)'])}
proposal-pr: ${frontMatter['RFC PR']}
tracking-link: ${frontMatter['tracking-link'] ?? ''}
stage: ${kebabCase(frontMatter.Stage ?? 'accepted')}
---${frontMatter.__content.replaceAll('```patch', '```diff')}`
  );
}
