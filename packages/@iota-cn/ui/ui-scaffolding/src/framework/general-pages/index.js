import messages from './view/locale'
import routes from './routes'

const entry = (opts) => {
    return {
        messages,
        routes: routes(opts)
    }
}

export {
    entry
}