'use strict';

var consolidate = require('gulp-consolidate');
var changed = require('gulp-changed');
var rename = require('gulp-rename');
var gulp = require('gulp');

var engines = [
  ['jade',{'pretty':'  '}]
];

function buildTemplates(engine, src, dest) {
  return gulp.src(src)
    .pipe(changed(dest, { extension: '.html' }))
    .pipe(consolidate.apply(this, engine))
    .pipe(rename(function (path) {path.extname = '.html';}))
    .pipe(gulp.dest(dest));
}

function buildTaskFunction(engine) {
  return function() {
    buildTemplates(engine, 'src/views/**/*.jade', '.tmp/views/');
  };
}

var tasks = [];

for (var i=0, l=engines.length; i < l; i++) {
  var engine = engines[i];

  gulp.task('consolidate:' + engine[0], buildTemplates.bind(this, engine, 'src/views/**/*.jade', '.tmp/views/'));

  tasks.push('consolidate:' + engine[0]);
}

gulp.task('consolidate', tasks);
