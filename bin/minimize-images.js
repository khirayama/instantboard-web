const imagemin = require('imagemin');
const imageminJpegtran = require('imagemin-jpegtran');
const imageminPngquant = require('imagemin-pngquant');
const imageminWebp = require('imagemin-webp');

imagemin(['src/**/*.+(jpg|jpeg|png)'], 'dist/images', {
  plugins: [
    imageminJpegtran(),
    imageminPngquant({
      quality: '65-80',
    }),
  ]
});

imagemin(['src/**/*.+(jpg|jpeg|png)'], 'dist/images', {
  plugins: [
    imageminWebp({
      quality: '65-80',
    }),
  ],
});
