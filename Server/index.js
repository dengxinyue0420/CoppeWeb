//CoppeWeb Main Server
//Created by Yicheng Wang on Whatever Date (Maybe 12/19/2014?)
//Copyright (c) 2014 Yicheng Wang. All rights reserved.


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
	socket.on('end',function(){
		console.log('lose one connection');
	    });
	socket.on('data',function(data){
		var Action = JSON.parse(data.toString());
		console.log(Action);
		//Sign up Action
		if(Action['Target Action'] == 'Sign Up'){ //Check if UserName already exist
		    var UserAnthCheck = {
			'TableName':'Anth_Table',
			'Key':{
			    'UserName':{'S':Action['UserName']}
			}
		    };
		    dynamodb.getItem(UserAnthCheck,function(err,data){
			    if(err) console.log(err,err.stack);
			    else{
				if(!isEmpty(data)) console.log('Already exist');
				else{
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
				}
			    }
			});
/*
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
			});  */
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
				if(isEmpty(data)){
				    console.log('false.');
				    socket.write('false');
				}
				else {
				    if(Action['PassWord']==data['Item']['PassWord']['S']){
					console.log('true');
					socket.write('true');
				    }
				    else{
					console.log('false');
					socket.write('false');
				    }
				}
				
			    }
		    
			});
		    
		}
	    });
	

    });

server.listen(8124);
console.log('Server Working.');

//Other Functions

function isEmpty(obj) {
    return !Object.keys(obj).length;
}