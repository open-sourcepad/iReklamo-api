'use strict';

var gulp = require('gulp');
var util = require('util');
var browserSync = require('browser-sync');
var middleware = require('./proxy');
var history = require('connect-history-api-fallback')();

function browserSyncInit(baseDir, files, browser) {
  browser = browser === undefined ? 'default' : browser;

  var routes = null;
  if(baseDir === 'src' || (util.isArray(baseDir) && baseDir.indexOf('src') !== -1)) {
    routes = {
      '/bower_components': 'bower_components'
    };
  };

  browserSync.init(files, {
    startPath: '/',
    server: {
      baseDir: baseDir,
      middleware: [middleware, history],
      routes: routes
    },
    ghostMode: false,
    browser: browser,
    notify: false,
    port: 9000
  });

}

gulp.task('serve', ['watch'], function () {
  browserSyncInit([
    '.tmp',
    'src'
  ], [
    '.tmp/styles/**/*.css',
    '.tmp/scripts/**/*.js',
    'src/assets/images/**/*',
    '.tmp/**/*.html',
    '.tmp/views/**/*.html',
    'src/**/*.html',
    'src/views/**/*.html'
  ]);
});

gulp.task('serve:dist', ['build'], function () {
  browserSyncInit('public/');
});
