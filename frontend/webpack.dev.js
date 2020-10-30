const path = require('path');
const merge = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common ,{
    mode: 'development',
    entry: [
        `webpack-dev-server/client?http://localhost:9000`,
        path.join(__dirname, 'src/static/index.js')
    ],
    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [{
                    loader: 'elm-webpack-loader',
                    options: {
                        verbose: true,
                        debug: true,
                        files: [
                            path.resolve(__dirname, 'src/elm/Main.elm')
                        ]
                    }
                }]
            }
        ]
    },
    devServer: {
        historyApiFallback: true,
        contentBase: './src',
        hot: true,
        port: 9000,
        proxy: {
            "/": {
                target: `http://localhost:8080`,
                changeOrigin: true
            }
        }
    }
});