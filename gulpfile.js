var gulp = require('gulp');
var riotify = require('riotify');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var gutil = require('gulp-util');


function handleErrors(e){
    // function to handle build errors graceflly
    gutil.log(
        gutil.colors.red('***************************************\n'),
        gutil.colors.red('UNCAUGHT EXCEPTION:\n'),
        gutil.colors.red('***************************************\n'),
        e.toString()
    );
    this.emit('end');

}

gulp.task('buildjs', function(){
    var bundle = browserify({ entries: ['./src/js/app.js'] })
    .transform(riotify)
    .bundle()
    .on('error', handleErrors)
    .pipe(source('app.js'))
    .pipe(gulp.dest('www/js'));

    return bundle;
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

gulp.task('buildconfig', function(){
    return gulp.src('./src/config/*')
    .pipe(gulp.dest('www/config'));
});

gulp.task('build', ['buildjs', 'buildhtml', 'buildcss', 'buildresources', 'buildconfig']); 

gulp.task('watch', function(){
    gulp.watch('src/js/*.js', ['buildjs']);
    gulp.watch('src/js/*.tag', ['buildjs']);
    gulp.watch('src/*.html', ['buildhtml']);
    gulp.watch('src/css/*.css', ['buildcss']);
    gulp.watch('src/config/*', ['buildconfig']);
});

gulp.task('default', ['build', 'watch']);
