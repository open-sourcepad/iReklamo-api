'use strict';

var gulp = require('gulp');

gulp.task('watch', ['consolidate', 'wiredep', 'injector:css', 'injector:js'] ,function () {
  gulp.watch('src/assets/styles/**/*.scss', ['injector:css']);
  gulp.watch('src/scripts/**/*.{js,coffee}', ['injector:js']);
  gulp.watch('src/assets/images/**/*', ['images']);
  gulp.watch('bower.json', ['wiredep']);
  gulp.watch('src/views/**/*.jade', ['consolidate:jade']);
});
