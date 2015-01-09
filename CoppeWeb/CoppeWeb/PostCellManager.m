//
//  PostCellManager.m
//  Ex
//
//  Created by Yicheng Wang on 1/9/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "PostCellManager.h"

float TitleHeight;

@implementation PostCellManager



- (void)addName:(NSString *)name toCell:(UITableViewCell *)cell{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:11.0f];
    label.text = name;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [label textRectForBounds:CGRectMake(0, 0, View_Width-Profile_Position_Offest-Profile_frame-Image_Name_Horizontal, CGFLOAT_MAX)
                          limitedToNumberOfLines:1];
    label.frame = CGRectMake(Profile_Position_Offest+Profile_frame+Image_Name_Horizontal, 0, labelsize.size.width, labelsize.size.height);
    [cell addSubview:label];
}


- (void)addTitle:(NSString *)Title toCell:(UITableViewCell *)cell{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.text = Title;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [label textRectForBounds:CGRectMake(0, 0, View_Width-Profile_Position_Offest, CGFLOAT_MAX) limitedToNumberOfLines:1];
    label.frame = CGRectMake(Profile_Position_Offest, Profile_Position_Offest+Profile_frame+Image_Title_Vertical, labelsize.size.width,labelsize.size.height);
    [cell addSubview:label];
    TitleHeight = labelsize.size.height;
}

- (void)addContent:(NSString *)Content toCell:(UITableViewCell *)cell{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.text = Content;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [label textRectForBounds:CGRectMake(0, 0, View_Width-Profile_Position_Offest, CGFLOAT_MAX) limitedToNumberOfLines:9999];
    label.frame = CGRectMake(Profile_Position_Offest, Profile_Position_Offest+Profile_frame+Image_Title_Vertical+Title_Content_Vertical+TitleHeight, labelsize.size.width,labelsize.size.height);
    [cell addSubview:label];
}

- (CGFloat)cellHeightWithTitle: (NSString *)Title andContent: (NSString *)Content{
    UILabel *title = [[UILabel alloc]init];
    title.font = [UIFont systemFontOfSize:20.0f];
    title.text = Title;
    title.numberOfLines = 0;
    title.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect titlesize = [title textRectForBounds:CGRectMake(0, 0, View_Width-Profile_Position_Offest, CGFLOAT_MAX) limitedToNumberOfLines:1];
    UILabel *content = [[UILabel alloc]init];
    content.font = [UIFont systemFontOfSize:13.0f];
    content.text = Content;
    content.numberOfLines = 0;
    content.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect contentsize = [content textRectForBounds:CGRectMake(0, 0, View_Width-Profile_Position_Offest, CGFLOAT_MAX) limitedToNumberOfLines:9999];
    return contentsize.size.height+titlesize.size.height+Profile_Position_Offest+Profile_frame+Image_Title_Vertical+Title_Content_Vertical+All_Offset;
}


@end
