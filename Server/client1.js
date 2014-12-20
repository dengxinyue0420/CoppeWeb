var net = require('net');



var client = net.connect({port:8124},function(){
	rl.on('line',function(line){
		client.write(line);
	    });
    });

var readline = require('readline');

var rl = readline.createInterface({
    input:process.stdin,
    output:process.stdout
    });

client.on('data',function(data){
	var inputmsg = data.toString();
	if(inputmsg == 'database password'){
	    console.log('send msg to database instead.');
	}
	else{
	    console.log(inputmsg);
	}
    });

