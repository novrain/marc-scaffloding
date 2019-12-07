import formidable from 'formidable';
import fs from 'fs-extra';
import path from 'path';
import uuid from 'uuid';
import os from 'os';
import qiniu from 'qiniu';

export default class Attachment {

    constructor() {

    }

    upload = async (opts, ctx, form, conf) => {
        let params = {};
        await new Promise(async (resolve, reject) => {
            form.on('progress', function (bytesReceived, bytesExpected) {
                if (bytesExpected > conf.maxSize) {
                    reject('unsupported size');
                }
            })
                .on('fileBegin', function (name, file) {
                    if (!isValidFile(file.name, file.type)) {
                        file.path = form.uploadDir + '/null';
                        reject('unsupported format');
                    }
                })
                .on('field', function (name, value) { })
                .on('error', function (err) {
                    reject(err);
                })
                .on('aborted', function () {
                    reject('aborted error');
                })
                .parse(ctx.req, function (err, fields, files) { });
            if (opts.qiniu) {
                form.onPart = function (part) {
                    if (!isValidFile(part.filename, part.mime)) {
                        reject('unsupported format');
                        return;
                    }
                    let key = path.posix.join(conf.childPath, ctx.session.user.id, uuid.v4(), part.filename);
                    let size = 0;
                    let fileBuffer = new Buffer([]);
                    part.on('data', function (buffer) {
                        size += buffer.length;
                        if (size > conf.maxSize) {
                            reject('maxFileSize exceeded, received ' + conf.maxSize + ' bytes of file data');
                            return;
                        }
                        if (buffer.length == 0) {
                            return;
                        }
                        fileBuffer = Buffer.concat([fileBuffer, buffer]);
                    });
                    part.on('end', function () {
                        var options = {
                            scope: opts.qiniu.bucket,
                        }
                        var mac = new qiniu.auth.digest.Mac(opts.qiniu.accessKey, opts.qiniu.secretKey);
                        var putPolicy = new qiniu.rs.PutPolicy(options);
                        var uploadToken = putPolicy.uploadToken(mac);
                        var config = new qiniu.conf.Config();
                        var formUploader = new qiniu.form_up.FormUploader(config);
                        var putExtra = new qiniu.form_up.PutExtra();
                        formUploader.put(uploadToken, key, fileBuffer, putExtra, function (err, respBody, respInfo) {
                            if (err) {
                                reject(err);
                                return;
                            }
                            if (respInfo.statusCode == 200) {
                                params.uploaded = opts.qiniu.domain + '/' + respBody.key;
                                resolve('ok');
                            } else {
                                reject(new Error('failed to upload.'));
                            }
                        });
                    });
                }
            } else {
                form.on('file', function (name, file) {
                    let ar = file.path.split(path.sep);
                    let fileName = ar[ar.length - 1];
                    let type = file.type.split('/');
                    params.origin = file.name;
                    params.type = type[1];
                    params.uploaded = '/' + conf.childPath + '/' + fileName;
                    params.size = Math.ceil(file.size / 1024) + 'kb';
                    params.path = file.path
                })
                    .on('end', function () {
                        resolve('ok');
                    })
            }
        });
        return params;
    }

    create(opts) {
        return async (ctx, next) => {
            let doc = ctx.params.p ? ctx.params.p : 'other';
            try {
                let conf = {
                    rootPath: opts && opts.rootPath ? opts.rootPath : 'static',
                    childPath: opts && opts.childPath ? opts.childPath : ['upload'],
                    maxSize: opts && opts.maxSize ? opts.maxSize : 2097152
                }
                conf.childPath = conf.childPath + '/' + doc;
                let form = new formidable.IncomingForm();
                form.maxFieldsSize = conf.maxSize; //似乎只对form数据生效 2mb = 2 * 1024 * 1024 = 2097152
                form.maxFields = 1; //一次上传最多文件数
                //for local only
                if (!opts.qiniu) {
                    //存储路径
                    let uploadDir = path.join(conf.rootPath, conf.childPath);
                    await createFolder(uploadDir);
                    form.keepExtensions = true; //是否保留拓展名
                    form.uploadDir = uploadDir;
                }
                try {
                    let params = await this.upload(opts, ctx, form, conf);
                    ctx.status = 200;
                    ctx.body = { uploaded: params.uploaded };
                } catch (e) {
                    ctx.status = 400;
                    ctx.body = {
                        name: 'upload failed',
                        message: `method: ${opts.qiniu ? 'qiniu' : 'local'}`,
                        detail: e
                    };
                }
            } catch (e) {
                ctx.status = 500;
                ctx.iota.logger.error(`path: ${ctx.path},  error: ${e}`);
            }
        }
    }

    // update(opts) {
    //     return async(ctx, next) => {
    //         let src;
    //         if (ctx.query.src) {
    //             src = ctx.query.src;
    //         } else {
    //             ctx.status = 400;
    //             ctx.body = {
    //                 name: 'Validation error',
    //                 message: 'Invalid request message framing, malformed request syntax,or deceptive request routing.',
    //                 detail: 'Lack of parameter'
    //             };
    //             return;
    //         }

    //         try {
    //             let conf = {
    //                 rootPath: opts && opts.rootPath ? opts.rootPath : 'static',
    //                 childPath: opts && opts.childPath ? opts.childPath : ['upload'],
    //                 maxSize: opts && opts.maxSize ? opts.maxSize : '1048576'
    //             }
    //             let jointPath = conf.rootPath;
    //             let originPath = path.join(jointPath, src);

    //             await fsAccess(originPath);
    //             conf.childPath = path.dirname(src);
    //             jointPath = path.dirname(originPath);

    //             let form = new formidable.IncomingForm();
    //             form.uploadDir = jointPath; //存储路径
    //             form.maxFieldsSize = conf.maxSize; //似乎只对form数据生效 2mb = 2 * 1024 * 1024 = 2097152
    //             form.maxFields = 1; //一次上传最多文件数
    //             form.keepExtensions = true; //是否保留拓展名

    //             let params = {};
    //             try {
    //                 let params = await upload(opts, form, conf);
    //                 delFiles(ctx, originPath);
    //             } catch (e) {
    //                 ctx.status = 400;
    //                 ctx.body = {
    //                     name: 'validation error',
    //                     message: 'invalid request message framing, malformed request syntax,or deceptive request routing.',
    //                     detail: e
    //                 };
    //             }
    //         } catch (e) {
    //             ctx.status = 500;
    //             ctx.iota.logger.error(`path: ${ctx.path},  error: ${e}`);
    //         }

    //     }
    // }
}

function fsAccess(p) {
    return new Promise((resolve, reject) => {
        fs.access(p, (err) => {
            if (err) {
                reject('The file may not exist')
            } else {
                resolve('success')
            }
        })
    })
}

function isValidFile(fileName, fileType) {
    let fileTypes = /jpe*g|bmp|gif|png|msword|pdf|text|zip|doc|docx|txt|xls|xlsx|log|octet-stream/;
    let mimetype = fileTypes.test(fileType);
    let fileExtName = path.extname(fileName).toLowerCase();
    let extname = fileTypes.test(fileExtName);
    return mimetype && extname;
}

function delFiles(ctx, p) {
    fs.unlink(p, (err) => {
        if (err) {
            ctx.iota.logger.error(`path: ${p},error:delete files ${err}`);
        }
    })
}

function createFolder(p) {
    return new Promise((resolve, reject) => {
        fs.access(p, (err) => {
            if (err) {
                fs.mkdirs(p, (err) => {
                    if (err) {
                        reject(`create ${p} fail`);
                    } else {
                        resolve('success')
                    }
                })
            } else {
                resolve('success')
            }
        })
    })
}