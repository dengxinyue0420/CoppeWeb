Action Headers:

//Actions sent to Server.
SignUpAction: { //Sign Up
    "Target Action":"Sign Up",
	"UserName":...,
	"NickName":...,
	"FirstName":...,
	"LastName":...,
	"DateOfBirth":...,
	"Gender":...,
	"ProfImage":...,
	"School":...,
	"SelfDes":...,
	"CreateDate":...
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
	"SortingMethod":[CreateDate, VisitCount]
	"Interval":[begin,end]
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