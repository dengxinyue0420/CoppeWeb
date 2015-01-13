//
//  PostViewController.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 1/10/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "PostViewController.h"
#import "AppDelegate.h"
#import "MyPostInfo.h"
#import "NSDate+TimeTools.h"
#import "PostInfo.h"

@interface PostViewController ()

@property NSArray *posts;
@property UIRefreshControl *refreshControl;

@end

@implementation PostViewController

@synthesize managedObjectContext;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchNewPost];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:self.refreshControl];
//    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"no_more_post"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"fetch_data_completed"
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)unwindToPost:(UIStoryboardSegue *)segue{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (PostTVCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTVCell *cell = [table dequeueReusableCellWithIdentifier:@"postCell"];
    [cell initwithColor:UIColorFromRGB(0xf6dbde)
                  Image:[UIImage imageNamed:@"dsa.jpg"]
                  Title:@"Build a chat app"
                   Name:@"YichengWang"
                   Date:@"2014/11/12"
                Content:@"hey everyone, I want to build a chat app that I can use to hook up with girls, especially Eapha and Hailie. So I need a way to Locate them. Who want to develop this app with me? Note: I have some surprise for you. Oh Yeah I think tHIS IS A GREAt idea. test test test test test test."
                   read:@"10000"
                   like:@"10000"
                comment:@"10000"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PostTVCell HeightForCellWithContent:@"hey everyone, I want to build a chat app that I can use to hook up with girls, especially Eapha and Hailie. So I need a way to Locate them. Who want to develop this app with me? Note: I have some surprise for you. Oh Yeah I think tHIS IS A GREAt idea. test test test test test test." andTitle:@"Build a chat app"];
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

-(void) fetchFromCoreData{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PostInfo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.posts = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(void) receivedNotification:(NSNotification*) notification{
    if([[notification name]isEqualToString:@"fetch_data_completed"]){
        NSLog(@"received notification");
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"PostInfo"
                                                  inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        self.posts = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        NSLog(@"%d",[self.posts count]);
        [self.tableView reloadData];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];

    }
}
-(void) refreshData:(UIRefreshControl *) refresh{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [self fetchNewPost];
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
