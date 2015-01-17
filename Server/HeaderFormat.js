Action Headers:

//Actions sent to Server.
SignUpAction: { //Sign Up
    "Target Action":"Sign Up",
	"UserName":...,
	"PassWord":....
	}

LogInAction: {  //LogIn
    "Target Action":"Log In",
	"UserName":UserName,
	"PassWord":PassWord
	}

PullPosts: {  // Pull post between index.
    "Target Action":"Pull Posts",
	"AttributeName":[All,UserName, TagSet,School],
	"Attribute":[Attribute-Set](if school, a string)(if all, no Attribute to be declared)
	"SortingMethod":[CreateDate, VisitCount]  (for username, this attribute could only be createdate)
	"Interval":[begin,end]  (for username, this attribute should contain all the timeline for this user)
}

AddPosts: { // add post (all string)
    "Target Action":"Add Post",
	"PostName":PostName,
	"UserName":UserName,
	"School":School,
	"TagSet":Set,(an array, but contain string)
	"Content":Content,
	"FollowCount":0,
	"VisitCount":1,
	"CreateDate":CreateDate
}



//Actions sent back to Clients.

SignUpAction: {
    "BackMsg":"SignUpRes",
	"Result":...("false","true")
}

LogInAction: {
    "BackMsg":"LogInRes",
	"Result":...("false","true")
}

PostBack: {
    "BackMsg":"Post",
	"AttributeName":AttributeName,
	"BackPosts":JSON
}

AddPostBack : {
    "BackMsg":"AddPostRes",
	"Result":"failed"|"successful"
}