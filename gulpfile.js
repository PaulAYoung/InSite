var gulp = require('gulp');
var riotify = require('riotify');
var browserify = require('browserify');
var source = require('vinyl-source-stream');

gulp.task('build', function(){
    browserify({ entries: ['./src/app.js'] })
    .transform(riotify)
    .bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest('www/js'));
});

gulp.task('watch', function(){
    gulp.watch('src/*.js', ['build']);
    gulp.watch('src/*.tag', ['build']);
});
