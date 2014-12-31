var net = require('net');

var client = net.connect(8124);

var json = {
    "Target Action":"Add Post",
    "PostName":"heyheyhey",
    "UserName":"yicheng",
    "School":"vu",
    "TagSet":["vu","mit"],
    "Content":"lalalalalhehehehehe",
    "FollowCount":"0",
    "VisitCount":"1",
    "CreateDate":"201412301815"
};

var reqmsg = JSON.stringify(json);
client.write(reqmsg);