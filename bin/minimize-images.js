const imagemin = require('imagemin');
const imageminJpegtran = require('imagemin-jpegtran');
const imageminPngquant = require('imagemin-pngquant');
const imageminWebp = require('imagemin-webp');

imagemin(['materials/**/*.+(jpg|jpeg|png)'], 'src/images', {
  plugins: [
    imageminJpegtran(),
    imageminPngquant({
      quality: '65-80',
    }),
  ]
});

imagemin(['materials/**/*.+(jpg|jpeg|png)'], 'src/images', {
  plugins: [
    imageminWebp({
      quality: '65-80',
    }),
  ],
});
