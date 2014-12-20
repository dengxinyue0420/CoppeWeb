//
//  StartUpViewController.m
//  LaunchView
//
//  Created by Yicheng Wang on 12/17/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "StartUpViewController.h"

@interface StartUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIImageView *LogoImage;
@end


@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:0.49 green:0.78 blue:0.663 alpha:1.0];
    self.view.backgroundColor = color;
    self.LoginButton.backgroundColor = [UIColor colorWithRed:0.62 green:0.765 blue:0.71 alpha:0.6];
    UIImage *image = [UIImage imageNamed:@"coppe opt.png"];
    self.LogoImage.image = image;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"School5.jpg"]];
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
