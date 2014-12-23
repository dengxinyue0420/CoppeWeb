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
		//Sign up Action
		if(Action['Target Action'] == 'Sign Up'){
		    //set up Anth_Table here.
		    var UserAnth = {
			'TableName':'Anth_Table',
			'Item':{
			    'UserName':{'S':Action['UserName']},
			    'PassWord':{'S':Action['PassWord']}
			}
		    };
		    dynamodb.putItem(UserAnth,function(err,data){
			    if(err) console.log(err, err.stack);
			    else{
				console.log('Update Successfully.');
			    }
			});
		    //set up All_User_Table here.
		    var UserInfo = {
			'TableName':'All_User_Table',
			'Item':{
			    'UserName':{'S':Action['UserName']},
			    'FirstName':{'S':Action['FirstName']},
			    'Lastname':{'S':Action['LastName']},
			    'DOB':{'S':Action['DOB']},
			    'Gender':{'N':Action['Gender']},
			    'YearOfClass':{'S':Action['Gender']},
			    'University':{'S':Action['University']},
			    'Major':{'S':Action['Major']}
			}

		    };
		    dynamodb.putItem(UserInfo,function(err,data){
			    if(err) console.log(err, err.stack);
			    else{
				console.log('Update Successfully.');
			    }
			});
		}
		//Log In Action
		if(Action['Target Action'] == 'Log In'){
		    var UserAnthItem = {
			'TableName':'Anth_Table',
			'Key':{
			    'UserName':{'S':Action['UserName']}
			}
		    };
		    dynamodb.getItem(UserAnthItem,function(err,data){
			    if(err) console.log(err, err.stack);
			    else {
				console.log(data);
			    }
		    
			});
		    
		}
	    });
	

    });

server.listen(8124);
console.log('Server Working.');