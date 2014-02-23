var gulp = require('gulp'),
  gutil = require('gulp-util'),

  coffee = require('gulp-coffee'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename');

  paths = {
    scripts: ['src/*.coffee'],
    dest: 'dist'
  };

gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(gulp.dest(paths.dest));
});

gulp.task('scripts_min', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(rename({extname: '.min.js'}))
    .pipe(gulp.dest('dist'));
});

gulp.task('default', ['scripts', 'scripts_min']);
