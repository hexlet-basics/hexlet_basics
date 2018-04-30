const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
// const WebpackAssetsManifest = require('webpack-manifest-plugin');
// import CleanObsoleteChunks from 'webpack-clean-obsolete-chunks';
// import CleanWebpackPlugin from 'clean-webpack-plugin';

// const isProduction = process.env.NODE_ENV === 'production';

const apps = {
  main: ['./js/app.js', './css/app.scss'],
  lesson: './js/lesson/index.jsx',
};

module.exports = {
  context: path.resolve(__dirname, 'assets'),
  entry: apps,
  mode: process.env.NODE_ENV || 'development',
  output: {
    path: `${__dirname}/priv/static/assets`,
    filename: '[name].js',
    // chunkFilename: '[id].chunk.js',
    publicPath: '/assets/',
  },
  watch: true,
  watchOptions: {
    // aggregateTimeout: 300,
    poll: 1000,
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  plugins: [
    new CopyWebpackPlugin([
      { from: './locales', to: 'locales' },
      { from: './static' },
    ]),
    // new WebpackAssetsManifest({
    //   writeToDisk: true,
    //   publicPath: true,
    // }),
    new MiniCssExtractPlugin({
      // filename: '[name].css',
      // chunkFilename: '[id].chunk.css',
    }),
    // new CleanObsoleteChunks({ verbose: true, deep: true }),
    // new webpack.HashedModuleIdsPlugin(),
    // new ManifestPlugin({ basePath: '/assets/' }),
    new webpack.ProvidePlugin({
      // $: 'jquery',
      // jQuery: 'jquery',
      // 'window.jQuery': 'jquery',
      // React: 'react',
      // ReactDOM: 'react-dom',
      // Tether: 'tether',
      // Popper: ['popper.js', 'default'],
    }),
  ],
  externals: {
    gon: 'Gon',
  },

  optimization: {
    splitChunks: {
      chunks: 'all',
    },
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            cacheDirectory: true,
            presets: [
              '@babel/env',
              ['@babel/stage-0', { decoratorsLegacy: true }],
              '@babel/flow',
              '@babel/react',
            ],
            // plugins: ['@babel/plugin-transform-runtime'],
          },
        },
      }, {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ],
      }, {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        use: 'url-loader',
      },
    ],
  },
};
