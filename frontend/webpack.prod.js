const path = require('path');
const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const TerserPlugin = require('terser-webpack-plugin');

const outputPath = path.join(__dirname, 'web/html');

module.exports = merge(common ,{
    mode: 'production',
    entry: path.join(__dirname, 'src/static/index.js'),
    output: {
        path: outputPath,
        filename: 'index_bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [{
                    loader: 'elm-webpack-loader',
                    options: {
                        optimize: true,
                        verbose: false,
                        debug: false,
                        files: [
                            path.resolve(__dirname, 'src/elm/Main.elm')
                        ]
                    }
                }]
            }
        ]
    },
    optimization: {
        minimize: true,
        minimizer: [
            new TerserPlugin({
                test: /\.js(\?.*)?$/i,
                terserOptions: {
                    compress: {},
                    mangle: true
                }
            })
        ]
    }
});