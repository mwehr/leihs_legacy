const webpack = require('webpack')
const { environment } = require('@rails/webpacker')
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer')
  .BundleAnalyzerPlugin

// import { WebpackBundleSizeAnalyzerPlugin } from 'webpack-bundle-size-analyzer';

// NOTE: commons chunk does not work for server-side render!
// environment.plugins.set(
//   'CommonsChunkVendor',
//   new webpack.optimize.CommonsChunkPlugin({
//     name: 'common',
//     minChunks: module => {
//       // this assumes your vendor imports exist in the node_modules directory
//       return module.context && module.context.indexOf('node_modules') !== -1
//     }
//   })
// )
//
// environment.plugins.set(
//   'CommonsChunkManifest',
//   new webpack.optimize.CommonsChunkPlugin({
//     name: 'manifest',
//     minChunks: Infinity
//   })
// )

environment.plugins.set(
  'BundleAnalyzerPlugin',
  new BundleAnalyzerPlugin({
    analyzerMode: 'static',
    reportFilename: 'report.html',
    // Module sizes to show in report by default.
    // Should be one of `stat`, `parsed` or `gzip`.
    defaultSizes: 'parsed',
    // Automatically open report in default browser
    openAnalyzer: false,
    // If `true`, Webpack Stats JSON file will be generated in bundles output directory
    generateStatsFile: true,
    statsFilename: 'stats.json',
    // Log level. Can be 'info', 'warn', 'error' or 'silent'.
    logLevel: 'info'
  })
)

module.exports = environment
