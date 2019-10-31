import io from 'socket.io-client'

class MessageCenter {
    constructor(opts, actions) {
        this.actions = actions
        this.opts = opts
        this.client = io(opts.url)
        this.client.on('message', this.onMessage)
    }

    onMessage = (message) => {
        let payloadType = message.payloadType
        let payloadActions = this.actions[payloadType]
        if (typeof payloadActions === 'function') {
            payloadActions(message)
        } else if (Array.isArray(payloadActions)) {
            payloadActions.forEach(a => {
                a(message)
            })
        }
    }

    join = (room) => {
        this.client.emit('join', room)
    }

    leave = (room) => {
        this.client.emit('leave', room)
    }
}

export default {
    data() {
        return {
        }
    },

    mounted() {
        const state = this.$store.state.iota[this.id || 'container']
        if (state.messageCenter) {
            let location = window.location
            let url = `${location.protocol}//${location.hostname}:${state.messageCenter.port}/${state.messageCenter.nsp}`
            this.messageCenter = new MessageCenter(Object.assign({ url }, state.messageCenter),
                state.messageCenter.actions)
        }
    }
}