module.exports = {
    productionSourceMap: false,
    css: {
        loaderOptions: {
            less: {
                modifyVars: {
                    'primary-color': '#3860f4',
                    'link-color': '#3860f4',
                    'border-radius-base': '0px',
                    'ii-border-radius': '0px'
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