import { readFileSync } from 'fs';
import { globSync } from 'glob';
import { relative, join } from 'path';
import { loadFront } from 'yaml-front-matter';

function loadToc(context, contentFolder) {
  context.addWatchFile(contentFolder);

  const files = globSync(`${contentFolder}/**/*.md`)
    .map((file) => relative(contentFolder, file))
    .map((file) => file.replace(/.md$/, ''))
    .toSorted((a, b) => a.localeCompare(b));

  const stages = {};

  for (let file of files) {
    const fileContents = readFileSync(join(contentFolder, `${file}.md`));
    const frontMatter = loadFront(fileContents);
    const stage = frontMatter.stage;

    if (stages[stage]) {
      stages[stage].push(file);
    } else {
      stages[stage] = [file];
    }
  }

  const outputData = {
    links: files,
    stages: Object.keys(stages),
    stageLinks: stages,
  };
  // the source code for "virtual-module"
  return `${JSON.stringify(outputData, null, 2)}`;
}

function loadData(context, dataFolder) {
  context.addWatchFile(dataFolder);

  const files = globSync(`${dataFolder}/*.json`)
    .map((file) => relative(dataFolder, file))
    .map((file) => file.replace(/.json$/, ''))
    .toSorted((a, b) => a.localeCompare(b));

  const result = [];

  for (let file of files) {
    const fileContents = JSON.parse(readFileSync(join(dataFolder, `${file}.json`)));

    console.log(file, fileContents.currentStage)


    if (fileContents.currentStage === 'accepted') {
      result.push(fileContents)
    }
  }

  // the source code for "virtual-module"
  return `${JSON.stringify(result, null, 2)}`;
}

export default function tocBuilder(contentFolder, dataFolder) {
  return {
    name: 'rfcs-app-toc-builder',
    resolveId(source) {
      if (source.startsWith('rfcs-app-toc-builder:')) {
        return source;
      }
      return null;
    },
    load(id) {
      if (id === 'rfcs-app-toc-builder:toc.json') {
        return loadToc(this, contentFolder);
      }

      if (id.startsWith('rfcs-app-toc-builder:stage-')) {
        return loadData(this, dataFolder);
      }

      return null;
    },
  };
}
