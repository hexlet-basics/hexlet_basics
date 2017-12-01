const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

export default {
  entry: ['./css/app.scss', './js/app.js'],
  output: {
    path: `${__dirname}/../priv/static`,
    filename: 'js/app.js',
  },
  plugins: [
    new ExtractTextPlugin('css/app.css'),
    // new CopyWebpackPlugin([{ from: './web/static/assets/', to: '../' }]),
    // new CopyWebpackPlugin([ { from: 'node_modules/monaco-editor/min/vs', to: 'vs', } ])
  ],
  module: {
    loaders: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        // query: {
        //   presets: ['env'],
        // },
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: ["css-loader", "sass-loader"]
        })
      }
    ],
  },
}
