//
//  ConvertibleDate.m
//  CvtDate
//
//  Created by Yicheng Wang on 12/30/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "ConvertibleDate.h"

@implementation ConvertibleDate

- (NSInteger)TimeDifference{
    NSDate *localdate = [self LocalDate];
    NSDate *GMTdate = self;
    NSTimeInterval distanceBetweenDates = [localdate timeIntervalSinceDate:GMTdate];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    return hoursBetweenDates;
}

- (NSDate *)LocalDate{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    NSDate *today = [NSDate dateWithTimeInterval: seconds sinceDate: self];
    return today;
}




@end
