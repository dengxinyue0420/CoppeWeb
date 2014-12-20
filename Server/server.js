var net = require('net');
var array = [];
var name = 0;
var server = net.createServer(function(c) { //'connection' listener
	c.no = name;
	name ++;
	array.push(c);
	console.log('server connected.');
	for(var i = 0; i<array.length; i++){
	    var conn = array[i];
	    console.log(conn.no);
	}
	c.on('data',function(data){
		c.write(data);
		console.log(array);
	    });
	c.on('end', function() {
		console.log('server disconnected');
	    });

    });
server.listen(8124, function() { //'listening' listener
	console.log('server bound');
    });