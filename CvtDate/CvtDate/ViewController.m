//
//  ViewController.m
//  CvtDate
//
//  Created by Yicheng Wang on 12/30/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date = [[NSDate alloc]init];
    NSLog(@"%@\n%tu",[date LocalDate],[date TimeDifference]);
    NSLog(@"%@",[date GMTString]);
    NSLog(@"%@",[date TimeArrayFromTimeString:[NSString stringWithFormat:@"201412300611"]]);
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
