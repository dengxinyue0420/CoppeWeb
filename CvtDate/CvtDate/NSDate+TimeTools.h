//
//  NSDate+TimeTools.h
//  CvtDate
//
//  Created by Yicheng Wang on 12/30/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeTools)

- (NSInteger)TimeDifference;

- (NSDate *)LocalDate;

- (NSString *)GMTString;

- (NSArray *)TimeArrayFromTimeString:(NSString *)time;

@end
