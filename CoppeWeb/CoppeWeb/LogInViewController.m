//
//  LogInViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "LogInViewController.h"
#import "customTextField.h"
#import "SocketHandler.h"
#import "PostViewController.h"

@interface LogInViewController ()


@end

@implementation LogInViewController

@synthesize emailField;
@synthesize pwdField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pwdField.secureTextEntry = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"login_success"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"login_fail"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed {
    NSLog(@"sign in");
    NSString *email = self.emailField.text;
    NSString *pwd = self.pwdField.text;
    NSString *msg = [NSString stringWithFormat:@"{\"Target Action\":\"Log In\",\"UserName\":\"%@\",\"PassWord\":\"%@\"};",email,pwd];
    NSData *data = [[NSData alloc]initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputstream write:[data bytes] maxLength:[data length]];
}

-(IBAction)forgetPwdPressed {
    NSLog(@"forget pwd");
}

-(IBAction)signUpPressed{
    NSLog(@"sign up");
}
-(void) receivedNotification:(NSNotification*) notification{
    if([[notification name]isEqualToString:@"login_success"]){
        [self performSegueWithIdentifier:@"showPost" sender:self];
        
    }else if([[notification name]isEqualToString:@"login_fail"]){
        self.emailField.text = @"";
        self.pwdField.text = @"";
        NSLog(@"login fail");
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier]isEqualToString:@"showPost"]){
        UITabBarController *tabBarController = [segue destinationViewController];
        UINavigationController *navigationController = [tabBarController.viewControllers objectAtIndex:0];
        PostViewController *postController = (PostViewController*)navigationController.topViewController;
        postController.managedObjectContext = self.managedObjectContext;
    }
}


@end
