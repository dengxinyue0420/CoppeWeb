//
//  DemoTVC.h
//  AutoEx
//
//  Created by Yicheng Wang on 1/8/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

