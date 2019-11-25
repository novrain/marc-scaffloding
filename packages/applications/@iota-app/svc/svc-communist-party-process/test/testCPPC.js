import path from 'path'
import client from 'supertest'
import scaffold from '@iota-cn/svc-scaffolding'
import config from './config'
import chai, { assert, expect } from 'chai'

describe('communist_party_process_categories test >', function () {
    this.timeout(10000)
    config.port = 19035
    const app = scaffold(config)
    const request = client.agent(app.server)
    const dc = app.iota.dc
    const models = dc.models
    let d1 = undefined
    let d2 = undefined
    let d3 = undefined
    let d4 = undefined

    before(async function () {
        await models.User.sync({ force: true })
        await models.User.create({ username: 'admin', password: 'test11' })
        await models.CommunistPartyProcessCategory.sync({ force: true })
        d1 = await models.CommunistPartyProcessCategory.create({ id: 'cppc_1', name: 'CPPC1' })
        d2 = await models.CommunistPartyProcessCategory.create({ id: 'cppc_2', name: 'CPPC2', parentId: 'cppc_1' })
        d3 = await models.CommunistPartyProcessCategory.create({ id: 'cppc_3', name: 'CPPC3', parentId: 'cppc_2' })
        d4 = await models.CommunistPartyProcessCategory.create({ id: 'cppc_4', name: 'CPPC4', parentId: 'cppc_1' })
    })

    it('basic', function (done) {
        request
            .get('/notfound')
            .expect(404, done)
    })

    it('signin success', function (done) {
        request
            .post('/signin')
            .send({
                username: 'admin',
                password: 'test11'
            })
            .expect(200, done)
    })

    it(`find all communist_party_process_categories`, function (done) {
        request
            .get(`/communist_party/processes/categories?limit=20&key=${d1.key}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.total, 4)
                assert.equal(res.body.categories.length, 4)
                // assert.equal(res.body.communist_party_process_categories[0].items.length, 2)
                done()
            })
    })

    it(`find one category`, function (done) {
        request
            .get(`/communist_party/processes/categories/${d1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.id, d1.id)
                done()
            })
    })

    it(`update one category`, function (done) {
        request
            .put(`/communist_party/processes/categories/${d1.id}`)
            .send({
                key: 'd1.new'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`delete one category`, function (done) {
        request
            .delete(`/communist_party/processes/categories/${d1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`create one category`, function (done) {
        request
            .post(`/communist_party/processes/categories`)
            .send({
                id: 'cppc_5',
                name: 'CPPC_5'
            })
            .expect(201, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.name, 'CPPC_5')
                done()
            })
    })
})