var gulp = require('gulp');
var async = require('async');
var consolidate = require('gulp-consolidate');
var iconfont = require('gulp-iconfont');

// icon fonts
gulp.task('default', function (done) {
    var iconStream = gulp.src(['./src/svg/*.svg'])
        .pipe(iconfont({
            fontName: 'iota',
            formats: ['ttf', 'eot', 'woff', 'woff2', 'svg'],
        }));
    async.parallel([
        function handleIndex(cb) {
            iconStream.on('glyphs', function (glyphs, options) {
                gulp.src('src/html/index.html')
                    .pipe(consolidate('lodash', {
                        glyphs: glyphs,
                        className: 'iota-icon'
                    }))
                    .pipe(gulp.dest('dist'))
                    .on('finish', cb);
            });
        },
        function handleGlyphs(cb) {
            iconStream.on('glyphs', function (glyphs, options) {
                gulp.src('src/css/iota_icons.css')
                    .pipe(consolidate('lodash', {
                        glyphs: glyphs,
                        fontName: 'iota',
                        fontPath: '../fonts/',
                        className: 'iota-icon'
                    }))
                    .pipe(gulp.dest('dist/css'))
                    .on('finish', cb);
            });
        },
        function handleFonts(cb) {
            iconStream
                .pipe(gulp.dest('dist/fonts'))
                .on('finish', cb);
        }
    ], done);
});