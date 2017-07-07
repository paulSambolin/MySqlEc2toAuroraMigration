'use strict'

var AWS = require('aws-sdk');
var fs = require('fs');
var S3Bucket = "";
var S3Key = "";

exports.handler = (event, context,callback) => {

    // Log the incoming request
    console.log('REQUEST RECEIVED:\\n', JSON.stringify(event));
    
    S3Bucket = event.pathParameters.s3Bucket;
    S3Key = event.pathParameters.s3Key;

    download()
        .then(execute)
        .then((data) => {
            // Signal Success
            const response = {
                statusCode: 200,
                body: JSON.stringify(data)
            };
            callback(null, response);
        })
        .catch((err) => {
            console.log('failed');
            console.log(err);
            callback(null, { statusCode: 404 });
        });
}

function download() {
    var s3 = new AWS.S3();
    return new Promise((resolve) => {
        s3.getObject({
            Bucket: S3Bucket,
            Key: S3Key
        })
        .createReadStream()
        .pipe(fs.createWriteStream('/tmp/temp.sql')
            .on('close', () => {
                    console.log('downloaded');
                    resolve();
            })
        );
    });
}

function execute() {
    const exec = require('child_process').exec;
    return new Promise((resolve, reject) => {

            // Connect to database and execute commands in .sql file
            var script = './mysql/bin/mysql -h ' + process.env.HOST + ' -u ' + process.env.USERNAME + ' -p' + process.env.PASSWORD + ' ' + process.env.DATABASE + ' < /tmp/temp.sql';
            const child = exec(script, (err, stdout, stderr) => {
                if(err) {
                    console.log(err);
                    reject();
                }
                console.log(stdout);
                console.log(stderr);
                resolve();
            });
        });
}