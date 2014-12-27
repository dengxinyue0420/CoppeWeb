//
//  LogInViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "LogInViewController.h"
#import "customTextField.h"
#import "AppDelegate.h"

@interface LogInViewController ()


@end

@implementation LogInViewController

@synthesize emailField;
@synthesize pwdField;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initNetworkConnection];
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
    NSString *msg = [NSString stringWithFormat:@"{\"Target Action\":\"Log In\",\"UserName\":\"%@\",\"PassWord\":\"%@\"}",email,pwd];
    NSData *data = [[NSData alloc]initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputstream write:[data bytes] maxLength:[data length]];
    self.emailField.text = @"";
    self.pwdField.text = @"";
}

-(IBAction)forgetPwdPressed {
    NSLog(@"forget pwd");
}

-(IBAction)signUpPressed{
    NSLog(@"sign up");
}
//-(void)initNetworkConnection{
//    CFReadStreamRef readStream;
//    CFWriteStreamRef writeStream;
//    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 8124, &readStream, &writeStream);
//    inputstream = (__bridge NSInputStream *)readStream;
//    outputstream = (__bridge NSOutputStream *)writeStream;
//    [inputstream setDelegate:self];
//    [outputstream setDelegate:self];
//    [inputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [outputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [inputstream open];
//    [outputstream open];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
