//
//  PostTableViewController.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/28/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTVcell.h"

@interface PostTableViewController : UITableViewController

@property NSManagedObjectContext *managedObjectContext;

-(IBAction)unwindToPost:(UIStoryboardSegue*) segue;

@end
