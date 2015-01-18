//CoppeWeb Image Server
//Created by Yicheng Wang on 01/16/2015
//Copyright (c) 2015 Yicheng Wang. All rights reserved.
// ===================================================




//set up pkgs and pres.
var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var s3 = new AWS.S3();
var net = require('net');
var server = net.createServer();
var socketbuf = new Buffer(0);


//handlers. 
server.on('connection',function(socket){
	console.log('get connection.');
	socket.on('data',function(data){
		if(data.toString() == 'back'){
		    var imagejson = {
			'Bucket':'coppewebimage',
			'Key':'firstimage.png'
		    };
		    s3.getObject(imagejson,function(err,data){
			    if(err) console.log(err,err.stack);
			    else{
				console.log(data['Body']);
				socket.write(data['Body']);
				console.log(data['Body'].length);
				console.log('reach here');
			    }
			});
		}
		else{
		    console.log(data.length);
		    if(data.length == 65536){
			socketbuf = Buffer.concat([socketbuf,new Buffer(data)]);
		    }
		    else{
			socketbuf = Buffer.concat([socketbuf,new Buffer(data)]);
			var imagejson = {
			    'Bucket':'coppewebimage',
			    'Key':'firstimage.png',
			    'Body':socketbuf
			};
			console.log(socketbuf.length);
			s3.putObject(imagejson,function(err,data){
				if(err) console.log(err.stack);
				else{
				    console.log('upload successful.');
				}
			    });
			socketbuf = new Buffer(0);
		    }

		}
	    });

    });


server.listen(8125);
console.log('server running');