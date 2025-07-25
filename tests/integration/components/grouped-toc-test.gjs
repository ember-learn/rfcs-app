import { module, test } from 'qunit';
import { setupRenderingTest } from 'rfcs-app/tests/helpers';
import { render } from '@ember/test-helpers';
import GroupedToc from 'rfcs-app/components/grouped-toc';

module('Integration | Component | grouped-toc', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    const testToc = {
      links: ['0001-first-post'],
      stageLinks: {
        released: ['0001-first-post'],
      },
      stages: ['released'],
    };

    await render(<template><GroupedToc @model={{testToc}} /></template>);

    // TODO improve tests
    assert.dom().hasText('Released 0001-first-post');
  });
});
