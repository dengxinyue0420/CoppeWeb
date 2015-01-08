//
//  DemoTVC.m
//  AutoEx
//
//  Created by Yicheng Wang on 1/8/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "DemoTVC.h"

NSMutableArray *tabledata;

@implementation DemoTVC


-(void)viewDidLoad{
    [super viewDidLoad];
    tabledata = [[NSMutableArray alloc]init];
    for(int n = 1; n<20; n++){
        [tabledata addObject:[NSString stringWithFormat:@"%d",n]];
        NSLog(@"%@",tabledata);
    }
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spin startAnimating];
    spin.frame = CGRectMake(0, 0, 200, 60);
    self.table.tableFooterView = spin;
    [self.table reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tabledata count];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test1" forIndexPath:indexPath];
    cell.textLabel.text = tabledata[indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if (maximumOffset - currentOffset <= -30.0) {
        [self loadmoredata];
    }
}

-(void)loadmoredata{
    NSLog(@"here");
    for (int n = 0; n < 10; n++){
        [tabledata addObject:[NSString stringWithFormat:@"%d",n]];
    }
    [self.table reloadData];
}



@end
