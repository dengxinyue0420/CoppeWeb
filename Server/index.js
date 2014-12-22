//set up pkgs and pres.
var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var dynamodb = new AWS.DynamoDB();
var net = require('net');
var server = net.createServer();
var OnlineSocket = [];

//set up sockets.
server.on('connection',function(socket){
	console.log('get connection.');
	socket.on('data',function(data){
		var Action = JSON.parse(data.toString());
		if(Action['Target Action'] == 'Sign Up'){
		    //set up Anth_Table here.
		    var UserInfo = {
			'TableName':'Anth_Table',
			'Item':{
			    'UserName':{'S':Action['UserName']},
			    'PassWord':{'S':Action['PassWord']}
			}
		    };
		    dynamodb.putItem(UserInfo,function(err,data){
			    if(err) console.log(err, err.stack);
			    else{
				console.log('Update Successfully.');
			    }
			});
		    //set up All_User_Table here.
		    
		}
		if(Action['Target Action'] == 'Log In'){
		    
		}
	    });
	

    });

server.listen(8124);
console.log('Server Working.');