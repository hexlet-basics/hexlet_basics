import webpack from 'webpack';
import CopyWebpackPlugin from 'copy-webpack-plugin';
import ExtractTextPlugin from 'extract-text-webpack-plugin';

const apps = {
  app: './assets/js/app.js',
  lesson: './assets/js/lesson/index.jsx',
};

export default {
  entry: apps,
  output: {
    path: `${__dirname}/priv/static`,
    filename: 'js/[name].js',
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
