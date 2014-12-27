Action Headers:

//Actions sent to Server.
SignUpAction: {
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

LogInAction: {
    "Target Action":"Log In",
	"UserName":UserName,
	"PassWord":PassWord
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