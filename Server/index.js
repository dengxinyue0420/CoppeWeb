//CoppeWeb Main Server
//Created by Yicheng Wang on Whatever Date (Maybe 12/19/2014?)
//Copyright (c) 2014 Yicheng Wang. All rights reserved.
// ==========================================================



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
				if(!isEmpty(data)){ //Signup failed.
				    var backjson = {
					"BackMsg":"SignUpRes",
					"Result":"false"
				    };
				    var backmsg = JSON.stringify(backjson);
				    console.log('Already exist');
				    socket.write(backmsg);
				}
				else{  //Signup successful.
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
						var backjson = {
						    "BackMsg":"SignUpRes",
						    "Result":"true"
						};
						var backmsg = JSON.stringify(backjson);
						console.log('Update Successfully.');
						socket.write(backmsg);
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
				if(isEmpty(data)){ //Login failed
				    var backjson = {
					"BackMsg":"LogInRes",
					"Result":"false"
				    };
				    var backmsg = JSON.stringify(backjson);
				    console.log('false.');
				    socket.write(backmsg);
				}
				else { 
				    if(Action['PassWord']==data['Item']['PassWord']['S']){ //Login success.
					var backjson = {
					    "BackMsg":"LogInRes",
					    "Result":"true"
					};
					var backmsg = JSON.stringify(backjson)
					console.log('true');
					socket.write(backmsg);
				    }
				    else{ //Login failed
					var backjson = {
					    "BackMsg":"LogInRes",
					    "Result":"false"
					};
					var backmsg = JSON.stringify(backjson);
					console.log('false');
					socket.write(backmsg);
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

function isEmpty(obj) { //Check if Object is empty.
    return !Object.keys(obj).length;
}

function idgen (){ //Generate Unique IDs.
    var FlakeIdGen = require('flake-idgen')
        , intformat = require('biguint-format')
        , generator = new FlakeIdGen;
    return intformat( generator.next(),'dec');
}