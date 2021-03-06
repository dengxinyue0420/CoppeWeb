//
//  customTextField.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "customTextField.h"

@implementation customTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
