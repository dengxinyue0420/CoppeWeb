//
//  PostTVCell.m
//  CoppeWeb
//
//  Created by Yicheng Wang on 1/12/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "PostTVCell.h"

NSString *Title_Font = @"HelveticaNeue-CondensedBold";
NSString *Content_Font = @"Arial-BoldMT";
NSString *Buttom_Font =@"Arial-BoldMT";

CGFloat LayerHeight;

@implementation PostTVCell

#pragma mark - Initializations

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.All_Screen_Width = [[UIScreen mainScreen]bounds].size.width;
    self.layerbutton = [[UIButton alloc]init];
    [self addSubview:self.layerbutton];
    self.imagebutton = [[UIButton alloc]init];
    [self.layerbutton addSubview:self.imagebutton];
    self.titlelabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.titlelabel];
    self.namelabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.namelabel];
    self.datelabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.datelabel];
    self.contentlabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.contentlabel];
    self.interestlabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.interestlabel];
     self.likenum = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.likenum];
    self.readlabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.readlabel];
    self.readnum = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.readnum];
    self.commentlabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.commentlabel];
    self.CommentNum = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.CommentNum];
    self.image1 = [[UIImageView alloc]init];
    [self.layerbutton addSubview:self.image1];
    self.image2 = [[UIImageView alloc]init];
    [self.layerbutton addSubview:self.image2];
    self.image3 = [[UIImageView alloc]init];
    [self.layerbutton addSubview:self.image3];
    self.moreimagelabel = [[UILabel alloc]init];
    [self.layerbutton addSubview:self.moreimagelabel];
    return self;
}


- (void)initwithColor:(UIColor *)color Image:(UIImage *)image Title:(NSString *)title Name:(NSString *)name Date:(NSString *)date Content:(NSString *)content read:(NSString *)read like:(NSString *)like comment:(NSString *)comment ButtomImages:(NSArray *)imagearrary{
    LayerHeight = [PostTVCell HeightForCellWithContent:content andTitle:title];
    [self initLayerButtonWithColor:color];
    [self initImageButtonWithImage:image];
    [self addTitle:title];
    [self addName:name];
    [self addDate:date];
    [self addContent:content];
    [self addImages:imagearrary];
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
    self.layerbutton.frame = CGRectMake(Layer_Horizontal_Offset, Layer_Space_Offset, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset, LayerHeight-Layer_Space_Offset-Layer_Space_Offset);
    self.layerbutton.backgroundColor = color;
    self.layerbutton.layer.cornerRadius = 20.0f;
    self.layerbutton.userInteractionEnabled = YES;
    [self.layerbutton addTarget:self
                    action:@selector(layerButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)initImageButtonWithImage:(UIImage *)im{ // init image button
    self.imagebutton.frame = CGRectMake(Image_Frame_Offset, Image_Frame_Offset, Image_Frame, Image_Frame);
    CALayer *layer = self.imagebutton.layer;
    [layer setCornerRadius:Image_Frame/2];
    [layer setMasksToBounds:YES];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Image_Frame, Image_Frame)];
    image.image = im;
    [self.imagebutton addSubview:image];
    [self.imagebutton addTarget:self
                    action:@selector(imageButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTitle:(NSString *)Title{ // add a title to the post
    self.titlelabel.font = [UIFont fontWithName:Title_Font size:20.0f];
    self.titlelabel.numberOfLines = 0;
    self.titlelabel.text = Title;
    self.titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labelsize = [self.titlelabel textRectForBounds:CGRectMake(0, 0, Title_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:2];
    self.titlelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Title_Offset, Image_Frame_Offset-Title_Name_For_Center_Offset, labelsize.size.width, labelsize.size.height);
}

- (void)addName:(NSString *)Name{ // add a name to the post.
    self.namelabel.font = [UIFont systemFontOfSize:12.0f];
    self.namelabel.numberOfLines = 1;
    self.namelabel.text = [NSString stringWithFormat:@"From %@",Name];
    self.namelabel.textColor = UIColorFromRGB(0x898989);
    self.namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect namesize = [self.namelabel textRectForBounds:CGRectMake(0, 0, (self.All_Screen_Width-Layer_Horizontal_Offset-Image_Frame-Image_Title_Offset-Image_Frame_Offset-Layer_Horizontal_Offset)/2, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.namelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Name_Offeset, Image_Frame_Offset+Title_Name_Offset+self.titlelabel.frame.size.height+Title_Name_Offset-Title_Name_For_Center_Offset, namesize.size.width, namesize.size.height);
}

- (void)addDate:(NSString *)Date{  // add a date to the post
    self.datelabel.font = [UIFont systemFontOfSize:10.0f];
    self.datelabel.numberOfLines = 1;
    self.datelabel.text = Date;
    self.datelabel.textColor = UIColorFromRGB(0x898989);
    self.datelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect datesize = [self.datelabel textRectForBounds:CGRectMake(0, 0, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset-Image_Frame_Offset-Image_Frame-Image_Title_Offset-Title_Max_Frame-Date_Frame_Offset-Date_Title_Offset, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.datelabel.frame = CGRectMake(Image_Frame_Offset+Image_Frame+Image_Title_Offset+Title_Max_Frame+Date_Frame_Offset+Date_Title_Offset, Date_Frame_Offset, datesize.size.width, datesize.size.height);
    
}

- (void)addContent:(NSString *)Content{ // add a content to the post
    self.contentlabel.font = [UIFont fontWithName:Content_Font size:14.0f];
    self.contentlabel.numberOfLines = 0;
    self.contentlabel.text = Content;
    self.datelabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect contentsize = [self.contentlabel textRectForBounds:CGRectMake(0, 0, self.All_Screen_Width-Layer_Horizontal_Offset-Layer_Horizontal_Offset-Image_Frame_Offset-Image_Frame_Offset, CGFLOAT_MAX) limitedToNumberOfLines:9999];
    self.contentlabel.frame = CGRectMake(Image_Frame_Offset, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset, contentsize.size.width, contentsize.size.height);
}

- (void)addImages:(NSArray *)imagearray{ // add buttom images
    NSArray *images = [[NSArray alloc]initWithArray:imagearray];
    if([images count]==1){
        UIImage *image = images[0];
        CGFloat offset = (self.All_Screen_Width-2*Layer_Horizontal_Offset-3*ButtomImages_Frame)/4;
        self.image1.frame = CGRectMake(offset, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image1.contentMode = UIViewContentModeScaleToFill;
        self.image1.layer.cornerRadius = 10.0f;
        self.image1.image = image;
    }
    if([images count]==2){
        UIImage *images1 = images[0];
        CGFloat offset = (self.All_Screen_Width-2*Layer_Horizontal_Offset-3*ButtomImages_Frame)/4;
        self.image1.frame = CGRectMake(offset, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image1.contentMode = UIViewContentModeScaleToFill;
        self.image1.image = images1;
        
        UIImage *images2 = images[1];
        self.image2.frame = CGRectMake(2*offset+ButtomImages_Frame, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image2.contentMode = UIViewContentModeScaleToFill;
        self.image2.image = images2;
    }
    if([images count]==3){
        UIImage *images1 = images[0];
        CGFloat offset = (self.All_Screen_Width-2*Layer_Horizontal_Offset-3*ButtomImages_Frame)/4;
        self.image1.frame = CGRectMake(offset, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image1.contentMode = UIViewContentModeScaleToFill;
        self.image1.image = images1;
        
        UIImage *images2 = images[1];
        self.image2.frame = CGRectMake(2*offset+ButtomImages_Frame, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image2.contentMode = UIViewContentModeScaleToFill;
        self.image2.image = images2;
        
        UIImage *images3 = images[2];
        self.image3.frame = CGRectMake(3*offset+2*ButtomImages_Frame, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image3.contentMode = UIViewContentModeScaleToFill;
        self.image3.image = images3;
    }
    if([images count]>3){
        UIImage *images1 = images[0];
        CGFloat offset = (self.All_Screen_Width-2*Layer_Horizontal_Offset-3*ButtomImages_Frame)/4;
        self.image1.frame = CGRectMake(offset, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image1.contentMode = UIViewContentModeScaleToFill;
        self.image1.image = images1;
        
        UIImage *images2 = images[1];
        self.image2.frame = CGRectMake(2*offset+ButtomImages_Frame, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image2.contentMode = UIViewContentModeScaleToFill;
        self.image2.image = images2;
        
        UIImage *images3 = images[2];
        self.image3.frame = CGRectMake(3*offset+2*ButtomImages_Frame, self.contentlabel.frame.origin.y+Content_Image_Offset+self.contentlabel.frame.size.height, ButtomImages_Frame, ButtomImages_Frame);
        self.image3.contentMode = UIViewContentModeScaleToFill;
        self.image3.image = images3;
        
        NSInteger morenum = [images count]-3;
        self.moreimagelabel.text = [NSString stringWithFormat:@"%ld MORE",morenum];
        self.moreimagelabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
        self.moreimagelabel.textColor = [UIColor blackColor];
        self.moreimagelabel.numberOfLines = 1;
        self.moreimagelabel.alpha = 0.4f;
        self.moreimagelabel.textAlignment = NSTextAlignmentCenter;
        self.moreimagelabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGRect moreimagesize = [self.moreimagelabel textRectForBounds:CGRectMake(0, 0, 100, CGFLOAT_MAX) limitedToNumberOfLines:1];
        self.moreimagelabel.backgroundColor = UIColorFromRGB(0x898989);
        self.moreimagelabel.layer.masksToBounds = YES;
        self.moreimagelabel.layer.cornerRadius = 5.0f;
        self.moreimagelabel.frame = CGRectMake(self.layerbutton.frame.size.width/2-moreimagesize.size.width/2-3, self.image1.frame.origin.y+ButtomImages_Frame+ButtomImages_More_Offset, moreimagesize.size.width+6, moreimagesize.size.height);
    }
    [self addUnderLineToButtom];
}

- (void)addinterestlabel{ // add like label
    self.interestlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.interestlabel.textColor = UIColorFromRGB(0x898989);
    self.interestlabel.numberOfLines = 1;
    self.interestlabel.text = [NSString stringWithFormat:@"Like"];
    self.interestlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect interestsize = [self.interestlabel textRectForBounds:CGRectMake(0, 0, Interest_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.interestlabel.frame = CGRectMake(self.layerbutton.frame.size.width/2-interestsize.size.width/2, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, interestsize.size.width, interestsize.size.height);
}

- (void)addlikeNum:(NSString *)num{ // add like num
    self.likenum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.likenum.textColor = UIColorFromRGB(0x898989);
    self.likenum.numberOfLines = 1;
    self.likenum.text = num;
    self.likenum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect likenumsize = [self.likenum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.likenum.frame = CGRectMake(self.interestlabel.frame.origin.x-Num_Element_Offset-likenumsize.size.width, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, likenumsize.size.width, likenumsize.size.height);
}

- (void)addread{ // add read label
    self.readlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.readlabel.textColor = UIColorFromRGB(0x898989);
    self.readlabel.numberOfLines = 1;
    self.readlabel.text = [NSString stringWithFormat:@"Read"];
    self.readlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect readsize = [self.readlabel textRectForBounds:CGRectMake(0, 0, Read_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.readlabel.frame = CGRectMake(self.layerbutton.frame.size.width/7, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, readsize.size.width, readsize.size.height);
}

- (void)addReadNum:(NSString *)num{ // add read num
    self.readnum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.readnum.textColor = UIColorFromRGB(0x898989);
    self.readnum.numberOfLines = 1;
    self.readnum.text = num;
    self.readnum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect readnumsize = [self.readnum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.readnum.frame = CGRectMake( self.readlabel.frame.origin.x-Num_Element_Offset-readnumsize.size.width, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, readnumsize.size.width, readnumsize.size.height);
}

- (void)addcommentlabel{ // add Comment Label
    self.commentlabel.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.commentlabel.textColor = UIColorFromRGB(0x898989);
    self.commentlabel.numberOfLines = 1;
    self.commentlabel.text = [NSString stringWithFormat:@"Comment"];
    self.commentlabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect commentsize = [self.commentlabel textRectForBounds:CGRectMake(0, 0, Comment_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.commentlabel.frame = CGRectMake(self.layerbutton.frame.size.width-Comment_Max_Frame-Comment_Offset, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, commentsize.size.width, commentsize.size.height);
}

- (void)addCommentNum:(NSString *)num{ // add Comment Num
    self.CommentNum.font = [UIFont fontWithName:Buttom_Font size:12.0f];
    self.CommentNum.textColor = UIColorFromRGB(0x898989);
    self.CommentNum.numberOfLines = 1;
    self.CommentNum.text = num;
    self.CommentNum.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect commentnumsize = [self.CommentNum textRectForBounds:CGRectMake(0, 0, LikeNum_Max_Frame, CGFLOAT_MAX) limitedToNumberOfLines:1];
    self.CommentNum.frame = CGRectMake( self.commentlabel.frame.origin.x-Num_Element_Offset-commentnumsize.size.width, Image_Frame_Offset+self.titlelabel.frame.size.height+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset+Line_Buttom_Offset+Content_Image_Offset+ButtomImages_Frame+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, commentnumsize.size.width, commentnumsize.size.height);
}


#pragma mark - Actions and Segue.

- (void)layerButtonTapped:(UIButton *)buttontapped{ // layer tapped action
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.001,1.001)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(3, 3)];
    sprintAnimation.springBounciness = 10.f;
    [sprintAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished){
        POPSpringAnimation *animat = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        animat.toValue = [NSValue valueWithCGPoint:CGPointMake(1/1.001, 1/1.001)];
        animat.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
        animat.springBounciness = 20.f;
        [buttontapped pop_addAnimation:animat forKey:@"springAnimation"];
        UITableView *tv = (UITableView *) self.superview.superview;
        UITableViewController *vc = (UITableViewController *) tv.dataSource;
        [vc performSegueWithIdentifier:@"showpost" sender:vc];
    }];
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
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, self.titlelabel.frame.size.height-1, self.titlelabel.frame.size.width, 1)];
    underline.backgroundColor = [UIColor blackColor];
    [self.titlelabel addSubview:underline];
}

- (void)addUnderLineToButtom{ // add line to buttom
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, Image_Frame_Offset+self.titlelabel.frame.size.height+Content_Image_Offset+ButtomImages_Frame+Title_Name_Offset+self.namelabel.frame.size.height+Content_Name_Offset+self.contentlabel.frame.size.height+Content_Buttom_Offset-1+self.moreimagelabel.frame.size.height+ButtomImages_More_Offset, self.layerbutton.frame.size.width, 1)];
    underline.backgroundColor = [UIColor blackColor];
    [self.layerbutton addSubview:underline];
}

+ (CGFloat)HeightForCellWithContent:(NSString *)content andTitle:(NSString *)title{ // get the estimated height of the cell
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
    return ALL_HEIGHT+test2size.size.height+test1size.size.height+ButtomImages_Frame+Content_Image_Offset;
}



@end
