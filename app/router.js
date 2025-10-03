import EmberRouter from '@ember/routing/router';
import config from 'rfcs-app/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('rfc', { path: 'id/:id' });
  this.route('stages', function () {
    this.route('proposed');
    this.route('exploring');
    this.route('accepted');
    this.route('released');
    this.route('recommended');
    this.route('discontinued');
    this.route('closed');
    this.route('ready-for-release');
    this.route('library');
  });
  this.route('create-rfc');
  this.route('role-core-team');
  this.route('rfcs-input');
  this.route('rfcs-help');
});
