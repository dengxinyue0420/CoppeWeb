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
    ALL_HEIGHT = 101,
    Layer_Horizontal_Offset = 20,
    Layer_Space_Offset = 10,
    Image_Frame = 40,
    Image_Frame_Offset = 18,
    Image_Title_Offset = 12,
    Image_Name_Offeset = 12,
    Title_Top_Offset = 3,
    Title_Name_Offset = 1,
    Title_Name_For_Center_Offset = 3,
    Title_Max_Frame = 180,
    Time_Frame_Offset = 5,
    Date_Frame_Offset = 15,
    Date_Title_Offset = 18,
    Content_Name_Offset = -3,
    Content_Frame_Offset = 25,
    Content_Image_Offset = -4,
    Content_Buttom_Offset = 15, // actually Image_Button_Offset.
    ButtomImages_Frame = 90,
    Buttom_Images_Between = 5,
    ButtomImages_More_Offset = 9,
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
//////////////////////////////////////////////
@property (nonatomic,strong)UIButton *layerbutton;
@property (nonatomic,strong)UIButton *imagebutton;
@property (nonatomic,strong)UILabel *titlelabel;
@property (nonatomic,strong)UILabel *namelabel;
@property (nonatomic,strong)UILabel *datelabel;
@property (nonatomic,strong)UILabel *contentlabel;
@property (nonatomic,strong)UILabel *interestlabel;
@property (nonatomic,strong)UILabel *likenum;
@property (nonatomic,strong)UILabel *readlabel;
@property (nonatomic,strong)UILabel *readnum;
@property (nonatomic,strong)UILabel *commentlabel;
@property (nonatomic,strong)UILabel *CommentNum;
@property (nonatomic,strong)UIImageView *image1;
@property (nonatomic,strong)UIImageView *image2;
@property (nonatomic,strong)UIImageView *image3;
@property (nonatomic,strong)UILabel *moreimagelabel;

- (void)initwithColor:(UIColor *)color Image:(UIImage *)image Title:(NSString *)title Name:(NSString *)name Date:(NSString *)date Content:(NSString *)content read:(NSString *)read like:(NSString *)like comment:(NSString *)comment ButtomImages:(NSArray *)imagearrary; // configure the cell with all these information.

+ (CGFloat)HeightForCellWithContent:(NSString *)content andTitle:(NSString *)title;


@end
