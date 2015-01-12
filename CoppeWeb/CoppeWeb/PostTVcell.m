//
//  PostTVcell.m
//  AutoEx
//
//  Created by Yicheng Wang on 1/9/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "PostTVcell.h"


#pragma mark - init

float ViewHeight;

@implementation PostTVcell


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}


#pragma mark - Custom


- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.frame = CGRectMake(Profile_Position_Offest, Profile_Position_Offest, Profile_frame, Profile_frame);
}


@end
