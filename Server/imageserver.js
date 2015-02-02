//CoppeWeb Image Server
//Created by Yicheng Wang on 01/16/2015
//Copyright (c) 2015 Yicheng Wang. All rights reserved.
// ===================================================




//set up pkgs and pres.
var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var s3 = new AWS.S3();
var dynamodb = new AWS.DynamoDB();
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
		if(Action['Target Action'] == 'AddImage'){ // add image action.
		    if(Action['ImageInfo']['usage'] == 'profile'){ // add profile images.
			if(Action['ImageInfo']['size'] == 'large'){ // add large profile image.
			    var ID = idgen();
			    var dbjson = {
				'TableName':'Limage',
				'Item':{
				    'ID':{'N':ID},
				    'usage':{'S':'profile'},
				    'SecID':{'S':Action['ImageInfo']['ID']},
				    'URL':{'S':util.format('ProfileImage_Large/%d',ID)}
				}
			    };
			    dynamodb.putItem(dbjson,function(err,err.stack){
				    if(err){
					console.log(err.stack);
				    }
				    else 
				    {
					console.log('upload successfully.');
				    }
				});
			} // end add large profile.
			if(Action['ImageInfo']['size'] == 'small'){ // add small profile image

			} // end add small profile.
		    } // end add profile image
		    if(Action['ImageInfo']['usage'] == 'post'){ // add post images.
			if(Action['ImageInfo']['size'] == 'large'){ // add large post images.

			} // end add large post images
			if(Action['ImageInfo']['size'] == 'small'){ // add small post images.

			} // end add small post images
		    }// end add post images

		} // end add image action.
	    });

    });


server.listen(8125);
console.log('server running');

//Other Functions                                                                                                                           

    function isEmpty(obj) { //Check if Object is empty.                                                                                         
	return !Object.keys(obj).length;
    }

    function idgen (){ //Generate Unique IDs.                                                                                                   
	var FlakeIdGen = require('flake-idgen')
	    , intformat = require('biguint-format')
	    , generator = new FlakeIdGen;
	return intformat( generator.next(),'dec');
    }