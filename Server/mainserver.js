//CoppeWeb Main Server
//Created by Yicheng Wang on Mar/30/2015
//Copyright (c) 2014 Yicheng Wang. All rights reserved.
//=================================================== 


//set up database and pkgs.
var bodyParser = require('body-parser');
var app = require('express')();
var multer = require('multer');

var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var dynamodb = new AWS.DynamoDB();

//config app
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(multer());


//working part
app.post('/',function(req,res){ //get requests
	var Action = req.body;
	console.log(Action);
	//Sign Up Action
	//Login Action
	if(Action['Target Action'] == 'Log In'){
	    var UserAnthItem = {
		'TableName':'Anth_Table',
		'Key':{
		    'UserName':{'S':Action['UserName']}
		}
	    };
	    dynamodb.getItem(UserAnthItem,function(err,data){
		    if(err){//Server Failed
			console.log(err, err.stack);
			var backjson = {
			    "BackMsg":"LogInRes",
			    "Result":"server false"
			};
			var backmsg = JSON.stringify(backjson);
			res.write(backmsg);
			res.end();
		    }
		    else{
			if(isEmpty(data)){//Login Failed(no such username exsits)
			    var backjson = {
				"BackMsg":"LogInRes",
				"Result":"false"
			    };
			    var backmsg = JSON.stringify(backjson);
			    console.log('false.');
			    res.write(backmsg);
			    res.end();
			}
			else{
			    if(Action['PassWord'] == data['Item']['PassWord']['S']){//Login successfully
				var backjson = {
				    "BackMsg":"LogInRes",
				    "Result":"true"
				};
				var backmsg = JSON.stringify(backjson);
				console.log('true');
				res.write(backmsg);
				res.end();
			    }
			    else{ //Login Failed(password not right)
				var backjson = {
				    "BackMsg":"LogInRes",
				    "Result":"false"
				};
				var backmsg = JSON.stringify(backjson);
				res.wrtie(backmsg);
				res.end();
			    }
			}
		    }
		});
	}// end login in

    });


app.listen(3000);
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





