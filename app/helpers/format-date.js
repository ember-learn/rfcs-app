export default function formatDate(date /*, positionalB, named*/) {
  if (!date) {
    return;
  }

  return new Intl.DateTimeFormat().format(date, { dateStyle: 'full' });
}
