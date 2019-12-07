import Sequelize from '@iota-fork/sequelize';

describe('Sequelize test', function () {
    let sequelize;
    before(async function (done) {
        try {
            let options = {
                url: "postgres://postgres:ROOT@localhost:5433/iOTA_ut",
                opts: {}
            };
            sequelize = new Sequelize(options.url, options.opts);
            done();
        } catch (err) {
            done(err);
        }
    });

    it('dc init sqlite', function (done) {
        let User = sequelize.define('user', {
            username: {
                type: Sequelize.STRING,
                field: 'username'
            },
            password: {
                type: Sequelize.STRING,
                field: 'password'
            },
            phone: {
                type: Sequelize.STRING,
                field: 'phone'
            },
            email: {
                type: Sequelize.STRING,
                field: 'email'
            },
            apikey: {
                type: Sequelize.STRING,
                field: 'apikey'
            },
            enable: {
                type: Sequelize.BOOLEAN,
                field: 'enable'
            },
            creator: {
                type: Sequelize.INTEGER,
                field: 'creator'
            }
        });

        User.sync({ force: true }).then(function () {
            // Table created
            User.create({
                username: 'John',
                password: 'Hancock'
            }).then(function () {
                done();
            });
        });
    });

});