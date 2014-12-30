//
//  PostTableViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/28/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "PostTableViewController.h"
#import "AppDelegate.h"
#import "MyPostInfo.h"
#import "NSDate+TimeTools.h"


@interface PostTableViewController ()

@property NSArray *myPost;

@end

@implementation PostTableViewController

@synthesize managedObjectContext;
@synthesize myPost;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchNewPost];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyPostInfo" inManagedObjectContext:managedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    self.myPost = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.myPost count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    MyPostInfo *info = [self.myPost objectAtIndex:indexPath.row];
    cell.textLabel.text = info.title;
    return cell;
}

- (NSString*) getLastweek:(NSDate*) currentTime{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:-7];
    NSDate *lastWeek = [cal dateByAddingComponents:comps toDate:currentTime options:0];
    return [NSDate GMTString:lastWeek];
}

-(void) fetchNewPost{
    NSDate *currentDate = [NSDate date];
    NSString *currentTime = [NSDate GMTString:currentDate];
    NSString *lastWeek = [self getLastweek:currentDate];
    NSString *msg = [NSString stringWithFormat:@"{\"Target Action\":\"Pull Posts\",\"AttributeName\":\"All\",\"SortingMethod\":\"CreateDate\",\"Interval\":\"[%@,%@]\"}",lastWeek,currentTime];
    NSData *data = [[NSData alloc]initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputstream write:[data bytes] maxLength:[data length]];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end