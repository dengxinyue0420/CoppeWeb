//
//  PostViewController.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 1/10/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTVcell.h"

@interface PostViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property NSManagedObjectContext *managedObjectContext;

-(IBAction)unwindToPost:(UIStoryboardSegue*) segue;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
