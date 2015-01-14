//
//  PostTVCell.h
//  CoppeWeb
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
    ALL_HEIGHT = 87,
    Layer_Horizontal_Offset = 20,
    Layer_Space_Offset = 5,
    Image_Frame = 40,
    Image_Frame_Offset = 10,
    Image_Title_Offset = 5,
    Image_Name_Offeset = 5,
    Title_Name_Offset = 1,
    Title_Name_For_Center_Offset = 3,
    Title_Max_Frame = 180,
    Time_Frame_Offset = 5,
    Date_Frame_Offset = 5,
    Date_Title_Offset = 25,
    Content_Name_Offset = 5,
    Content_Buttom_Offset = 15,
    Line_Buttom_Offset = 3,
    Interest_Max_Frame = 30,
    LikeNum_Max_Frame = 50,
    Read_Max_Frame = 30,
    Comment_Max_Frame = 60,
    Comment_Offset = 15,
    Num_Element_Offset = 2,
    Buttom_Offset = 20
} CellInfo;



@interface PostTVCell : UITableViewCell

@property (nonatomic)CGFloat All_Screen_Width;

- (void)initwithColor:(UIColor *)color Image:(UIImage *)image Title:(NSString *)title Name:(NSString *)name Date:(NSString *)date Content:(NSString *)content read:(NSString *)read like:(NSString *)like comment:(NSString *)comment;

+ (CGFloat)HeightForCellWithContent:(NSString *)content andTitle:(NSString *)title;



@end
