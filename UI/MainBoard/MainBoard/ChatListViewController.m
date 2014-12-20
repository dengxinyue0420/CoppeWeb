//
//  ChatListViewController.m
//  MainBoard
//
//  Created by Yicheng Wang on 12/19/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *ChatTable;

@end

@implementation ChatListViewController

#pragma mark - ViewLoade

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChatTable.delegate = self;
    self.ChatTable.dataSource = self;
}

#pragma mark - UITableView Implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    cell.textLabel.text = @"experiment";
    return cell;
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
