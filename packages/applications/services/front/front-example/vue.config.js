const webpack = require('webpack')

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
        plugins: [
            new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/)
        ],
        externals: {
            'moment': 'moment',
            'vue': 'Vue',
            // 'ant-design-vue': 'antd',
            'element-ui': 'Element',
            'echarts': 'echarts',
            'v-charts': 'VeIndex',
            '@ckeditor/ckeditor5-vue': 'CKEditor',
            '@ckeditor/ckeditor5-build-classic': 'ClassicEditor'
        }
    },
}