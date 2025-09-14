import { readFileSync } from 'fs';
import { globSync } from 'glob';
import { relative, join } from 'path';
import { loadFront } from 'yaml-front-matter';
import showdown from 'showdown';
import downsize from 'downsize-cjs';

export function stripHTML(html) {
  let strippedHTML = html.replace(
    /<a href="#fn.*?rel="footnote">.*?<\/a>/gi,
    ''
  );
  strippedHTML = strippedHTML.replace(
    /<div class="footnotes"><ol>.*?<\/ol><\/div>/,
    ''
  );
  // Strip other html
  strippedHTML = strippedHTML.replace(/<\/?[^>]+>/gi, '');
  strippedHTML = strippedHTML.replace(/(\r\n|\n|\r)+/gm, ' ');

  return strippedHTML;
}

function loadRFCData(contentFolder, dataFolder) {
  const converter = new showdown.Converter();

  const files = globSync(`${contentFolder}/**/*.md`)
    .map((file) => relative(contentFolder, file))
    .map((file) => file.replace(/.md$/, ''))
    .map((file) => {
      const fileContents = readFileSync(join(contentFolder, `${file}.md`));
      return {
        ...loadFront(fileContents),
        file,
      };
    });

  const data = globSync(`${dataFolder}/*.json`)
    .map((file) => relative(dataFolder, file))
    .map((file) => file.replace(/.json$/, ''))
    .map((file) => {
      return {
        ...JSON.parse(readFileSync(join(dataFolder, `${file}.json`))),
        file,
      };
    });

  for (let file of files) {
    const number = parseInt(file.file, 10);
    let dataItem = data.find((item) => item.number === number);
    if (!dataItem) {
      console.error(`could not find data file ${number}`);
      continue;
    }

    for (let copyItem of [
      'start-date',
      'release-date',
      'release-versions',
      'teams',
      'prs',
      'project-link',
      'meta',
      '__content',
      'fcp',
    ]) {
      dataItem[copyItem] = file[copyItem];
    }

    dataItem.currentStage = file.stage;
    dataItem.rfcFile = file.file;
    const outputHTML = stripHTML(converter.makeHtml(dataItem.__content));

    dataItem.summary = downsize(outputHTML, { words: 100 });
  }

  data.sort((a, b) => b.number - a.number);

  return data;
}

function loadToc(contentFolder, dataFolder) {
  const stages = {};

  const files = loadRFCData(contentFolder, dataFolder);

  for (let file of files) {
    const stage = file.currentStage;

    if (stages[stage]) {
      stages[stage].push(file.rfcFile);
    } else {
      stages[stage] = [file.rfcFile];
    }
  }

  const outputData = {
    links: files.map((item) => item.rfcFile),
    stages: Object.keys(stages),
    stageLinks: stages,
  };
  // the source code for "virtual-module"
  return `${JSON.stringify(outputData, null, 2)}`;
}

function loadData(contentFolder, dataFolder, stage) {
  const data = loadRFCData(contentFolder, dataFolder);

  const result = [];

  for (let fileContents of data) {
    if (fileContents.currentStage === stage) {
      result.push(fileContents);
    }
  }

  // the source code for "virtual-module"
  return `${JSON.stringify(result, null, 2)}`;
}

function loadFcpData(contentFolder, dataFolder) {
  const data = loadRFCData(contentFolder, dataFolder);

  const result = [];

  for (let fileContents of data) {
    if (fileContents.fcp) {
      result.push(fileContents);
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
      // both requests through here are going to be merging these two folders' data
      if (id === 'rfcs-app-toc-builder:toc.json') {
        this.addWatchFile(contentFolder);
        this.addWatchFile(dataFolder);
        return loadToc(contentFolder, dataFolder);
      }

      if (id.startsWith('rfcs-app-toc-builder:stage-')) {
        const stage = id
          .replace(/^rfcs-app-toc-builder:stage-/, '')
          .replace(/\.json$/, '');
        this.addWatchFile(contentFolder);
        this.addWatchFile(dataFolder);
        return loadData(contentFolder, dataFolder, stage);
      }

      if (id.startsWith('rfcs-app-toc-builder:fcp.json')) {
        this.addWatchFile(contentFolder);
        this.addWatchFile(dataFolder);
        return loadFcpData(contentFolder, dataFolder);
      }

      return null;
    },
  };
}
