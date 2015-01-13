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
UILabel *namelabel;
UILabel *datelabel;
UILabel *contentlabel;
UILabel *interestlabel;
UILabel *likenum;
UILabel *readlabel;
UILabel *readnum;
UILabel *commentlabel;
UILabel *CommentNum;

NSString *Title_Font = @"HelveticaNeue-CondensedBold";
NSString *Content_Font = @"Arial-BoldMT";
NSString *Buttom_Font =@"Arial-BoldMT";

CGFloat LayerHeight;

@implementation PostTVCell

#pragma mark - Initializations

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.All_Screen_Width = [[UIScreen mainScreen]bounds].size.width;
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.All_Screen_Width = [[UIScreen mainScreen]bounds].size.width;
    return self;
}



- (void)initwithColor:(UIColor *)color Image:(UIImage *)image Title:(NSString *)title Name:(NSString *)name Date:(NSString *)date Content:(NSString *)content read:(NSString *)read like:(NSString *)like comment:(NSString *)comment{
    LayerHeight = [PostTVCell HeightForCellWithContent:content andTitle:title];
    [self initLayerButtonWithColor:color];
    [self initImageButtonWithImage:image];
    [self addTitle:title];
    [self addName:name];
    [self addDate:date];
    [self addContent:content];
    [self addinterestlabel];
    [self addlikeNum:like];
    [self addread];
    [self addReadNum:read];
    [self addcommentlabel];
    [self addCommentNum:comment];
    [self addUnderLineToNameLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)initLayerButtonWithColor:(UIColor *)color{ // init layer button
    layerbutton = [[UIButton alloc]initWithFrame:CGRectMake(Layer_Horizontal_Offset, Layer_Space_Offset, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset, LayerHeight-Layer_Space_Offset-Layer_Space_Offset)];
    layerbutton.backgroundColor = color;
    layerbutton.layer.cornerRadius = 20.0f;
    layerbutton.userInteractionEnabled = YES;
    [layerbutton addTarget:self
                    action:@selector(layerButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:layerbutton];
}

- (void)initImageButtonWithImage:(UIImage *)im{ // init image button
    imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(Image_Frame_Offset, Image_Frame_Offset, Image_Frame, Image_Frame)];
    CALayer *layer = imagebutton.layer;
    [layer setCornerRadius:Image_Frame/2];
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
    titlelabel.numberOfLines = 0;
    titlelabel.text = Title;
    titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [titlelabel textRectForBounds:CGRectMake(0, 0, Title_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:2];
    titlelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Title_Offset, Image_Frame_Offset-Title_Name_For_Center_Offset, labelsize.size.width, labelsize.size.height);
    [layerbutton addSubview:titlelabel];
}

- (void)addName:(NSString *)Name{ // add a name to the post.
    namelabel = [[UILabel alloc]init];
    namelabel.font = [UIFont systemFontOfSize:12.0f];
    namelabel.numberOfLines = 1;
    namelabel.text = [NSString stringWithFormat:@"From %@",Name];
    namelabel.textColor = UIColorFromRGB(0x898989);
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect namesize = [namelabel textRectForBounds:CGRectMake(0, 0, (self.All_Screen_Width-Layer_Horizontal_Offset-Image_Frame-Image_Title_Offset-Image_Frame_Offset-Layer_Horizontal_Offset)/2, CGFLOAT_MAX) limitedToNumberOfLines:1];
    namelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Name_Offeset, Image_Frame_Offset+Title_Name_Offset+titlelabel.frame.size.height+Title_Name_Offset-Title_Name_For_Center_Offset, namesize.size.width, namesize.size.height);
    [layerbutton addSubview:namelabel];
}

- (void)addDate:(NSString *)Date{  // add a date to the post
    datelabel = [[UILabel alloc]init];
    datelabel.font = [UIFont systemFontOfSize:10.0f];
    datelabel.numberOfLines = 1;
    datelabel.text = Date;
    datelabel.textColor = UIColorFromRGB(0x898989);
    datelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect datesize = [datelabel textRectForBounds:CGRectMake(0, 0, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset-Image_Frame_Offset-Image_Frame-Image_Title_Offset-Title_Max_Frame-Date_Frame_Offset-Date_Title_Offset, CGFLOAT_MAX) limitedToNumberOfLines:1];
    datelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Title_Offset+Title_Max_Frame+Date_Frame_Offset+Date_Title_Offset, Date_Frame_Offset, datesize.size.width, datesize.size.height);
    [layerbutton addSubview:datelabel];
    
}

- (void)addContent:(NSString *)Content{ // add a content to the post
    contentlabel = [[UILabel alloc]init];
    contentlabel.font = [UIFont fontWithName:Content_Font size:14.0f];
    contentlabel.numberOfLines = 0;
    contentlabel.text = Content;
    datelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect contentsize = [contentlabel textRectForBounds:CGRectMake(0, 0, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset-Image_Frame_Offset-Image_Frame_Offset, CGFLOAT_MAX) limitedToNumberOfLines:9999];
    contentlabel.frame = CGRectMake(Image_Frame_Offset, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset, contentsize.size.width, contentsize.size.height);
    [layerbutton addSubview:contentlabel];
    [self addUnderLineToButtom];
}

- (void)addinterestlabel{ // add like label
    interestlabel = [[UILabel alloc]init];
    interestlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    interestlabel.textColor = UIColorFromRGB(0x898989);
    interestlabel.numberOfLines = 1;
    interestlabel.text = [NSString stringWithFormat:@"Like"];
    interestlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect interestsize = [interestlabel textRectForBounds:CGRectMake(0, 0, Interest_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    interestlabel.frame = CGRectMake(layerbutton.frame.size.width/2-interestsize.size.width/2, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, interestsize.size.width, interestsize.size.height);
    [layerbutton addSubview:interestlabel];
}

- (void)addlikeNum:(NSString *)num{ // add like num
    likenum = [[UILabel alloc]init];
    likenum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    likenum.textColor = UIColorFromRGB(0x898989);
    likenum.numberOfLines = 1;
    likenum.text = num;
    likenum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect likenumsize = [likenum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    likenum.frame = CGRectMake( interestlabel.frame.origin.x-Num_Element_Offset-likenumsize.size.width, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, likenumsize.size.width, likenumsize.size.height);
    [layerbutton addSubview:likenum];
}

- (void)addread{ // add read label
    readlabel = [[UILabel alloc]init];
    readlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    readlabel.textColor = UIColorFromRGB(0x898989);
    readlabel.numberOfLines = 1;
    readlabel.text = [NSString stringWithFormat:@"Read"];
    readlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect readsize = [readlabel textRectForBounds:CGRectMake(0, 0, Read_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    readlabel.frame = CGRectMake(layerbutton.frame.size.width/7-readlabel.frame.size.width/2, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, readsize.size.width, readsize.size.height);
    [layerbutton addSubview:readlabel];
}

- (void)addReadNum:(NSString *)num{ // add read num
    readnum = [[UILabel alloc]init];
    readnum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    readnum.textColor = UIColorFromRGB(0x898989);
    readnum.numberOfLines = 1;
    readnum.text = num;
    readnum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect readnumsize = [readnum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    readnum.frame = CGRectMake( readlabel.frame.origin.x-Num_Element_Offset-readnumsize.size.width, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, readnumsize.size.width, readnumsize.size.height);
    [layerbutton addSubview:readnum];
}

- (void)addcommentlabel{ // add Comment Label
    commentlabel = [[UILabel alloc]init];
    commentlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    commentlabel.textColor = UIColorFromRGB(0x898989);
    commentlabel.numberOfLines = 1;
    commentlabel.text = [NSString stringWithFormat:@"Comment"];
    commentlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect commentsize = [commentlabel textRectForBounds:CGRectMake(0, 0, Comment_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    commentlabel.frame = CGRectMake(layerbutton.frame.size.width-Comment_Max_Frame-Comment_Offset, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, commentsize.size.width, commentsize.size.height);
    [layerbutton addSubview:commentlabel];
}

- (void)addCommentNum:(NSString *)num{ // add Comment Num
    CommentNum = [[UILabel alloc]init];
    CommentNum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    CommentNum.textColor = UIColorFromRGB(0x898989);
    CommentNum.numberOfLines = 1;
    CommentNum.text = num;
    CommentNum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect commentnumsize = [CommentNum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    CommentNum.frame = CGRectMake( commentlabel.frame.origin.x-Num_Element_Offset-commentnumsize.size.width, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset, commentnumsize.size.width, commentnumsize.size.height);
    [layerbutton addSubview:CommentNum];
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

- (void)addUnderLineToNameLabel{ // add line to name label
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, titlelabel.frame.size.height-1, titlelabel.frame.size.width, 1)];
    underline.backgroundColor = [UIColor blackColor];
    [titlelabel addSubview:underline];
}

- (void)addUnderLineToButtom{ // add line to buttom
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, Image_Frame_Offset+titlelabel.frame.size.height+Title_Name_Offset+namelabel.frame.size.height+Content_Name_Offset+contentlabel.frame.size.height+Content_Buttom_Offset-1, layerbutton.frame.size.width, 1)];
    underline.backgroundColor = [UIColor blackColor];
    [layerbutton addSubview:underline];
}

+ (CGFloat)HeightForCellWithContent:(NSString *)content andTitle:(NSString *)title{
    UILabel *test1 = [[UILabel alloc]init];
    test1.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
    test1.text = content;
    test1.numberOfLines = 0;
    test1.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect test1size = [test1 textRectForBounds:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width-Layer_Horizontal_Offset-Layer_Horizontal_Offset-Image_Frame_Offset-Image_Frame_Offset, CGFLOAT_MAX) limitedToNumberOfLines:9999];
    UILabel *test2 = [[UILabel alloc]init];
    test2.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0f];
    test2.text = title;
    test2.numberOfLines = 0;
    test2.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect test2size = [test2 textRectForBounds:CGRectMake(0, 0, Title_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:2];
    return ALL_HEIGHT+test2size.size.height+test1size.size.height;
}




@end
