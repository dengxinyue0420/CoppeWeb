//
//  SignUpViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/27/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize emailField;
@synthesize pwdField;
@synthesize confirmPwdField;
@synthesize alert;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pwdField.secureTextEntry = YES;
    self.confirmPwdField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUp {
    NSString *email = emailField.text;
    NSString *pwd = pwdField.text;
    NSString *confirmPwd = confirmPwdField.text;
    
    if([self checkPwd:pwd confirm:confirmPwd]){
        NSString *msg = [NSString stringWithFormat:@"{\"Target Action\":\"Sign Up\",\"UserName\":\"%@\",\"PassWord\":\"%@\"}",email,pwd];
        NSData *data = [[NSData alloc]initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
        [outputstream write:[data bytes] maxLength:[data length]];
        self.emailField.text = @"";
        self.pwdField.text = @"";
        self.confirmPwdField.text = @"";
    }else{
        alert.text = @"password doesn't match";
    }
}

- (BOOL) checkPwd:(NSString*) pwd confirm:(NSString*) confirmPwd {
    if ([pwd isEqualToString:confirmPwd]){
        return YES;
    }else{
        return NO;
    }
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
