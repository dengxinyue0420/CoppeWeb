//
//  LogInViewController.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTextField.h"

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet customTextField *emailField;
@property (weak, nonatomic) IBOutlet customTextField *pwdField;

    -(IBAction)signInPressed;
    -(IBAction)forgetPwdPressed;
    -(IBAction)signUpPressed;

@end
