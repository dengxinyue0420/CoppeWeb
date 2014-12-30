//
//  SignUpViewController.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/27/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTextField.h"

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet customTextField *emailField;
@property (weak, nonatomic) IBOutlet customTextField *pwdField;

@property (weak, nonatomic) IBOutlet customTextField *confirmPwdField;
@property (weak, nonatomic) IBOutlet UILabel *alert;


-(IBAction)signUp;
-(BOOL) checkPwd:(NSString*) pwd confirm:(NSString*) confirmPwd;
-(void) receivedNotification:(NSNotification*) notification;
@end
