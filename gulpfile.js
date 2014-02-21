var gulp = require('gulp');
var gutil = require('gulp-util');

var coffee = require('gulp-coffee');

var paths = {
  scripts: ['src/*.coffee']
}

gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(gulp.dest('dist'));
});

gulp.task('default', ['scripts']);
