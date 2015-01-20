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

//handlers. 
server.on('connection',function(socket){
	console.log('get connection.');
	socket.on('end',function(){
		console.log('lose one connection.');
	    });
	// get the actions
	var chunk = '';
	var string = '';
	var g_index = 0;
	socket.on('data',function(data){
		console.log(data.length);
		chunk += data.toString();  // handle the JSON object here.
		d_index = chunk.indexOf(';');
		g_index = d_index;
		var jsonstring;
		while(d_index > -1){
		    try{
			string = chunk.substring(0,g_index);
			jsonstring = JSON.parse(string);
			chunk = chunk.substring(g_index+1);
			console.log(chunk);
			string = '';
			g_index = 0;
		    }
		    catch(e){
			var string_temp = chunk.substring(g_index+1);
			d_index = string_temp.indexOf(';');
			g_index += d_index +1;
		    }
		}
		var Action = jsonstring; // successfually got the json Action;
	    });

    });


server.listen(8125);
console.log('server running');