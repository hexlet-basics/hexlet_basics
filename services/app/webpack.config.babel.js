import webpack from 'webpack';
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

export default {
  entry: ['./assets/css/app.scss', './assets/js/app.js'],
  output: {
    path: `${__dirname}/priv/static`,
    filename: 'js/app.js',
  },
  plugins: [
    new ExtractTextPlugin('css/app.css'),
    // new CopyWebpackPlugin([{ from: './web/static/assets/', to: '../' }]),
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
          use: ['css-loader', 'sass-loader'],
        }),
      },
    ],
  },
};
