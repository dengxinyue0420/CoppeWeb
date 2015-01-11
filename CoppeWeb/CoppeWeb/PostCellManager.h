//
//  CellManager.h
//  Ex
//
//  Created by Yicheng Wang on 1/9/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    Profile_Position_Offest = 5,
    Profile_frame = 30,
    Image_Name_Horizontal = 10,
    Image_Title_Vertical = 10,
    Title_Content_Vertical = 10,
    View_Width = 400,
    All_Offset = 30
} PostCellInfo;

@interface PostCellManager : NSObject

- (void)addName: (NSString *)name toCell: (UITableViewCell *)cell; // Add UserName

- (void)addTitle: (NSString *)Title toCell: (UITableViewCell *)cell; // Add Post Title （Note: This method should be called before addContent gets called.)

- (void)addContent: (NSString*)Content toCell: (UITableViewCell *)cell;  // Add Post Content

- (CGFloat)cellHeightWithTitle: (NSString *)Title andContent: (NSString *)Content; // Calculate the height needed for a cell

@end