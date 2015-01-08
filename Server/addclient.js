var net = require('net');

var client = net.connect(8124);

var json = {
    "Target Action":"Add Post",
    "PostName":"sisth post",
    "UserName":"yicheng",
    "School":"vu",
    "TagSet":["vu","mit"],
    "Content":"this is the sixth",
    "FollowCount":"0",
    "VisitCount":"1",
    "CreateDate":"201501030720"
};

var reqmsg = JSON.stringify(json);
client.write(reqmsg);