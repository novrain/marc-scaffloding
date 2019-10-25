const path = require('path')

module.exports = {
    productionSourceMap: false,
    css: {
        loaderOptions: {
            less: {
                modifyVars: {
                    'primary-color': '#3860f4',
                    'link-color': '#3860f4',
                },
                javascriptEnabled: true
            }
        }
    },
    configureWebpack: {
        resolve: {
            alias: {
                // '@': path.resolve(__dirname, './src'),
                // '@axios': path.resolve(__dirname, './src/axios'),
                // '@styles': path.resolve(__dirname, './src/styles'),
                // '@util': path.resolve(__dirname, './src/framework/util'),
            },
        },
    },
}