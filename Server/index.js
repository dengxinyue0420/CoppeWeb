//CoppeWeb Main Server
//Created by Yicheng Wang on Whatever Date (Maybe 12/19/2014?)
//Copyright (c) 2014 Yicheng Wang. All rights reserved.
// =========================================================



//set up pkgs and pres.
var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var dynamodb = new AWS.DynamoDB();
var net = require('net');
var server = net.createServer();

//set up sockets.
server.on('connection',function(socket){
	console.log('get connection.');
	socket.on('end',function(){
		console.log('lose one connection');
	    });
	socket.on('data',function(data){
		console.log(data.toString());
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
			    if(err){
				console.log(err,err.stack);
				var backjson = {
				    "BackMsg":"SugnUpRes",
				    "Result":"server false"
				};
				var backmsg = JSON.stringify(backjson);
				socket.write(backmsg);
			    }
			    else{
				if(!isEmpty(data)){ //Signup failed.
				    var backjson = {
					"BackMsg":"SignUpRes",
					"Result":"username false"
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
					    if(err){
						console.log(err, err.stack);
						var backjson= {
						    "BackMsg":"SugnUpRes",
						    "Result":"server false"
						};
						var backmsg = JSON.stringify(backjson);
						socket.write(backmsg);
					    }
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
			    if(err){
				console.log(err, err.stack);
				var backjson= {
				    "BackMsg":"LogInRes",
				    "Result":"server false"
                                };
                                var backmsg = JSON.stringify(backjson);
                                socket.write(backmsg);
			    }
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
		    
		}// end log
		if(Action['Target Action'] == 'ForgetPwd'){ // User Forgets Password.
		    
		}// end ForgetPwd Action.
		if(Action['Target Action'] == 'Pull Posts'){ //Fetch posts.
		    if(Action['AttributeName'] == 'All'){ //fetch all
			if(Action['SortingMethod'] == 'CreateDate'){ //date sorted in all
			    var intervalarray = JSON.parse(Action['Interval']);
			    var begintime = intervalarray[0].toString();
			    var endtime = intervalarray[1].toString();
			    var item = {
				'TableName':'Post',
				'ScanFilter': {
				    'CreateDate':{
					'ComparisonOperator':'BETWEEN',
					'AttributeValueList':[{'N':begintime},{'N':endtime}]
				    }
				}
			    };
			    dynamodb.scan(item,function(err,data){
				    if(err) {
					console.log(err,err.stack);
					
				    }
				    else{
					var backjson = {
					    "BackMsg":"Post",
					    "AttributeName":"All",
					    "BackPosts":data
					};
					var backmsg = JSON.stringify(backjson);
					socket.write(backmsg);
					console.log(backmsg);
				    }
				});
			} //end date sorted in all
			
		    } // end all
		    if(Action['Attribute Name'] == 'School'){// fetch post by School.
			if(Action['SortingMethod'] == 'CreateDate'){  //sort school post by date
			    var intervalarray = JSON.parse(Action['Interval']);
                            var begintime = intervalarray[0].toString();
                            var endtime = intervalarray[1].toString();
			    var item = {
				'KeyConditions':{
				    'School':{
					'ComparisonOperator':'EQ',
					'AttributeValueList':[{'S':'vu'}]
				    },
				    'CreateDate':{
					'ComparisonOperator':'BETWEEN',
					'AttributeValueList':[{'N':begintime},{'N':endtime}]
				    }
				},
				'IndexName':'School-CreateDate-index',
				'TableName':'Post',
			    };
			    dynamodb.query(item,function(err,data){
				    if(err) console.log(err,err.stack);
				    else {
					var backjson = {
					    'BackMsg':'Post',
					    'AttributeName':'School',
					    'BackPosts':data
					};
					var backmsg = JSON.stringify(backjson);
					socket.write(backmsg);
					console.log(backmsg);
				    }
				});
			} //end sort school post by date			   
			
		    } //end fetch post by school.
		}// end fetch post
		if(Action['Target Action'] == 'Add Post'){ // add post.
		    var item = {
			'TableName':'Post',
			'Item':{
			    'PostID':{'N':idgen().toString()},
			    'PostName':{'S':Action['PostName']},
			    'UserName':{'S':Action['UserName']},
			    'School':{'S':Action['School']},
			    'TagSet':{'SS':Action['TagSet']},
			    'Content':{'S':Action['Content']},
			    'FollowCount':{'N':'0'},
			    'VisitCount':{'N':'1'},
			    'CreateDate':{'N':Action['CreateDate']}
			}
		    };
		    dynamodb.putItem(item,function(err,data){
			    if(err) {
				console.log(err, err.stack);
				var backjson = {
				    "BackMsg":"AddPostRes",
				    "Result":"failed"
				};
				var backmsg = JSON.stringify(backjson);
				socket.write(backmsg);
			    }
			    else{
				console.log('update successfully.');
				var backjson = {
                                    "BackMsg":"AddPostRes",
                                    "Result":"successful"
                                };
				var backmsg = JSON.stringify(backjson);
                                socket.write(backmsg);
			    }
			});
		} // end add post
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