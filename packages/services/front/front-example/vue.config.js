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
            },
        },
    },
}