import webpack from 'webpack';
import CopyWebpackPlugin from 'copy-webpack-plugin';
import ExtractTextPlugin from 'extract-text-webpack-plugin';
// import ManifestPlugin from 'webpack-manifest-plugin';
// import CleanObsoleteChunks from 'webpack-clean-obsolete-chunks';
// import CleanWebpackPlugin from 'clean-webpack-plugin';

// const isProduction = process.env.NODE_ENV === 'production';

const apps = {
  main: ['./assets/js/app.js', './assets/css/app.scss'],
  vendors: ['./assets/js/vendors.js'],
  lesson: './assets/js/lesson/index.jsx',
};

export default {
  entry: apps,
  output: {
    path: `${__dirname}/priv/static`,
    // publicPath: isProduction ? '' : '/assets',
    filename: 'assets/[name].js',
  },
  devtool: 'inline-source-map',
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
  },
  plugins: [
    // new CleanWebpackPlugin(['priv/static']),
    new ExtractTextPlugin({
      allChunks: true,
      filename: 'assets/[name].css',
    }),
    new CopyWebpackPlugin([
      { from: 'assets/static' },
      { from: 'node_modules/font-awesome/fonts', to: 'fonts' },
    ]),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendors',
      // minChunks: 1,
    }),
    // new CleanObsoleteChunks({ verbose: true, deep: true }),
    // new webpack.HashedModuleIdsPlugin(),
    // new ManifestPlugin({ basePath: '/assets/' }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery',
      // React: 'react',
      // ReactDOM: 'react-dom',
      // Tether: 'tether',
    }),
  ],
  externals: {
    gon: 'Gon',
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
            presets: ['env', 'flow', 'stage-0'],
          },
        },
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'postcss-loader', 'sass-loader'],
        }),
      }, {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        use: 'url-loader',
      },
    ],
  },
};
