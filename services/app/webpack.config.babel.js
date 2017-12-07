import webpack from 'webpack';
import CopyWebpackPlugin from 'copy-webpack-plugin';
import ExtractTextPlugin from 'extract-text-webpack-plugin';

const apps = {
  commonCss: './assets/css/common.scss',
  lessonCss: './assets/css/lesson.scss',
  vendors: ['babel-polyfill'],
  app: './assets/js/app.js',
  lesson: './assets/js/lesson/index.jsx',
};

export default {
  entry: apps,
  output: {
    path: `${__dirname}/priv/static`,
    filename: 'js/[name].js',
  },
  devtool: 'inline-source-map',
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
  },
  plugins: [
    new ExtractTextPlugin({
      allChunks: true,
      filename: 'css/[name].css',
    }),
    new CopyWebpackPlugin([{ from: 'assets/images/favicon.ico', to: 'favicon.ico' }]),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery',
      // Tether: 'tether',
    }),
  ],
  externals: {
    gon: 'Gon',
  },
  module: {
    loaders: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['env', 'flow', 'stage-0'],
        },
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'postcss-loader', 'sass-loader'],
        }),
      },
    ],
  },
};
