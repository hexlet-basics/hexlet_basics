const path = require('path');
// const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const MonacoWebpackPlugin = require('monaco-editor-webpack-plugin');
// const WebpackAssetsManifest = require('webpack-manifest-plugin');
// import CleanObsoleteChunks from 'webpack-clean-obsolete-chunks';
const CleanWebpackPlugin = require('clean-webpack-plugin');

const isDevelopment = process.env.NODE_ENV === 'development';

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
  watch: isDevelopment,
  watchOptions: {
    // aggregateTimeout: 300,
    poll: 1000,
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  // node: {
  //   fs: 'empty',
  // },
  plugins: [
    new CleanWebpackPlugin(['./priv/static']),
    new MonacoWebpackPlugin(),
    new CopyWebpackPlugin([
      { from: './locales', to: '../locales' },
      { from: './images', to: '../images' },
      { from: './favicon.ico', to: '../favicon.ico' },
    ]),
    new MiniCssExtractPlugin({
      filename: '[name].css',
      // chunkFilename: '[id].chunk.css',
    }),
  ],
  externals: {
    gon: 'Gon',
  },

  node: {
    fs: 'empty',
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
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.css/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
        ],
      },
      {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        use: 'url-loader',
      },
    ],
  },
};
