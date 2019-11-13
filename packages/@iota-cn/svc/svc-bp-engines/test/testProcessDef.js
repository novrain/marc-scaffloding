import path from 'path'
import client from 'supertest'
import scaffold from '@iota-cn/svc-scaffolding'
import config from './config'
import chai, { assert, expect } from 'chai'

describe('processdefs test >', function () {
    this.timeout(10000)
    config.port = 19035
    const app = scaffold(config)
    const request = client.agent(app.server)
    const dc = app.iota.dc
    const models = dc.models
    let p1 = undefined

    before(async function () {
        await models.User.sync({ force: true })
        await models.User.create({ username: 'admin', password: 'test11' })
        await models.ProcessDef.sync({ force: true })
        p1 = await models.ProcessDef.create({ name: "VACATION", flowableInstance: 'vacationRequest:2:c49c7c81-01f0-11ea-ab20-7c7a916bf543', formDef: 'xxx' })
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

    it(`find all processdefs`, function (done) {
        request
            .get(`/processdefs?limit=20&name=VACATIO&belongTo=xxx`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.total, 1)
                assert.equal(res.body.processdefs.length, 1)
                // assert.equal(res.body.processdefs[0].items.length, 2)
                done()
            })
    })

    it(`find one processdef`, function (done) {
        request
            .get(`/processdefs/${p1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.id, p1.id)
                done()
            })
    })

    it(`update one processdef`, function (done) {
        request
            .put(`/processdefs/${p1.id}`)
            .send({
                name: 'p1.new'
            })
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`delete one processdef`, function (done) {
        request
            .delete(`/processdefs/${p1.id}`)
            .expect(200, function (err, res) {
                if (err) {
                    return done(err)
                }
                done()
            })
    })

    it(`create one processdef`, function (done) {
        request
            .post(`/processdefs`)
            .send({
                flowableInstance: 'ins',
                formDef: 'xx',
                name: ''
            })
            .expect(201, function (err, res) {
                if (err) {
                    return done(err)
                }
                assert.equal(res.body.formDef, 'xx')
                done()
            })
    })
})