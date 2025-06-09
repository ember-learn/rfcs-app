import { readdirSync } from "fs";

function buildRedirects() {
  const redirects = [];
  const rfcs = readdirSync('rfcs/text');

  for (let filename of rfcs) {
    const match = filename.match(/(\d+)-.*/);

    const number = parseInt(match[1]);

    redirects.push(
      `/number/${number} /id/${filename.replace(/\.md$/, '')} 301!`
    );
  }

  return redirects.join('\n');
}


export default function buildRedirectsPlugin () {
  return {
    name: 'build-redirects',
    buildEnd() {
      this.emitFile({
        type: 'asset',
        fileName: '_redirects',
        source: buildRedirects(),
      })
    }
  }
}
