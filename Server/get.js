var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});
var dynamodb = new AWS.DynamoDB();
var net = require('net');
var server = net.createServer();

var item = {
    'TableName':'Post'
};


server.listen(8124,function(){
	dynamodb.query(item,function(err,data){
		if (err) console.log(err,err.stack);
		else console.log(data);
	    });
    });