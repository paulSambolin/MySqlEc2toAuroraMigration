'use strict'
// see https://stackoverflow.com/questions/5818312/mysql-with-node-js for sending structured queries

var AWS = require('aws-sdk');
var mysql = require('mysql');
//var random_name = require('node-random-name');

exports.handler = (event, context,callback) => {
    // keeps the lambda from timing out because mysql keeps the event loop open until con.end() is explicitly called
    context.callbackWaitsForEmptyEventLoop = false;

    // Log the incoming request
    console.log('REQUEST RECEIVED:\\n', JSON.stringify(event));
    
    // Configure mysql connection
    var con = mysql.createConnection({
        host: process.env.HOST,
        database: process.env.DATABASE,
        user: process.env.USERNAME,
        password: process.env.PASSWORD
    });

    // Connect to mysql
    con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");

        // Send query
        var query = 'SHOW SLAVE STATUS';
        con.query(query, function (err, result) {
            if (err) {
                callback(null, { statusCode: 404 });
                throw err;
            }

            console.log("Slave Status: " + JSON.stringify(result));

            let body = ""
            if (result.length < 1) {
                body = "Slave not running.";
            }
            else if (result[0]["Seconds_Behind_Master"] == null) {
                body = "Seconds_Behind_Master field is null, you should check the status in more detail.";
            }
            else {
                body = "Replication Lag: " + result[0]["Seconds_Behind_Master"] + " seconds behind.";
            }

            // Signal Success
            const response = {
                statusCode: 200,
                body: JSON.stringify(body)
            };
            callback(err, response);
        });
    });
}