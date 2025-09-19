import { describe, beforeEach, it, expect } from 'vitest';
import tocBuilder from '../lib/toc-builder';
import { Project } from 'fixturify-project';
import { rollup } from 'rollup';
import { resolve } from 'path';
import pluginJson from '@rollup/plugin-json';

describe('Tag Generator', function () {
  let project;

  beforeEach(async function () {
    project = new Project('test-project', '1.2.3');
  });

  it('should automatically create a new tag for the most recent 4 posts', async function () {
    project.files = {
      data: {
        '1.json': JSON.stringify({
          number: 1,
        }),
        '2.json': JSON.stringify({
          number: 2,
        }),
        '5.json': JSON.stringify({
          number: 5,
        }),
        '11.json': JSON.stringify({
          number: 11,
        }),
      },
      content: {
        '0001-transform.md': `---
startDate: 2001
stage: accepted
---
  hello world`,
        '0002-attribute.md': `---
startDate: 2001
stage: accepted
---
  hello world`,
        '0005-meta.md': `---
startDate: 2001
stage: rejected
---
  hello world`,
        '0011-parameter.md': `---
startDate: 2001
stage: approved
---
  hello world`,
      },
      'index.js': `import json from 'rfcs-app-toc-builder:toc.json';`,
    };

    await project.write();

    const bundle = await rollup({
      treeshake: false,
      input: resolve(project.baseDir, 'index.js'),
      plugins: [
        tocBuilder(
          resolve(project.baseDir, 'content'),
          resolve(project.baseDir, 'data'),
        ),
        pluginJson(),
      ],
    });

    const { output } = await bundle.generate({ exports: 'auto' });
    const [{ code }] = output;

    expect(code).toMatchInlineSnapshot(`
      "var links = [
      	"0011-parameter",
      	"0005-meta",
      	"0002-attribute",
      	"0001-transform"
      ];
      var stages = [
      	"approved",
      	"rejected",
      	"accepted"
      ];
      var stageLinks = {
      	approved: [
      		"0011-parameter"
      	],
      	rejected: [
      		"0005-meta"
      	],
      	accepted: [
      		"0002-attribute",
      		"0001-transform"
      	]
      };
      var rfcsAppTocBuilder_toc = {
      	links: links,
      	stages: stages,
      	stageLinks: stageLinks
      };
      "
    `);
  });
});
