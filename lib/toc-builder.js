import { readFileSync } from 'fs';
import { globSync } from 'glob';
import { relative, join } from 'path';
import { loadFront } from 'yaml-front-matter';

export default function tocBuilder(contentFolder) {
  return {
    name: 'rfcs-app-toc-builder',
    resolveId(source) {
      if (source === 'rfcs-app-toc-builder:toc.json') {
        return source;
      }
      return null;
    },
    load(id) {
      if (id === 'rfcs-app-toc-builder:toc.json') {
        this.addWatchFile(contentFolder);

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
      return null;
    },
  };
}
