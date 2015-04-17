var gulp = require('gulp');
var inject = require('gulp-inject-string');
var riotify = require('riotify');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var glob = require("glob");

gulp.task('buildjs', function(){
    return browserify({ entries: ['./src/js/app.js'] })
    .transform(riotify)
    .bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest('www/js'));
});

gulp.task('buildhtml', function(){
    return gulp.src('./src/*.html')
    .pipe(gulp.dest('www'));
});

gulp.task('buildcss', function(){
    return gulp.src('./src/css/*.css')
    .pipe(gulp.dest('www/css'));
});

gulp.task('buildresources', function(){
    return gulp.src('./src/resources/**/*')
    .pipe(gulp.dest('www'));
});

gulp.task('webtests', function(){
    gulp.src('./src/index.html')
    .pipe(inject.before("</body>", "tests.tests.js"))
    .pipe(gulp.dest('www/test.html'));

    browserify( gulp.src('./src/tests/*.js') )
    .bundle()
    .pipe(source('tests.js'))
    .pipe(gulp.dest('www/tests'));
})

gulp.task('build', ['buildjs', 'buildhtml', 'buildcss', 'buildresources']); 

gulp.task('watch', function(){
    gulp.watch('src/js/*.js', ['buildjs']);
    gulp.watch('src/js/*.tag', ['buildjs']);
    gulp.watch('src/*.html', ['buildhtml']);
    gulp.watch('src/css/*.css', ['buildcss']);
});

gulp.task('default', ['build', 'watch']);
