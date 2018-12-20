const path = require('path');
// const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const MonacoWebpackPlugin = require('monaco-editor-webpack-plugin');
// const WebpackAssetsManifest = require('webpack-assets-manifest');
// import CleanObsoleteChunks from 'webpack-clean-obsolete-chunks';
// const CleanWebpackPlugin = require('clean-webpack-plugin');

const isDevelopment = process.env.NODE_ENV !== 'production';

const apps = {
  main: ['./js/app.js', './css/app.scss'],
  lesson: './js/lesson/index.jsx',
};

module.exports = {
  context: path.resolve(__dirname, 'assets'),
  entry: apps,
  devtool: 'source-map',
  mode: process.env.NODE_ENV || 'development',
  output: {
    path: `${__dirname}/priv/static/assets`,
    filename: '[name].js',
    // chunkFilename: '[id].chunk.js',
    publicPath: '/assets/',
  },
  watch: isDevelopment,
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  // node: {
  //   fs: 'empty',
  // },
  plugins: [
    // new CleanWebpackPlugin(['./priv/static']),
    // new webpack.HashedModuleIdsPlugin(),
    // new WebpackAssetsManifest({ writeToDisc: true }),
    new MonacoWebpackPlugin({
      languages: ['javascript', 'php', 'java', 'python'],
    }),
    new CopyWebpackPlugin([
      { from: './locales', to: '../locales' },
      { from: './images', to: '../images' },
      { from: './favicon.ico', to: '../favicon.ico' },
    ]),
    new MiniCssExtractPlugin({
      filename: '[name].css',
      // chunkFilename: '[id].chunk.css',
    }),
    // new webpack.ProvidePlugin({
    //   $: 'jquery',
    //   jQuery: 'jquery',
    // }),
  ],
  externals: {
    gon: 'Gon',
  },

  // node: {
  //   fs: 'empty',
  // },

  optimization: {
    // runtimeChunk: 'single',
    splitChunks: {
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
        },
      },
    },
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: [
          'cache-loader',
          {
            loader: 'babel-loader',
            options: {
              cacheDirectory: true,
              presets: [
                '@babel/env',
                '@babel/flow',
                '@babel/react',
              ],
              plugins: [
                ['@babel/plugin-proposal-optional-chaining', { loose: false }],
                ['@babel/plugin-proposal-nullish-coalescing-operator', { loose: false }],

                ['@babel/plugin-proposal-decorators', { legacy: true }],
                '@babel/plugin-syntax-dynamic-import',
                ['@babel/plugin-proposal-class-properties', { loose: false }],
              ],
            },
          },
        ],
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
