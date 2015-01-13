//
//  PostTVCell.h
//  PostCellStuff
//
//  Created by Yicheng Wang on 1/12/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pop/pop.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


typedef enum {
    Layer_Horizontal_Offset = 5,
    Layer_Space_Offset = 5,
    Image_Frame = 40,
    Image_Frame_Offset = 10,
    Image_Title_Offset = 5,
    Image_Name_Offeset = 5
} CellInfo;




@interface PostTVCell : UITableViewCell

@property (nonatomic)CGFloat All_Screen_Width;

- (void)initWithImage:(UIImage *)image Name:(NSString *)Name Title:(NSString *)Title;

- (void)initLayerButtonWithColor:(UIColor *)color;

- (void)initImageButtonWithImage:(UIImage *)im;

- (void)addTitle:(NSString *)Title;

- (void)addUnderLineToNameLabel;

@end
