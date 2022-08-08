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
  'Rmber.js': 'framework',
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
  FIXME: '# FIXME',
};

function teams(teams) {
  if (!teams) {
    return '\n  - framework ## FIXME - added automatically as it was missing during migration';
  }

  const processedTeams = teams
    .replace(
      /^(All teams|All|All Teams)$/,
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

function issues(obj) {
  if (!obj) {
    return '';
  }
  let output = '\n';

  Object.keys(obj).forEach((key, index) => {
    output += `    ${key}: ${obj[key]}`;

    if (index !== Object.keys(obj).length - 1) {
      output += '\n';
    }
  });

  return output;
}

const files = readdirSync('text');

copySync('stages', 'processed-rfcs/stages');
copySync('teams', 'processed-rfcs/teams');
copySync('README.md', 'processed-rfcs/README.md');

for (let file of files) {
  let fileContents = readFileSync(join('text', file), 'utf8');
  console.log(`loading file ${file}`);
  let frontMatter = yamlFront.loadFront(fileContents);

  let processedFrontMatter = `start-date: ${frontMatter['Start Date']?.toISOString()}
release-date:
release-versions: ${releaseVersions(frontMatter['Release Versions'])}
teams: ${teams(frontMatter['Relevant Team(s)'] ?? frontMatter['Relevant Teams'])}
prs:
  accepted: ${frontMatter['RFC PR']}
project-link: ${frontMatter['tracking-link'] ?? ''}
stage: ${kebabCase(frontMatter.Stage ?? 'accepted')}`;

  if (
    frontMatter['Ember Issue'] ||
    frontMatter['Issues'] ||
    frontMatter['Tracking'] ||
    frontMatter['Authors'] ||
    frontMatter['Heavily Revised']
  ) {
    processedFrontMatter += `
meta:
  ember-issue: ${frontMatter['Ember Issue'] ?? ''}
  issues: ${issues(frontMatter.Issues)}
  tracking: ${frontMatter.Tracking ?? ''}
  authors: ${frontMatter.Authors ?? ''}
  heavily-revised: ${frontMatter['Heavily Revised']?.toISOString() ?? ''}`;
  }

  writeFileSync(
    join('processed-rfcs', 'text', file),
    `---
${processedFrontMatter}
---${frontMatter.__content.replaceAll('```patch', '```diff')}`
  );

  delete frontMatter['Start Date'];
  delete frontMatter['Release Versions'];
  delete frontMatter['Relevant Team(s)'];
  delete frontMatter['Relevant Teams'];
  delete frontMatter['RFC PR'];
  delete frontMatter['tracking-link'];
  delete frontMatter['Ember Issue'];
  delete frontMatter['Release Date'];
  delete frontMatter['Heavily Revised'];
  delete frontMatter.Issues;
  delete frontMatter.Stage;
  delete frontMatter.Tracking;
  delete frontMatter.Authors;
  delete frontMatter.__content;

  if (Object.keys(frontMatter).length !== 0) {
    console.error(file, frontMatter);
    // throw new Error('this file aint great');
  }
}
