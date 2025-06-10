export default function formatDate(date /*, positionalB, named*/) {
  if (!date) {
    return;
  }

  try {
    return new Intl.DateTimeFormat().format(date, { dateStyle: 'full' });
  } catch (e) {
    console.error(`Error while formatting date '${date}': ${e.message}`);
  }
}
