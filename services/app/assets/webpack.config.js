// @ts-check

const path = require('path');
// const glob = require('glob');
// const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const MonacoWebpackPlugin = require('monaco-editor-webpack-plugin');
// const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
// const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');

module.exports = {
  devtool: 'source-map',
  mode: process.env.NODE_ENV || 'development',
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  externals: {
    gon: 'Gon',
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              cacheDirectory: true,
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
    ],
  },
  entry: {
    app: './js/app.js',
    lesson: './js/lesson/index.jsx',
  },
  output: {
    publicPath: '/js/',
    // chunkFilename: '[id].chunk.js',
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js'),
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '[name].css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
    new MonacoWebpackPlugin({
      languages: ['json', 'javascript', 'php', 'java', 'python', 'scheme', 'html'],
    }),
  ],
};
