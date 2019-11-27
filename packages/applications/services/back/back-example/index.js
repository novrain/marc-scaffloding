const server = require('@iota-cn/svc-scaffolding').default
const createConfig = require('./config')
const process = require('process')
const args = require('commander')

process.on('unhandledRejection', (reason, p) => {
    console.log('Unhandled Rejection at: Promise', p, 'reason:', reason)
})

args.option('-h, --host [value]', 'server host')
    .option('-p, --port [value]', 'server port')
    .option('-d, --domain [value]', 'api domain')
    .option('-u, --ui-domain [value]', 'ui domain')
    .option('-m, --message-center [value]', 'iota message center')
    .option('-g, --postgres [value]', 'postgres connection url')
    .option('-r, --redis-host [value]', 'redis server host')
    .option('-t, --redis-port [value]', 'redis server port')
    .option('-n, --attachment-in-cloud', 'store attachment in cloud')
    .option('-l, --attachment-in-cloud-dev', 'store attachment in cloud dev')
    .option('-v, --verbose', 'show debug info of dc and others')
    .parse(process.argv)

var config = createConfig(args)

console.log('Server will start at ' + config.host + ":" + config.port)
console.log('Database ' + config.dc.orm.url)

let router = server(config).router
let stack = router.stack
stack.forEach((layer) => {
    console.log(layer.methods)
    console.log(layer.path)
})