import moment from 'moment'

const install = function (Vue) {
    Vue.prototype.$momentUtil = {
        fullFormat(date) {
            if (!date) {
                return ''
            }
            return moment(date).format('YYYY-MM-DD hh:mm:ss')
        },
        noSecfullFormat(date) {
            if (!date) {
                return ''
            }
            return moment(date).format('YYYY-MM-DD hh:mm')
        },
        dateFormat(date) {
            if (!date) {
                return ''
            }
            return moment(date).format('YYYY-MM-DD')
        },
        monthDateFormat(date) {
            if (!date) {
                return ''
            }
            return moment(date).format('MM-DD')
        },
        timeFormat(date) {
            if (!date) {
                return ''
            }
            return moment(date).format('hh:mm:ss')
        },
    }
}

export default {
    install
}