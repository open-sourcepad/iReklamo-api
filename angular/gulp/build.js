'use strict';

var changed = require('gulp-changed')
var gulp = require('gulp');
var jpegRecompress = require('imagemin-jpeg-recompress');

var $ = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'main-bower-files', 'uglify-save-license', 'del']
});

gulp.task('styles', ['wiredep'], function () {
  return gulp.src('src/assets/styles/main.scss')
    .pipe($.sass({style: 'expanded'}))
    .on('error', function handleError(err) {
      console.error(err.toString());
      this.emit('end');
    })
    .pipe($.autoprefixer())
    .pipe($.naturalSort())
    .pipe(gulp.dest('.tmp/assets/styles/'));
});

gulp.task('injector:css', ['styles'], function () {
  return gulp.src('src/index.html')
    .pipe($.inject(gulp.src([
        '.tmp/assets/styles/**/*.css',
        '!.tmp/assets/styles/vendor.css'
      ], {read: false})
      .pipe($.naturalSort()), {
      ignorePath: '.tmp',
      addRootSlash: false
    }))
    .pipe(gulp.dest('src/'));
});

gulp.task('scripts', function () {
  return gulp.src('src/scripts/**/*.coffee')
    .pipe(changed('.tmp/scripts', { extension: '.js' }))
    .pipe($.coffeelint())
    .pipe($.coffeelint.reporter())
    .pipe($.coffee())
    .on('error', function handleError(err) {
      console.error(err.toString());
      this.emit('end');
    })
    .pipe(gulp.dest('.tmp/scripts'))
    .pipe($.size());
});

gulp.task('injector:js', ['scripts', 'injector:css'], function () {
  return gulp.src('src/index.html')
    .pipe($.inject(gulp.src([
      '.tmp/scripts/**/*.js',
    ])
    .pipe($.naturalSort())
    .pipe($.angularFilesort()), {
      ignorePath: '.tmp',
      addRootSlash: false
    }))
    .pipe(gulp.dest('src/'));
});

gulp.task('partials', ['consolidate'], function () {
  return gulp.src('.tmp/views/**/*.html')
    .pipe($.minifyHtml({
      empty: true,
      spare: true,
      quotes: true,
      loose: true,
    }))
    .pipe($.angularTemplatecache('templateCacheHtml.js', {
      module: 'iReklamo',
      root:'views',
    }))
    .pipe(gulp.dest('.tmp/inject/'));
});

gulp.task('html', ['wiredep', 'injector:css', 'injector:js', 'partials'], function () {
  var htmlFilter = $.filter('*.html');
  var jsFilter = $.filter('**/*.js');
  var cssFilter = $.filter('**/*.css');
  var assets;

  return gulp.src(['src/*.html','.tmp/*.html'])
    .pipe($.inject(gulp.src('.tmp/inject/templateCacheHtml.js', {read: false}), {
      starttag: '<!-- inject:partials -->',
      ignorePath: '.tmp',
      addRootSlash: false
    }))
    .pipe(assets = $.useref.assets())
    .pipe($.rev())
    .pipe(jsFilter)
    .pipe($.ngAnnotate())
    .pipe($.uglify({preserveComments: $.uglifySaveLicense}))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe($.replace('bower_components/bootstrap-sass-official/assets/fonts/bootstrap','assets/fonts'))
    .pipe($.csso())
    .pipe(cssFilter.restore())
    .pipe(assets.restore())
    .pipe($.useref())
    .pipe($.revReplace())
    .pipe(htmlFilter)
    .pipe($.minifyHtml({
      empty: true,
      spare: true,
      quotes: true
    }))
    .pipe(htmlFilter.restore())
    .pipe(gulp.dest('public/'))
    .pipe($.size({ title: 'public/', showFiles: true }));
});

gulp.task('images', function () {
  return gulp.src('src/assets/images/*')
    .pipe($.imagemin({
      optimizationLevel: 7,
      interlaced: true,
      use: [jpegRecompress({ loops: 6, max: 70 })]
    }))
    .pipe(gulp.dest('public/assets/images/'));
});

gulp.task('fonts', function () {
  return gulp.src($.mainBowerFiles().concat('src/assets/fonts/**/*'))
    .pipe($.filter('**/*.{eot,svg,ttf,woff}'))
    .pipe($.flatten())
    .pipe(gulp.dest('public/assets/fonts/'));
});

gulp.task('misc', function () {
  return gulp.src('src/**/*.ico')
    .pipe(gulp.dest('public/'));
});

gulp.task('clean', function (done) {
  $.del(['public/*', '.tmp/'], {force: true}, done);
});

gulp.task('build', ['html', 'images', 'fonts', 'misc']);
