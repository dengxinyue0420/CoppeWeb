//
//  PostTVCell.m
//  PostCellStuff
//
//  Created by Yicheng Wang on 1/12/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "PostTVCell.h"


UIButton *imagebutton;
UIButton *layerbutton;
UILabel *titlelabel;
NSString *Title_Font = @"HelveticaNeue-CondensedBold";

@implementation PostTVCell

#pragma mark - Initializations

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.All_Screen_Width = [[UIScreen mainScreen]bounds].size.width;
    [self initLayerButtonWithColor:UIColorFromRGB(0xC98282)];
    [self initImageButtonWithImage:[UIImage imageNamed:@"dsa.jpg"]];
    [self addTitle:@"Build a chat app"];
    [self addUnderLineToNameLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


- (void)initWithImage:(UIImage *)image Name:(NSString *)Name Title:(NSString *)Title{
    
}

- (void)initLayerButtonWithColor:(UIColor *)color{ // init layer button
    layerbutton = [[UIButton alloc]initWithFrame:CGRectMake(Layer_Horizontal_Offset, Layer_Space_Offset, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset, 200-Layer_Space_Offset-Layer_Space_Offset)];
    layerbutton.backgroundColor = color;
    layerbutton.layer.cornerRadius = 10.0f;
    layerbutton.userInteractionEnabled = YES;
//    layerbutton.showsTouchWhenHighlighted = YES;
    [layerbutton addTarget:self
                    action:@selector(layerButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:layerbutton];
}

- (void)initImageButtonWithImage:(UIImage *)im{ // init image button
    imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(Image_Frame_Offset, Image_Frame_Offset, Image_Frame, Image_Frame)];
    CALayer *layer = imagebutton.layer;
    [layer setCornerRadius:imagebutton.frame.size.width/2];
    [layer setMasksToBounds:YES];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Image_Frame, Image_Frame)];
    image.image = im;
    [imagebutton addSubview:image];
    [imagebutton addTarget:self
                    action:@selector(imageButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [layerbutton addSubview:imagebutton];
}

- (void)addTitle:(NSString *)Title{ // add a title to the post
    titlelabel = [[UILabel alloc]init];
    titlelabel.font = [UIFont fontWithName:Title_Font size:20.0f];
    titlelabel.numberOfLines = 1;
    titlelabel.text = Title;
    titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [titlelabel textRectForBounds:CGRectMake(0, 0, self.All_Screen_Width-Layer_Horizontal_Offset-Image_Frame-Image_Title_Offset-Image_Frame_Offset-Layer_Horizontal_Offset, CGFLOAT_MAX) limitedToNumberOfLines:1];
    titlelabel.frame = CGRectMake(Layer_Horizontal_Offset+Image_Frame_Offset+Image_Frame+Image_Title_Offset, Layer_Space_Offset, labelsize.size.width, labelsize.size.height);
    [layerbutton addSubview:titlelabel];
}

#pragma mark - Actions and Segue.

- (void)layerButtonTapped:(UIButton *)buttontapped{ // layer tapped action
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    sprintAnimation.springBounciness = 20.f;
    [buttontapped pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
}

- (void)imageButtonTapped:(UIButton *)buttontapped{ // image tapped action
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    sprintAnimation.springBounciness = 20.f;
    [buttontapped pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
}

#pragma mark - Other tools.

- (void)addUnderLineToNameLabel{
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, titlelabel.frame.size.height-1, titlelabel.frame.size.width, 1)];
    underline.backgroundColor = [UIColor blackColor];
    [titlelabel addSubview:underline];
}






@end
