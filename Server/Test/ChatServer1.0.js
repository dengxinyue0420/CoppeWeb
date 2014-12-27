var net = require('net');

var server = net.createServer();

var sockets = [];

server.on('connection',function(socket){
	console.log('got connection.');
	socket.check = 0;
	socket.on('data',function(data){
		console.log(data.toString());
		if(socket.check==0){
		    console.log('record the user.');
		    socket.check++;
		    var userinfo = data.toString();
		    var arr = userinfo.split(':');
		    socket.name=arr[0];
		    socket.to=arr[1];
		    sockets.push(socket);

		}
		else{
		    var found = 0;
		    for (var i =0; i<sockets.length; i++){
			if(sockets[i].name == socket.to){
			    sockets[i].write(data);
			    found++;
			}
		    }
		    if(found == 0){
			socket.write('database password');
		    }
		}
	    });
    });


server.listen(8124);

console.log('server on');
