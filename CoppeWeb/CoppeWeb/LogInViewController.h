//
//  LogInViewController.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTextField.h"

@interface LogInViewController : UIViewController <NSStreamDelegate>
@property IBOutlet customTextField *emailField;
@property IBOutlet customTextField *pwdField;
@property NSManagedObjectContext *managedObjectContext;
//@property NSInputStream *inputstream;
//@property NSOutputStream *outputstream;

    -(IBAction)signInPressed;
    -(IBAction)forgetPwdPressed;
    -(IBAction)signUpPressed;

@end
