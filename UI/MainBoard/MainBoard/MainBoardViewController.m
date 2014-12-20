//
//  MainBoardViewController.m
//  MainBoard
//
//  Created by Yicheng Wang on 12/19/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "MainBoardViewController.h"

@interface MainBoardViewController ()

@end

@implementation MainBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"try";
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
    [array addObject:vc1];
    self.tabBarController.viewControllers = array;
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
