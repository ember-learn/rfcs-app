#!/usr/bin/env node

import { readdir, readFile, writeFile } from 'fs/promises';
import { join } from 'path';

const rfcsFiles = await readdir('./data/raw');

rfcsFiles.sort((a, b) => parseInt(a) - parseInt(b));

let rfcMap = {};

function getDays(date1, date2) {
  if (date1) {
    return Math.ceil(
      (new Date(date1) - new Date(date2)) / (1000 * 60 * 60 * 24),
    );
  } else {
    return Math.ceil((new Date() - new Date(date2)) / (1000 * 60 * 60 * 24));
  }
}

function findFirstStage(rfc) {
  if (rfc.merged) {
    return 'accepted';
  } else if (!rfc.closed) {
    if (
      rfc.timelineItems.filter((item) => item.label == 'S-Exploring').length ==
      1
    ) {
      return 'exploring';
    } else {
      return 'proposed';
    }
  } else {
    return 'closed';
  }
}

function isFCP(rfc) {
  return rfc.timelineItems.filter(
      (item) => item.label == 'Final Comment Period',
    ).length % 2 == 1
}

function getFirstStagesDuration(rfc) {
  if (!rfc.closed || rfc.merged) {
    let exploringLabels = rfc.timelineItems.filter(
      (item) => item.label == 'S-Exploring',
    );
    if (exploringLabels.length > 0) {
      if (rfc.merged) {
        return {
          proposed: getDays(exploringLabels[0].createdAt, rfc.createdAt),
          exploring: getDays(rfc.mergedAt, exploringLabels[0].createdAt),
          accepted: null,
          release: null,
          released: null,
        };
      } else {
        return {
          proposed: getDays(exploringLabels[0].createdAt, rfc.createdAt),
          exploring: getDays(new Date(), exploringLabels[0].createdAt),
          accepted: null,
          release: null,
          released: null,
        };
      }
    } else {
      return {
        proposed: getDays(new Date(), rfc.createdAt),
        exploring: null,
        accepted: null,
        release: null,
        released: null,
      };
    }
  } else {
    return {
      closed: this.getDays(rfc.closedAt, rfc.createdAt),
    };
  }
}

for (let file of rfcsFiles) {
  const rfc = JSON.parse(await readFile(join('data/raw', file), 'utf8'));

  if (rfc.title.includes('Advance RFC')) {
    let advanceRFC = rfc.title.match(/[0-9]+/);
    let num = parseInt(advanceRFC, 10);
    let stage = rfc.title.split(' ').pop().toLowerCase();
    rfcMap[num].stageDuration[`${rfcMap[num].currentStage}`] = getDays(
      rfc.mergedAt,
      rfc.createdAt,
    );
    if (rfc.merged) {
      rfcMap[num].currentStage = stage;
    }
    if (rfc.assignees.length > 0) {
      rfcMap[num].assignees.push(...rfc.assignees);
    }
    rfcMap[num].fcp = isFCP(rfc);
    rfcMap[num].connected.push(rfc);
  } else {
    rfcMap[rfc.number] = {
      ...rfc,
      currentStage: findFirstStage(rfc),
      labels: rfc.timelineItems.filter((item) => item.label == 'S-Exploring'),
      fcp: isFCP(rfc),
      stageDuration: getFirstStagesDuration(rfc),
      connected: [],
      assignees: rfc.assignees,
    };
  }
}

for (let rfc in rfcMap) {
  await writeFile(
    join('data', `${rfc}.json`),
    JSON.stringify(rfcMap[rfc], null, 2),
  );
}
