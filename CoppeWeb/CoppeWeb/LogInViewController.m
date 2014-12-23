//
//  LogInViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "LogInViewController.h"
#import "customTextField.h"

@interface LogInViewController ()


@end

@implementation LogInViewController

@synthesize emailField;
@synthesize pwdField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pwdField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed {
    NSLog(@"sign in");
    NSString *email = self.emailField.text;
    NSString *pwd = self.pwdField.text;
    NSLog(@"email:%@,pwd:%@",email,pwd);
    //TO-DO: send email and pwd to server.
}

-(IBAction)forgetPwdPressed {
    NSLog(@"forget pwd");
}

-(IBAction)signUpPressed{
    NSLog(@"sign up");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
