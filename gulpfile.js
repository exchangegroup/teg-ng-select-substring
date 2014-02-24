var gulp = require('gulp'),

  coffee = require('gulp-coffee'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  karma = require('gulp-karma'),
  ngmin = require('gulp-ngmin'),
  connect = require('gulp-connect');

  paths = {
    scripts: ['src/*.coffee'],
    dest: 'dist',
    app: ['./app/*.html', './app/scripts/*.js']
  };

gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(ngmin())
    .pipe(gulp.dest(paths.dest));
});

gulp.task('scripts_min', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(ngmin())
    .pipe(uglify())
    .pipe(rename({extname: '.min.js'}))
    .pipe(gulp.dest('dist'));
});

gulp.task('test', function() {
  return gulp.src('take files from karma.conf please')
    .pipe(karma({
      configFile: 'karma.conf.js',
      action: 'run'
    }));
});

gulp.task('connect', connect.server({
  root: ['app', 'dist'],
  port: 1337,
  livereload: true,
  open: {
    browser: 'Google Chrome'
  }
}));

gulp.task('html', function () {
  gulp.src('./app/*.html')
    .pipe(connect.reload());
});

gulp.task('watch', function () {
  gulp.watch(paths.app, ['html']);
});

gulp.task('serve', ['connect', 'watch']);
gulp.task('default', ['test', 'scripts', 'scripts_min']);
