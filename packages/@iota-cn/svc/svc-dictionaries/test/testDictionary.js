import path from 'path'
import client from 'supertest'
import scaffold from '@iota-cn/svc-scaffolding'
import config from './config'
import chai, { assert, expect } from 'chai'

describe('dictionaries test >', function () {
    this.timeout(10000)
    config.port = 19035
    const app = scaffold(config)
    const request = client.agent(app.server)
    const dc = app.iota.dc
    const models = dc.models
    let d1 = undefined
    let d2 = undefined
    let d2Itme1 = undefined

    before(async function () {
        await models.User.sync({ force: true })
        await models.User.create({ username: 'admin', password: 'test11' })
        await models.Dictionary.sync({ force: true })
        await models.DictionaryItem.sync({ force: true })
        d1 = await models.Dictionary.create({ key: 'd_1', name: '字典1' })
        await models.DictionaryItem.create({ key: 'd_1_1', name: '字典1-条目1', dictionaryId: d1.id, })
        await models.DictionaryItem.create({ key: 'd_1_2', name: '字典1-条目2', dictionaryId: d1.id, index: 0 })
        await models.DictionaryItem.create({ key: 'd_1_3', name: '字典1-条目3', dictionaryId: d1.id, })
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

    it(`find all dictionaries`, function (done) {
        request
            .get(`/dictionaries?limit=20&key=${d1.key}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.total, 1)
                assert.equal(res.body.dictionaries.length, 1)
                // assert.equal(res.body.dictionaries[0].items.length, 2)
                done()
            })
    })

    it(`find one dictionary`, function (done) {
        request
            .get(`/dictionaries/${d1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.id, d1.id)
                assert.equal(res.body.items.length, 3)
                done()
            })
    })

    it(`update one dictionary`, function (done) {
        request
            .put(`/dictionaries/${d1.id}`)
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

    it(`delete one dictionary`, function (done) {
        request
            .delete(`/dictionaries/${d1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`create one dictionary`, function (done) {
        request
            .post(`/dictionaries`)
            .send({
                key: 'd2',
                name: '字典2'
            })
            .expect(201, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.key, 'd2')
                d2 = res.body
                done()
            })
    })

    it(`create one item`, function (done) {
        request
            .post(`/dictionaries/${d2.id}/items`)
            .send({
                key: 'd2_1',
                name: '字典2_item1'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert(res.body.key, 'd2_1')
                d2Itme1 = res.body
                done()
            })
    })

    it(`update one item`, function (done) {
        request
            .put(`/dictionaries/${d2.id}/items/${d2Itme1.id}`)
            .send({
                key: 'd2_1',
                name: '字典2_item1_new'
            })
            .expect(204, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`create conflict item`, function (done) {
        request
            .post(`/dictionaries/${d2.id}/items`)
            .send({
                key: 'd2_1',
                name: '字典2_item1'
            })
            .expect(409, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`delete one item`, function (done) {
        request
            .delete(`/dictionaries/${d2.id}/items/${d2Itme1.id}`)
            .expect(204, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`delete one item not found`, function (done) {
        request
            .delete(`/dictionaries/${d2.id}/items/${d2Itme1.id}`)
            .expect(404, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`update one item not found`, function (done) {
        request
            .put(`/dictionaries/${d2.id}/items/${d2Itme1.id}`)
            .send({
                key: 'd2_1',
                name: '字典2_item1_new'
            })
            .expect(404, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })
})