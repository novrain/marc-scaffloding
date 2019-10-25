let clientSide = {
    port: 3222,
    namespaces: [{
            nsp: 'console',
            requireAuth: true,
            cookiePrefix: 'c',
            cookieKey: 'iota',
            redis: {
                host: "127.0.0.1",
                port: '6379',
                db: 0
            }
        },
        {
            nsp: 'background',
            requireAuth: true,
            cookiePrefix: 'b',
            cookieKey: 'iota',
            redis: {
                host: "127.0.0.1",
                port: '6379',
                db: 1
            }
        }
    ]
}

let serverSide = {
    port: 5001,
    consumers: [
        "NoticeConsumer"
    ],
    namespaces: [{
            nsp: 'console'
        },
        {
            nsp: 'background',
        }
    ]
}

export {
    clientSide,
    serverSide
}